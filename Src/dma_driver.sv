class dma_driver extends uvm_driver #(dma_sequence_item);
    `uvm_component_utils(dma_driver)
    
    virtual dma_if vif;
    int count; // transaction count
    
    function new(string name = "dma_driver", uvm_component parent = null);
        super.new(name, parent);
    endfunction
    
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db#(virtual dma_if)::get(this, "", "vif", vif)) begin
            `uvm_fatal("NO_VIF", "No virtual interface found for DRIVER instance")
        end
    endfunction
    
    virtual task run_phase(uvm_phase phase);
        super.run_phase(phase);
        count = 0;
        
        wait (vif.rst_n === 1'b0);
        `uvm_info("DMA_DRIVER", "Reset asserted", UVM_LOW)
        
        wait (vif.rst_n === 1'b1);
        `uvm_info("DMA_DRIVER", "Reset de-asserted, starting driver", UVM_LOW)
        
        forever begin
            seq_item_port.get_next_item(req);  
            drive_transaction(req);
            seq_item_port.item_done();
        end
    endtask
    
    virtual task drive_transaction(dma_sequence_item item);
        
        if (!item.wr_en && !item.rd_en) begin
            `uvm_warning("DMA_DRIVER", "Neither read nor write enabled in transaction - skipping")
            return;
        end
        
        if (item.wr_en) begin
            @(vif.drv_cb);
            vif.drv_cb.wr_en  <= 1'b1;
            vif.drv_cb.rd_en  <= 1'b0;
            vif.drv_cb.addr   <= item.addr;
            vif.drv_cb.wdata  <= item.wdata;
            
            `uvm_info("DMA_DRIVER", $sformatf("Driving WRITE [%0d]: ADDR=0x%0h, WDATA=0x%0h",
                      count, item.addr, item.wdata), UVM_MEDIUM)
            
            @(vif.drv_cb); 
            vif.drv_cb.wr_en <= 1'b0;
            
            count++;
        end
        else if (item.rd_en) begin

            vif.drv_cb.rd_en  <= 1'b1;
            vif.drv_cb.wr_en  <= 1'b0;
            vif.drv_cb.addr   <= item.addr;
            
            `uvm_info("DMA_DRIVER", $sformatf("Driving READ [%0d]: ADDR=0x%0h",
                      count, item.addr), UVM_MEDIUM)
            
            repeat(2)@(vif.drv_cb); 
            item.rdata = vif.drv_cb.rdata; 
            
            vif.drv_cb.rd_en <= 1'b0;
            
            `uvm_info("DMA_DRIVER", $sformatf("Read data: 0x%0h", item.rdata), UVM_MEDIUM)
            
            count++;
        end
        
    endtask
    
endclass