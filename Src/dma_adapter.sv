class dma_reg_adapter extends uvm_reg_adapter;
  `uvm_object_utils(dma_reg_adapter)

  function new(string name = "dma_reg_adapter");
    super.new(name);
  endfunction

  // RAL → DUT (via bus transaction)
  virtual function uvm_sequence_item reg2bus(
      const ref uvm_reg_bus_op rw
  );
    dma_sequence_item tr;

    tr = dma_sequence_item::type_id::create("tr");

    tr.addr  = rw.addr;

    if (rw.kind == UVM_WRITE) begin
      tr.wr_en = 1;
      tr.rd_en = 0;
      tr.wdata = rw.data;
    end
    else begin
      tr.wr_en = 0;
      tr.rd_en = 1;
    end

    return tr;
  endfunction

  // DUT → RAL (from monitor)
  virtual function void bus2reg(
      uvm_sequence_item bus_item,
      ref uvm_reg_bus_op rw
  );
    dma_sequence_item tr;

    if (!$cast(tr, bus_item)) begin
      `uvm_fatal("DMA_ADAPTER", "Failed to cast bus_item")
    end

    rw.addr = tr.addr;

    if (tr.wr_en) begin
      rw.kind   = UVM_WRITE;
      rw.data   = tr.wdata;
      rw.status = UVM_IS_OK;
    end
    else begin
      rw.kind   = UVM_READ;
      rw.data   = tr.rdata;
      rw.status = UVM_IS_OK;
    end
  endfunction
endclass
