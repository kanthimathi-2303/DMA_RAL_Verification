class dma_monitor extends uvm_monitor;
    `uvm_component_utils(dma_monitor)

    virtual dma_if vif;
    dma_sequence_item tr;
    uvm_analysis_port #(dma_sequence_item) mon_ap;

    function new(string name, uvm_component parent);
        super.new(name, parent);
        mon_ap = new("mon_ap", this);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db#(virtual dma_if)::get(this,"","vif",vif)) begin
        `uvm_fatal("NO_VIF","No virtual interface found for MONITOR instance")
        end
    endfunction

    virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);

    forever begin
        @(vif.mon_cb);

        if (vif.rst_n === 1'b0)
        continue;

        if (vif.wr_en || vif.rd_en)
        sample();
    end
    endtask


    task sample();
        tr = dma_sequence_item::type_id::create("tr", this);
        tr.wr_en = vif.wr_en;
        tr.rd_en = vif.rd_en;
        tr.wdata = vif.wdata;
        tr.addr  = vif.addr;
        tr.rdata = vif.rdata;

        `uvm_info("DMA_MONITOR", $sformatf("Monitoring transaction: ADDR=0x%0h, WRITE=%0b, READ=%0b, WDATA=0x%0h, RDATA=0x%0h",
            tr.addr, tr.wr_en, tr.rd_en, tr.wdata, tr.rdata), UVM_MEDIUM)

        mon_ap.write(tr);//replace this if u get in analysis fifo in coverage 
        @(vif.mon_cb);
    endtask
endclass