class dma_reset_sequence extends uvm_reg_sequence;

  `uvm_object_utils(dma_reset_sequence)

  dma_reg_block regmodel;

  function new(string name = "dma_reset_sequence");
    super.new(name);
  endfunction

    virtual task body();
      uvm_status_e status;
      uvm_reg regs[$];
      bit[31:0] rdata;

      if (regmodel == null)
        `uvm_fatal("DMA_RST_SEQ", "Reg model handle is null")

      regmodel.reset();

      regmodel.get_registers(regs);

      foreach (regs[i]) begin
        regs[i].read(status, rdata, UVM_BACKDOOR);

        if (rdata !== regs[i].get_reset())
          `uvm_error(regs[i].get_full_name(),$sformatf("Reset mismatch exp=0x%0h act=0x%0h",regs[i].get_reset(), rdata))
        else
          `uvm_info("DMA_RST_SEQ", $sformatf("%s reset OK: 0x%0h",regs[i].get_name(), rdata),UVM_LOW)
      end
  endtask
endclass

class dma_intr_reg_sequence extends uvm_reg_sequence;

  `uvm_object_utils(dma_intr_reg_sequence)

  dma_reg_block regmodel;

  function new(string name = "dma_intr_reg_sequence");
    super.new(name);
  endfunction

  virtual task body();
    uvm_status_e    status;
    bit[31:0] desired;
    bit[31:0] mirrored;

    if (regmodel == null)
      `uvm_fatal("DMA_INTR_SEQ", "Reg model handle is null")

    `uvm_info("DMA_INTR_SEQ", "Starting INTR register verification", UVM_LOW)

    `uvm_info("DMA_INTR_SEQ", "----------------INTR_STATUS FIELD TEST--------------------------", UVM_LOW)

    desired  = regmodel.intr_reg.intr_status.get_mirrored_value();

    regmodel.intr_reg.intr_status.set(16'hABCD);
    regmodel.intr_reg.update(status);

    mirrored = regmodel.intr_reg.intr_status.get_mirrored_value();

    if (mirrored !== desired) begin
      `uvm_error("DMA_INTR_SEQ",$sformatf("INTR_STATUS changed! before=0x%0h after=0x%0h",desired, mirrored))
      `uvm_info("DMA_INTR_SEQ","----------------INTR_STATUS FAIL--------------------------", UVM_LOW)
    end
    else begin
      `uvm_info("DMA_INTR_SEQ",$sformatf("INTR_STATUS RO behavior OK: 0x%0h", mirrored),UVM_LOW)
      `uvm_info("DMA_INTR_SEQ","----------------INTR_STATUS PASS--------------------------", UVM_LOW)
    end

    `uvm_info("DMA_INTR_SEQ", "----------------INTR_MASK FIELD TEST--------------------------", UVM_LOW)

    regmodel.intr_reg.intr_mask.set(16'hAAAA);
    regmodel.intr_reg.update(status);

    desired  = regmodel.intr_reg.intr_mask.get();
    mirrored = regmodel.intr_reg.intr_mask.get_mirrored_value();

    if (mirrored !== desired) begin
      `uvm_error("DMA_INTR_SEQ",$sformatf("INTR_MASK mismatch: desired=0x%0h mirrored=0x%0h",desired, mirrored))
      `uvm_info("DMA_INTR_SEQ","----------------INTR_MASK FAIL--------------------------", UVM_LOW)
    end
    else begin
      `uvm_info("DMA_INTR_SEQ",$sformatf("INTR_MASK RW behaviour OK: 0x%0h", mirrored),UVM_LOW)
      `uvm_info("DMA_INTR_SEQ","----------------INTR_MASK PASS--------------------------", UVM_LOW)
    end

    `uvm_info("DMA_INTR_SEQ", "INTR register verification completed", UVM_LOW)

  endtask
endclass

class dma_ctrl_reg_sequence extends uvm_reg_sequence;

  `uvm_object_utils(dma_ctrl_reg_sequence)

  dma_reg_block regmodel;

  function new(string name = "dma_ctrl_reg_sequence");
    super.new(name);
  endfunction

  virtual task body();
    uvm_status_e    status;
    bit[31:0] data;
    bit[31:0] full;
    bit[31:0] desired;
    bit[31:0] mirrored;

    if (regmodel == null)
      `uvm_fatal("DMA_CTRL_SEQ", "Reg model handle is null")

    `uvm_info("DMA_CTRL_SEQ", "Starting CTRL register verification", UVM_LOW)

    `uvm_info("DMA_CTRL_SEQ", "------------------------Testing RESERVED_FIELD--------------------------", UVM_LOW)

    regmodel.ctrl_reg.write(status, 32'hFFFF_FFFF);
    regmodel.ctrl_reg.read(status, data);

    mirrored = regmodel.ctrl_reg.get_mirrored_value();

    if (mirrored[31:17] !== '0) begin
      `uvm_error("DMA_CTRL_SEQ",$sformatf("Reserved bits RW failed: exp=0x0, act=0x%0h", mirrored[31:17]))
      `uvm_info("DMA_CTRL_SEQ", "------------------------ RESERVED_FIELD FAIL --------------------------", UVM_LOW)
    end
    else begin
      `uvm_info("DMA_CTRL_SEQ", "Reserved bits RO behavior OK", UVM_LOW)
      `uvm_info("DMA_CTRL_SEQ", "------------------------ RESERVED_FIELD PASS --------------------------", UVM_LOW)
    end

    `uvm_info("DMA_CTRL_SEQ", "------------------------Testing W_COUNT_FIELD--------------------------", UVM_LOW)

    regmodel.ctrl_reg.w_count.set(15'h1123);
    regmodel.ctrl_reg.update(status);

    desired  = regmodel.ctrl_reg.w_count.get();
    mirrored = regmodel.ctrl_reg.w_count.get_mirrored_value();

    if (mirrored !== desired) begin
      `uvm_error("DMA_CTRL_SEQ",$sformatf("W_COUNT mismatch: desired=0x%0h, mirrored=0x%0h",desired, mirrored))
      `uvm_info("DMA_CTRL_SEQ", "--------------------------- W_COUNT_FIELD FAIL ---------------------------", UVM_LOW)
    end
    else begin
      `uvm_info("DMA_CTRL_SEQ", "W_COUNT desired == mirrored OK", UVM_LOW)
      `uvm_info("DMA_CTRL_SEQ",$sformatf("W_COUNT value: 0x%0h", mirrored),UVM_LOW)
      `uvm_info("DMA_CTRL_SEQ", "--------------------------- W_COUNT_FIELD PASS ---------------------------", UVM_LOW)
    end

    `uvm_info("DMA_CTRL_SEQ", "------------------------Testing IO_MEM_FIELD--------------------------", UVM_LOW)

    regmodel.ctrl_reg.io_mem.set(1'b0);
    regmodel.ctrl_reg.update(status);

    desired  = regmodel.ctrl_reg.io_mem.get();
    mirrored = regmodel.ctrl_reg.io_mem.get_mirrored_value();

    if (mirrored !== desired) begin
      `uvm_error("DMA_CTRL_SEQ", $sformatf("IO_MEM=0 mismatch: desired=%0b, mirrored=%0b", desired, mirrored))
      `uvm_info("DMA_CTRL_SEQ", "--------------------------- IO_MEM_FIELD FAIL ---------------------------", UVM_LOW)
    end
    else begin
      `uvm_info("DMA_CTRL_SEQ", "IO_MEM=0 desired == mirrored OK", UVM_LOW)
      `uvm_info("DMA_CTRL_SEQ", "--------------------------- IO_MEM_FIELD PASS ---------------------------", UVM_LOW)
    end

    regmodel.ctrl_reg.io_mem.set(1'b1);
    regmodel.ctrl_reg.update(status);

    desired  = regmodel.ctrl_reg.io_mem.get();
    mirrored = regmodel.ctrl_reg.io_mem.get_mirrored_value();

    regmodel.ctrl_reg.read(status, full);
    `uvm_info("DMA_CTRL_SEQ",$sformatf("FULL CTRL REG = 0x%0h, io_mem(bit0)=%0b", full, full[0]),UVM_LOW)

    if (mirrored !== desired) begin
      `uvm_error("DMA_CTRL_SEQ",$sformatf("IO_MEM=1 mismatch: desired=%0b, mirrored=%0b", desired, mirrored))
      `uvm_info("DMA_CTRL_SEQ", "--------------------------- IO_MEM_FIELD FAIL ---------------------------", UVM_LOW)
    end
    else begin
      `uvm_info("DMA_CTRL_SEQ", "IO_MEM=1 desired == mirrored OK", UVM_LOW)
      `uvm_info("DMA_CTRL_SEQ", "--------------------------- IO_MEM_FIELD PASS ---------------------------", UVM_LOW)
    end

  `uvm_info("DMA_CTRL_SEQ","Testing START_DMA self-clear behavior",UVM_LOW)

  regmodel.ctrl_reg.start_dma.write(status, 1'b1);

  #20ns;

  regmodel.ctrl_reg.start_dma.read(status, data);

  if (data !== 1'b0) begin
    `uvm_error("DMA_CTRL_SEQ",$sformatf("START_DMA did not self-clear: exp=0, act=%0b", data))
    `uvm_info("DMA_CTRL_SEQ","------------------------ START_DMA SELF-CLEAR FAIL --------------------------", UVM_LOW)
  end
  else begin
    `uvm_info("DMA_CTRL_SEQ","START_DMA self-clear OK",UVM_LOW)
    `uvm_info("DMA_CTRL_SEQ","------------------------ START_DMA SELF-CLEAR PASS --------------------------", UVM_LOW)
  end

  `uvm_info("DMA_CTRL_SEQ","CTRL register verification completed",UVM_LOW)
  endtask
endclass

class dma_IO_addr_reg_sequence extends uvm_reg_sequence;

  `uvm_object_utils(dma_IO_addr_reg_sequence)

  dma_reg_block regmodel;

  function new(string name = "dma_IO_addr_reg_sequence");
    super.new(name);
  endfunction

  virtual task body();
    uvm_status_e    status;
    uvm_reg_data_t desired;
    uvm_reg_data_t mirrored;

    if (regmodel == null)
      `uvm_fatal("DMA_IO_ADDR_SEQ", "Reg model handle is null")

    `uvm_info("DMA_IO_ADDR_SEQ", "Starting IO_ADDR register verification", UVM_LOW)

    regmodel.io_addr_reg.set(32'hA5A5_A5A5);
    regmodel.io_addr_reg.update(status);

    desired  = regmodel.io_addr_reg.get();
    mirrored = regmodel.io_addr_reg.get_mirrored_value();

    if (mirrored !== desired) begin
      `uvm_error("DMA_IO_ADDR_SEQ",$sformatf("IO_ADDR mismatch: desired=0x%0h mirrored=0x%0h",desired, mirrored))
      `uvm_info("DMA_IO_ADDR_SEQ","----------------IO_ADDR REG FAIL--------------------------", UVM_LOW)
    end
    else begin
      `uvm_info("DMA_IO_ADDR_SEQ",$sformatf("IO_ADDR RW behaviour OK: 0x%0h", mirrored),UVM_LOW)
      `uvm_info("DMA_IO_ADDR_SEQ","----------------IO_ADDR REG PASS--------------------------", UVM_LOW)
    end

    `uvm_info("DMA_IO_ADDR_SEQ", "IO_ADDR register verification completed", UVM_LOW)

  endtask
endclass

class dma_mem_addr_reg_sequence extends uvm_reg_sequence;

  `uvm_object_utils(dma_mem_addr_reg_sequence)

  dma_reg_block regmodel;

  function new(string name = "dma_mem_addr_reg_sequence");
    super.new(name);
  endfunction

  virtual task body();
    uvm_status_e    status;
    uvm_reg_data_t wdata;
    uvm_reg_data_t rdata;

    if (regmodel == null)
      `uvm_fatal("DMA_MEM_ADDR_SEQ", "Reg model handle is null")

    `uvm_info("DMA_MEM_ADDR_SEQ", "Starting MEM_ADDR register verification", UVM_LOW)

    wdata = 32'h5A5A_5A5A;

    regmodel.mem_addr_reg.write(status, wdata);
    regmodel.mem_addr_reg.read(status, rdata);

    if (rdata !== wdata) begin
      `uvm_error("DMA_MEM_ADDR_SEQ", $sformatf("MEM_ADDR mismatch: exp=0x%0h act=0x%0h", wdata, rdata))
      `uvm_info("DMA_MEM_ADDR_SEQ","----------------MEM_ADDR REG FAIL--------------------------",UVM_LOW)
    end
    else begin
      `uvm_info("DMA_MEM_ADDR_SEQ",$sformatf("MEM_ADDR RW behaviour OK: 0x%0h", rdata),UVM_LOW)
      `uvm_info("DMA_MEM_ADDR_SEQ","----------------MEM_ADDR REG PASS--------------------------",UVM_LOW)
    end
    `uvm_info("DMA_MEM_ADDR_SEQ", "MEM_ADDR register verification completed", UVM_LOW)

  endtask

endclass

class dma_extra_info_reg_sequence extends uvm_reg_sequence;

  `uvm_object_utils(dma_extra_info_reg_sequence)

  dma_reg_block regmodel;

  function new(string name = "dma_extra_info_reg_sequence");
    super.new(name);
  endfunction

  virtual task body();
    uvm_status_e status;
    bit[31:0] desired;
    bit[31:0] mirrored;
    bit [31:0] write_data;
    bit [31:0] read_data;
    bit [31:0] backdoor_read_data;

    write_data = 32'hDEAD_BEEF;

    if (regmodel == null)
      `uvm_fatal("DMA_EXTRA_INFO_SEQ", "Reg model handle is null")

    `uvm_info("DMA_EXTRA_INFO_SEQ", "Starting EXTRA_INFO register verification", UVM_LOW)

    regmodel.extra_info_reg.write(status, write_data); 
    regmodel.extra_info_reg.read(status, read_data);
    regmodel.extra_info_reg.read(status, backdoor_read_data, UVM_BACKDOOR);

    desired  = regmodel.extra_info_reg.get();
    mirrored = regmodel.extra_info_reg.get_mirrored_value();

    if (mirrored !== desired) begin
      `uvm_error("DMA_EXTRA_INFO_SEQ",$sformatf("EXTRA_INFO mismatch: desired=0x%0h mirrored=0x%0h",desired, mirrored))
      `uvm_info("DMA_EXTRA_INFO_SEQ","----------------EXTRA_INFO REG FAIL--------------------------", UVM_LOW)
    end
    else begin
      `uvm_info("DMA_EXTRA_INFO_SEQ",$sformatf("EXTRA_INFO RW behaviour OK: 0x%0h", mirrored),UVM_LOW)
      `uvm_info("DMA_EXTRA_INFO_SEQ","----------------EXTRA_INFO REG PASS--------------------------", UVM_LOW)
    end

    if (read_data !== backdoor_read_data) begin
      `uvm_error("DMA_EXTRA_INFO_SEQ",$sformatf("Read data mismatch in frontdoor and backdoor: fd=0x%0h bd=0x%0h",read_data,backdoor_read_data))
    end
    else begin
      `uvm_info("DMA_EXTRA_INFO_SEQ",$sformatf("Read data matches in frontdoor and backdoor: 0x%0h", read_data),UVM_LOW)
    end
    `uvm_info("DMA_EXTRA_INFO_SEQ", "EXTRA_INFO register verification completed", UVM_LOW)

  endtask
endclass

class dma_status_reg_sequence extends uvm_reg_sequence;

  `uvm_object_utils(dma_status_reg_sequence)

  dma_reg_block regmodel;

  function new(string name = "dma_status_reg_sequence");
    super.new(name);
  endfunction

  virtual task body();
    uvm_status_e    status;
    bit[31:0] frontdoor_read_data;
    bit[31:0] backdoor_read_data;
    bit[31:0] desired;
    bit[31:0] mirrored;

    if (regmodel == null)
      `uvm_fatal("DMA_STATUS_SEQ", "Reg model handle is null")

    `uvm_info("DMA_STATUS_SEQ", "Starting STATUS register verification", UVM_LOW)

    regmodel.status_reg.read(status, backdoor_read_data, UVM_BACKDOOR);
    regmodel.status_reg.write(status, 32'hABCD_EF01);
    regmodel.status_reg.read(status, frontdoor_read_data);

    desired  = regmodel.status_reg.get();
    mirrored = regmodel.status_reg.get_mirrored_value();

    if (mirrored !== desired) begin
      `uvm_error("DMA_STATUS_SEQ",$sformatf("STATUS mismatch: desired=0x%0h mirrored=0x%0h",desired, mirrored))
      `uvm_info("DMA_STATUS_SEQ","----------------STATUS REG FAIL--------------------------", UVM_LOW)
    end
    else begin
      `uvm_info("DMA_STATUS_SEQ",$sformatf("STATUS RO behaviour OK: 0x%0h", mirrored),UVM_LOW)
      `uvm_info("DMA_STATUS_SEQ","----------------STATUS REG PASS--------------------------", UVM_LOW)
    end

    if (frontdoor_read_data !== backdoor_read_data) begin
      `uvm_error("DMA_STATUS_SEQ",$sformatf("Read data mismatch in frontdoor and backdoor: fd=0x%0h bd=0x%0h",frontdoor_read_data,backdoor_read_data))
    end
    else begin
      `uvm_info("DMA_STATUS_SEQ",$sformatf("Read data matches in frontdoor and backdoor: 0x%0h", frontdoor_read_data),UVM_LOW)
    end
  endtask
endclass

class dma_transfer_count_reg_sequence extends uvm_reg_sequence;

  `uvm_object_utils(dma_transfer_count_reg_sequence)

  dma_reg_block regmodel;

  function new(string name = "dma_transfer_count_reg_sequence");
    super.new(name);
  endfunction

  virtual task body();
    uvm_status_e    status;
    bit[31:0] frontdoor_read_data;
    bit[31:0] backdoor_read_data;
    bit[31:0] desired;
    bit[31:0] mirrored;

    if (regmodel == null)
      `uvm_fatal("DMA_TRANSFER_COUNT_SEQ", "Reg model handle is null")

    `uvm_info("DMA_TRANSFER_COUNT_SEQ", "Starting TRANSFER_COUNT register verification", UVM_LOW)

    regmodel.transfer_count_reg.read(status, backdoor_read_data, UVM_BACKDOOR);
    regmodel.transfer_count_reg.write(status, 32'h1234_5678);
    regmodel.transfer_count_reg.read(status, frontdoor_read_data);

    desired  = regmodel.transfer_count_reg.get();
    mirrored = regmodel.transfer_count_reg.get_mirrored_value();

    if (mirrored !== desired) begin
      `uvm_error("DMA_TRANSFER_COUNT_SEQ",$sformatf("TRANSFER_COUNT mismatch: desired=0x%0h mirrored=0x%0h",desired, mirrored))
      `uvm_info("DMA_TRANSFER_COUNT_SEQ","----------------TRANSFER_COUNT REG FAIL--------------------------", UVM_LOW)
    end
    else begin
      `uvm_info("DMA_TRANSFER_COUNT_SEQ",$sformatf("TRANSFER_COUNT RW behaviour OK: 0x%0h", mirrored),UVM_LOW)
      `uvm_info("DMA_TRANSFER_COUNT_SEQ","----------------TRANSFER_COUNT REG PASS--------------------------", UVM_LOW)
    end

    if (frontdoor_read_data !== backdoor_read_data) begin
      `uvm_error("DMA_TRANSFER_COUNT_SEQ",$sformatf("Read data mismatch in frontdoor and backdoor: fd=0x%0h bd=0x%0h",frontdoor_read_data,backdoor_read_data))
    end
    else begin
      `uvm_info("DMA_TRANSFER_COUNT_SEQ",$sformatf("Read data matches in frontdoor and backdoor: 0x%0h", frontdoor_read_data),UVM_LOW)
    end
  endtask
endclass

class dma_descriptor_addr_reg_sequence extends uvm_reg_sequence;

  `uvm_object_utils(dma_descriptor_addr_reg_sequence)

  dma_reg_block regmodel;

  function new(string name = "dma_descriptor_addr_reg_sequence");
    super.new(name);
  endfunction

  virtual task body();
    uvm_status_e    status;
    bit[31:0] desired;
    bit[31:0] mirrored;
    bit [31:0] frontdoor_read_data;
    bit [31:0] backdoor_read_data;
    bit [31:0] write_data;

    if (regmodel == null)
      `uvm_fatal("DMA_DESCRIPTOR_ADDR_SEQ", "Reg model handle is null")

    `uvm_info("DMA_DESCRIPTOR_ADDR_SEQ", "Starting DESCRIPTOR_ADDR register verification", UVM_LOW)

    write_data = 32'hCAFEBEEF;

    regmodel.descriptor_addr_reg.write(status, write_data); 
    regmodel.descriptor_addr_reg.read(status, frontdoor_read_data);
    regmodel.descriptor_addr_reg.read(status, backdoor_read_data, UVM_BACKDOOR);

    desired  = regmodel.descriptor_addr_reg.get();
    mirrored = regmodel.descriptor_addr_reg.get_mirrored_value();

    if (mirrored !== desired) begin
      `uvm_error("DMA_DESCRIPTOR_ADDR_SEQ",$sformatf("DESCRIPTOR_ADDR mismatch: desired=0x%0h mirrored=0x%0h",desired, mirrored))
      `uvm_info("DMA_DESCRIPTOR_ADDR_SEQ","----------------DESCRIPTOR_ADDR REG FAIL--------------------------", UVM_LOW)
    end
    else begin
      `uvm_info("DMA_DESCRIPTOR_ADDR_SEQ",$sformatf("DESCRIPTOR_ADDR RW behaviour OK: 0x%0h", mirrored),UVM_LOW)
      `uvm_info("DMA_DESCRIPTOR_ADDR_SEQ","----------------DESCRIPTOR_ADDR REG PASS--------------------------", UVM_LOW)
    end

    if (frontdoor_read_data !== backdoor_read_data) begin
      `uvm_error("DMA_DESCRIPTOR_ADDR_SEQ",$sformatf("Read data mismatch in frontdoor and backdoor: fd=0x%0h bd=0x%0h",frontdoor_read_data,backdoor_read_data))
    end
    else begin
      `uvm_info("DMA_DESCRIPTOR_ADDR_SEQ",$sformatf("Read data matches in frontdoor and backdoor: 0x%0h", frontdoor_read_data),UVM_LOW)
    end

    `uvm_info("DMA_DESCRIPTOR_ADDR_SEQ", "DESCRIPTOR_ADDR register verification completed", UVM_LOW)

  endtask
endclass

class dma_error_status_reg_sequence extends uvm_reg_sequence;

  `uvm_object_utils(dma_error_status_reg_sequence)

  dma_reg_block regmodel;

  function new(string name = "dma_error_status_reg_sequence");
    super.new(name);
  endfunction

  virtual task body();
    uvm_status_e    status;
    bit[31:0] frontdoor_read_data;
    bit[31:0] backdoor_read_data;
    bit[31:0] desired;
    bit[31:0] mirrored;

    if (regmodel == null)
      `uvm_fatal("DMA_ERROR_STATUS_SEQ", "Reg model handle is null")

    `uvm_info("DMA_ERROR_STATUS_SEQ", "Starting ERROR_STATUS register verification", UVM_LOW)

    regmodel.error_status_reg.read(status, backdoor_read_data, UVM_BACKDOOR);
    regmodel.error_status_reg.write(status, 32'h0000_001F);

    #20ns;

    regmodel.error_status_reg.read(status, frontdoor_read_data);

    desired  = regmodel.error_status_reg.get();
    mirrored = regmodel.error_status_reg.get_mirrored_value();

    if (mirrored !== desired) begin
      `uvm_error("DMA_ERROR_STATUS_SEQ",$sformatf("ERROR_STATUS mismatch: desired=0x%0h mirrored=0x%0h",desired, mirrored))
      `uvm_info("DMA_ERROR_STATUS_SEQ","----------------ERROR_STATUS REG FAIL--------------------------", UVM_LOW)
    end
    else begin
      `uvm_info("DMA_ERROR_STATUS_SEQ",$sformatf("ERROR_STATUS W1C behaviour OK: 0x%0h", mirrored),UVM_LOW)
      `uvm_info("DMA_ERROR_STATUS_SEQ","----------------ERROR_STATUS REG PASS--------------------------", UVM_LOW)
    end

    if (frontdoor_read_data !== backdoor_read_data) begin
      `uvm_error("DMA_ERROR_STATUS_SEQ",$sformatf("Read data mismatch in frontdoor and backdoor: fd=0x%0h bd=0x%0h",frontdoor_read_data,backdoor_read_data))
    end
    else begin
      `uvm_info("DMA_ERROR_STATUS_SEQ",$sformatf("Read data matches in frontdoor and backdoor: 0x%0h", frontdoor_read_data),UVM_LOW)
    end

    regmodel.error_status_reg.read(status, backdoor_read_data, UVM_BACKDOOR);
    regmodel.error_status_reg.write(status, 32'hFFFF_FFE0);
    regmodel.error_status_reg.read(status, frontdoor_read_data);

    desired  = regmodel.error_status_reg.get();
    mirrored = regmodel.error_status_reg.get_mirrored_value();

    if (mirrored !== desired) begin
      `uvm_error("DMA_ERROR_STATUS_SEQ",$sformatf("ERROR_STATUS mismatch after RO test: desired=0x%0h mirrored=0x%0h",desired, mirrored))
      `uvm_info("DMA_ERROR_STATUS_SEQ","----------------ERROR_STATUS REG FAIL--------------------------", UVM_LOW)
    end
    else begin
      `uvm_info("DMA_ERROR_STATUS_SEQ",$sformatf("ERROR_STATUS RO behaviour OK after second write: 0x%0h", mirrored),UVM_LOW)
      `uvm_info("DMA_ERROR_STATUS_SEQ","----------------ERROR_STATUS REG PASS--------------------------", UVM_LOW)
    end

    `uvm_info("DMA_ERROR_STATUS_SEQ", "ERROR_STATUS register verification completed", UVM_LOW)

  endtask
endclass

class dma_config_reg_sequence extends uvm_reg_sequence;

  `uvm_object_utils(dma_config_reg_sequence)

  dma_reg_block regmodel;

  function new(string name = "dma_config_reg_sequence");
    super.new(name);
  endfunction

  virtual task body();
    uvm_status_e    status;
    bit[31:0] frontdoor_read_data;
    bit[31:0] backdoor_read_data;
    bit[31:0] desired;
    bit[31:0] mirrored;

    if (regmodel == null)
      `uvm_fatal("DMA_CONFIG_SEQ", "Reg model handle is null")

    `uvm_info("DMA_CONFIG_SEQ", "Starting CONFIG register verification", UVM_LOW)

    regmodel.config_reg_reg.write(status, 32'hFFFF_FFCA);
    regmodel.config_reg_reg.read(status,frontdoor_read_data);
    regmodel.config_reg_reg.read(status, backdoor_read_data, UVM_BACKDOOR);

    desired  = regmodel.config_reg_reg.get();
    mirrored = regmodel.config_reg_reg.get_mirrored_value();

    if (mirrored !== desired) begin
      `uvm_error("DMA_CONFIG_SEQ",$sformatf("CONFIG_REG mismatch: desired=0x%0h mirrored=0x%0h",desired, mirrored))
      `uvm_info("DMA_CONFIG_SEQ","----------------CONFIG REG FAIL--------------------------", UVM_LOW)
    end
    else begin
      `uvm_info("DMA_CONFIG_SEQ",$sformatf("CONFIG REG RW/RO behaviour OK: 0x%0h", mirrored),UVM_LOW)
      `uvm_info("DMA_CONFIG_SEQ","----------------CONFIG REG PASS--------------------------", UVM_LOW)
    end

    if (frontdoor_read_data !== backdoor_read_data) begin
      `uvm_error("DMA_CONFIG_SEQ",$sformatf("Read data mismatch in frontdoor and backdoor: fd=0x%0h bd=0x%0h",frontdoor_read_data,backdoor_read_data))
    end
    else begin
      `uvm_info("DMA_CONFIG_SEQ",$sformatf("Read data matches in frontdoor and backdoor: 0x%0h", frontdoor_read_data),UVM_LOW)
    end

    `uvm_info("DMA_CONFIG_SEQ", "CONFIG register verification completed", UVM_LOW)

  endtask
endclass

class dma_regression_sequence extends uvm_sequence;

  `uvm_object_utils(dma_regression_sequence)

  dma_reg_block regmodel;

  function new(string name = "dma_regression_sequence");
    super.new(name);
  endfunction

  virtual task body();

    if (regmodel == null)
      `uvm_fatal("DMA_REGRESSION_SEQ", "Reg model handle is null")

    `uvm_info("DMA_REGRESSION_SEQ","================ DMA REGISTER REGRESSION START ================",UVM_LOW)

    begin
      dma_reset_sequence rst_seq;
      rst_seq = dma_reset_sequence::type_id::create("rst_seq");
      rst_seq.regmodel = regmodel;
      rst_seq.start(null);
    end

    begin
      dma_ctrl_reg_sequence ctrl_seq;
      ctrl_seq = dma_ctrl_reg_sequence::type_id::create("ctrl_seq");
      ctrl_seq.regmodel = regmodel;
      ctrl_seq.start(null);
    end

    begin
      dma_intr_reg_sequence intr_seq;
      intr_seq = dma_intr_reg_sequence::type_id::create("intr_seq");
      intr_seq.regmodel = regmodel;
      intr_seq.start(null);
    end

    begin
      dma_IO_addr_reg_sequence io_addr_seq;
      io_addr_seq = dma_IO_addr_reg_sequence::type_id::create("io_addr_seq");
      io_addr_seq.regmodel = regmodel;
      io_addr_seq.start(null);
    end

    begin
      dma_mem_addr_reg_sequence mem_addr_seq;
      mem_addr_seq = dma_mem_addr_reg_sequence::type_id::create("mem_addr_seq");
      mem_addr_seq.regmodel = regmodel;
      mem_addr_seq.start(null);
    end

    begin
      dma_descriptor_addr_reg_sequence desc_addr_seq;
      desc_addr_seq =
        dma_descriptor_addr_reg_sequence::type_id::create("desc_addr_seq");
      desc_addr_seq.regmodel = regmodel;
      desc_addr_seq.start(null);
    end

    begin
      dma_extra_info_reg_sequence extra_seq;
      extra_seq = dma_extra_info_reg_sequence::type_id::create("extra_seq");
      extra_seq.regmodel = regmodel;
      extra_seq.start(null);
    end

    begin
      dma_status_reg_sequence status_seq;
      status_seq = dma_status_reg_sequence::type_id::create("status_seq");
      status_seq.regmodel = regmodel;
      status_seq.start(null);
    end

    begin
      dma_transfer_count_reg_sequence tc_seq;
      tc_seq = dma_transfer_count_reg_sequence::type_id::create("tc_seq");
      tc_seq.regmodel = regmodel;
      tc_seq.start(null);
    end

    begin
      dma_error_status_reg_sequence err_seq;
      err_seq = dma_error_status_reg_sequence::type_id::create("err_seq");
      err_seq.regmodel = regmodel;
      err_seq.start(null);
    end

    begin
      dma_config_reg_sequence cfg_seq;
      cfg_seq = dma_config_reg_sequence::type_id::create("cfg_seq");
      cfg_seq.regmodel = regmodel;
      cfg_seq.start(null);
    end

    `uvm_info("DMA_REGRESSION_SEQ","================ DMA REGISTER REGRESSION END ==================",UVM_LOW)

  endtask

endclass
