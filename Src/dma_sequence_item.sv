class dma_sequence_item extends uvm_sequence_item;

    rand bit        wr_en;
    rand bit        rd_en;
    rand bit [31:0] wdata;
    rand bit [31:0] addr;
    bit [31:0]     rdata;

    function new(string name = "dma_sequence_item");
        super.new(name);
    endfunction

    `uvm_object_utils_begin(dma_sequence_item)
        `uvm_field_int(wr_en, UVM_ALL_ON)
        `uvm_field_int(rd_en, UVM_ALL_ON)
        `uvm_field_int(wdata, UVM_ALL_ON)
        `uvm_field_int(addr, UVM_ALL_ON)
        `uvm_field_int(rdata, UVM_ALL_ON)
    `uvm_object_utils_end
endclass