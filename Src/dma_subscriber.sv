class dma_subscriber extends uvm_subscriber #(dma_sequence_item);
    `uvm_component_utils(dma_subscriber)

    dma_sequence_item item;

    covergroup cg;
        wr_en : coverpoint item.wr_en;
        rd_en : coverpoint item.rd_en;

        addr  : coverpoint item.addr {
            bins range[] = {
                'h400,'h404,'h408,'h40C,'h410,
                'h414,'h418,'h41C,'h420,'h424
            };
        }

        wdata : coverpoint item.wdata iff (item.wr_en == 1'b1);
        rdata : coverpoint item.rdata iff (item.rd_en == 1'b1);

        wrxaddr : cross addr, wdata iff (item.wr_en == 1'b1);
        rdxaddr : cross addr, rdata iff (item.rd_en == 1'b1);
    endgroup

    function new(string name = "dma_subscriber", uvm_component parent = null);
        super.new(name, parent);
        cg = new();   
    endfunction

    virtual function void write(dma_sequence_item t);
        item = t;
        cg.sample();
    endfunction

    virtual function void extract_phase(uvm_phase phase);
        super.extract_phase(phase);
        `uvm_info(get_type_name(), $sformatf("Coverage = %0.2f%%", cg.get_coverage()), UVM_LOW)
    endfunction

    virtual function void report_phase(uvm_phase phase);
        super.report_phase(phase); `uvm_info(get_type_name(),"DMA coverage collection completed",UVM_LOW)
    endfunction

endclass
