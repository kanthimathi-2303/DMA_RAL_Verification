class dma_reset_default_test extends uvm_test;

  `uvm_component_utils(dma_reset_default_test)

  dma_environment env;
  dma_reset_sequence seq;
  dma_reg_block regmodel;

  function new(string name = "dma_reset_default_test", uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = dma_environment::type_id::create("env", this);
  endfunction

  function void end_of_elaboration();
    uvm_top.print_topology();
  endfunction

  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);

    seq = dma_reset_sequence::type_id::create("seq");
    seq.regmodel = env.regmodel;

    phase.raise_objection(this);
    `uvm_info(get_name,"STARTING RESET SEQUENCE",UVM_NONE)

    seq.start(env.agt.sequencer);

    phase.drop_objection(this);
    `uvm_info(get_name,"RESET SEQUENCE COMPLETED",UVM_NONE)
  endtask
endclass

class dma_intr_reg_test extends uvm_test;

  `uvm_component_utils(dma_intr_reg_test)

  dma_environment env;
  dma_intr_reg_sequence seq;
  dma_reg_block regmodel;

  function new(string name = "dma_intr_reg_test", uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = dma_environment::type_id::create("env", this);
  endfunction

  function void end_of_elaboration();
    uvm_top.print_topology();
  endfunction

  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);

    seq = dma_intr_reg_sequence::type_id::create("seq");
    seq.regmodel = env.regmodel;

    phase.raise_objection(this);
    `uvm_info(get_name,"STARTING INTR REG SEQUENCE",UVM_NONE)

    seq.start(env.agt.sequencer);

    phase.drop_objection(this);
    `uvm_info(get_name,"INTR REG SEQUENCE COMPLETED",UVM_NONE)
  endtask
endclass

class dma_ctrl_reg_test extends uvm_test;

  `uvm_component_utils(dma_ctrl_reg_test)

  dma_environment env;
  dma_ctrl_reg_sequence seq;
  dma_reg_block regmodel;

  function new(string name = "dma_ctrl_reg_test", uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = dma_environment::type_id::create("env", this);
  endfunction

  function void end_of_elaboration();
    uvm_top.print_topology();
  endfunction

  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);

    seq = dma_ctrl_reg_sequence::type_id::create("seq");
    seq.regmodel = env.regmodel;

    phase.raise_objection(this);
    `uvm_info(get_name,"STARTING CTRL REG SEQUENCE",UVM_NONE)

    seq.start(env.agt.sequencer);

    phase.drop_objection(this);
    `uvm_info(get_name,"CTRL REG SEQUENCE COMPLETED",UVM_NONE)
  endtask
endclass

class dma_IO_addr_reg_test extends uvm_test;

  `uvm_component_utils(dma_IO_addr_reg_test)

  dma_environment env;
  dma_IO_addr_reg_sequence seq;
  dma_reg_block regmodel;

  function new(string name = "dma_IO_addr_reg_test", uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = dma_environment::type_id::create("env", this);
  endfunction

  function void end_of_elaboration();
    uvm_top.print_topology();
  endfunction

  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);

    seq = dma_IO_addr_reg_sequence::type_id::create("seq");
    seq.regmodel = env.regmodel;

    phase.raise_objection(this);
    `uvm_info(get_name,"STARTING IO_ADDR REG SEQUENCE",UVM_NONE)

    seq.start(env.agt.sequencer);

    phase.drop_objection(this);
    `uvm_info(get_name,"IO_ADDR REG SEQUENCE COMPLETED",UVM_NONE)
  endtask
endclass

class dma_mem_addr_reg_test extends uvm_test;

  `uvm_component_utils(dma_mem_addr_reg_test)

  dma_environment env;
  dma_mem_addr_reg_sequence seq;
  dma_reg_block regmodel;

  function new(string name = "dma_mem_addr_reg_test", uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = dma_environment::type_id::create("env", this);
  endfunction

  function void end_of_elaboration();
    uvm_top.print_topology();
  endfunction

  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);

    seq = dma_mem_addr_reg_sequence::type_id::create("seq");
    seq.regmodel = env.regmodel;

    phase.raise_objection(this);
    `uvm_info(get_name,"STARTING MEM_ADDR REG SEQUENCE",UVM_NONE)

    seq.start(env.agt.sequencer);

    phase.drop_objection(this);
    `uvm_info(get_name,"MEM_ADDR REG SEQUENCE COMPLETED",UVM_NONE)
  endtask
endclass

class dma_extra_info_reg_test extends uvm_test;

  `uvm_component_utils(dma_extra_info_reg_test)

  dma_environment env;
  dma_extra_info_reg_sequence seq;
  dma_reg_block regmodel;

  function new(string name = "dma_extra_info_reg_test", uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = dma_environment::type_id::create("env", this);
  endfunction

  function void end_of_elaboration();
    uvm_top.print_topology();
  endfunction

  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);

    seq = dma_extra_info_reg_sequence::type_id::create("seq");
    seq.regmodel = env.regmodel;

    phase.raise_objection(this);
    `uvm_info(get_name,"STARTING EXTRA INFO REG SEQUENCE",UVM_NONE)

    seq.start(env.agt.sequencer);

    phase.drop_objection(this);
    `uvm_info(get_name,"EXTRA INFO REG SEQUENCE COMPLETED",UVM_NONE)
  endtask
endclass

class dma_status_reg_test extends uvm_test;

  `uvm_component_utils(dma_status_reg_test)

  dma_environment env;
  dma_status_reg_sequence seq;
  dma_reg_block regmodel;

  function new(string name = "dma_status_reg_test", uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = dma_environment::type_id::create("env", this);
  endfunction

  function void end_of_elaboration();
    uvm_top.print_topology();
  endfunction

  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);

    seq = dma_status_reg_sequence::type_id::create("seq");
    seq.regmodel = env.regmodel;

    phase.raise_objection(this);
    `uvm_info(get_name,"STARTING STATUS REG SEQUENCE",UVM_NONE)

    seq.start(env.agt.sequencer);

    phase.drop_objection(this);
    `uvm_info(get_name,"STATUS REG SEQUENCE COMPLETED",UVM_NONE)
  endtask
endclass

class dma_transfer_count_reg_test extends uvm_test;

  `uvm_component_utils(dma_transfer_count_reg_test)

  dma_environment env;
  dma_transfer_count_reg_sequence seq;
  dma_reg_block regmodel;

  function new(string name = "dma_transfer_count_reg_test", uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = dma_environment::type_id::create("env", this);
  endfunction

  function void end_of_elaboration();
    uvm_top.print_topology();
  endfunction

  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);

    seq = dma_transfer_count_reg_sequence::type_id::create("seq");
    seq.regmodel = env.regmodel;

    phase.raise_objection(this);
    `uvm_info(get_name,"STARTING TRANSFER COUNT REG SEQUENCE",UVM_NONE)
    seq.start(env.agt.sequencer);

    phase.drop_objection(this);
    `uvm_info(get_name,"TRANSFER COUNT REG SEQUENCE COMPLETED",UVM_NONE)
  endtask
endclass

class dma_descriptor_addr_reg_test extends uvm_test;

  `uvm_component_utils(dma_descriptor_addr_reg_test)

  dma_environment env;
  dma_descriptor_addr_reg_sequence seq;
  dma_reg_block regmodel;

  function new(string name = "dma_descriptor_addr_reg_test", uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = dma_environment::type_id::create("env", this);
  endfunction

  function void end_of_elaboration();
    uvm_top.print_topology();
  endfunction

  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);

    seq = dma_descriptor_addr_reg_sequence::type_id::create("seq");
    seq.regmodel = env.regmodel;

    phase.raise_objection(this);
    `uvm_info(get_name,"STARTING DESCRIPTOR ADDR REG SEQUENCE",UVM_NONE)

    seq.start(env.agt.sequencer);

    phase.drop_objection(this);
    `uvm_info(get_name,"DESCRIPTOR ADDR REG SEQUENCE COMPLETED",UVM_NONE)
  endtask
endclass

class dma_error_status_reg_test extends uvm_test;

  `uvm_component_utils(dma_error_status_reg_test)

  dma_environment env;
  dma_error_status_reg_sequence seq;
  dma_reg_block regmodel;

  function new(string name = "dma_error_status_reg_test", uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = dma_environment::type_id::create("env", this);
  endfunction

  function void end_of_elaboration();
    uvm_top.print_topology();
  endfunction

  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);

    seq = dma_error_status_reg_sequence::type_id::create("seq");
    seq.regmodel = env.regmodel;

    phase.raise_objection(this);
    `uvm_info(get_name,"STARTING ERROR STATUS REG SEQUENCE",UVM_NONE)

    seq.start(env.agt.sequencer);

    phase.drop_objection(this);
    `uvm_info(get_name,"ERROR STATUS REG SEQUENCE COMPLETED",UVM_NONE)
  endtask
endclass

class dma_config_reg_test extends uvm_test;

  `uvm_component_utils(dma_config_reg_test)

  dma_environment env;
  dma_config_reg_sequence seq;
  dma_reg_block regmodel;

  function new(string name = "dma_config_reg_test", uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = dma_environment::type_id::create("env", this);
  endfunction

  function void end_of_elaboration();
    uvm_top.print_topology();
  endfunction

  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);

    seq = dma_config_reg_sequence::type_id::create("seq");
    seq.regmodel = env.regmodel;

    phase.raise_objection(this);
    `uvm_info(get_name,"STARTING CONFIG REG SEQUENCE",UVM_NONE)

    seq.start(env.agt.sequencer);

    phase.drop_objection(this);
    `uvm_info(get_name,"CONFIG REG SEQUENCE COMPLETED",UVM_NONE)
  endtask
endclass

class dma_regression_test extends uvm_test;

  `uvm_component_utils(dma_regression_test)

  dma_environment         env;
  dma_regression_sequence seq;

  int unsigned num_iters = 1; 

  function new(string name = "dma_regression_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = dma_environment::type_id::create("env", this);
  endfunction

  function void end_of_elaboration_phase(uvm_phase phase);
    super.end_of_elaboration_phase(phase);
    uvm_top.print_topology();
  endfunction

  virtual task run_phase(uvm_phase phase);
    phase.raise_objection(this);

    `uvm_info(get_type_name(),"================ DMA REGRESSION START ================",UVM_LOW)

    repeat (num_iters) begin
      seq = dma_regression_sequence::type_id::create($sformatf("seq_%0d", num_iters));
      seq.regmodel = env.regmodel;

      `uvm_info(get_type_name(), $sformatf("Starting regression iteration %0d", num_iters),UVM_MEDIUM)

      seq.start(env.agt.sequencer);
    end

    `uvm_info(get_type_name(),"================ DMA REGRESSION END ==================",UVM_LOW)

    phase.drop_objection(this);
  endtask

endclass
