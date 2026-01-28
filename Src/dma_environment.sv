class dma_environment extends uvm_env;

  `uvm_component_utils(dma_environment)

  dma_reg_block regmodel;
  dma_reg_adapter adapter;
  dma_agent agt;
  dma_subscriber sub;
  uvm_reg_predictor #(dma_sequence_item) predictor_inst;

  function new(string name = "dma_environment", uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    agt = dma_agent::type_id::create("agt", this);
    sub = dma_subscriber::type_id::create("sub", this);

    uvm_config_db#(uvm_active_passive_enum) :: set(this,"agt","is_active",UVM_ACTIVE);
    adapter = dma_reg_adapter::type_id::create("adapter", this);
    regmodel = dma_reg_block::type_id::create("regmodel", this);
    predictor_inst = uvm_reg_predictor#(dma_sequence_item)::type_id::create("predictor_inst", this);
    regmodel.build();
    
  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    agt.mon.mon_ap.connect(sub.analysis_export);

    regmodel.default_map.set_sequencer( .sequencer(agt.sequencer), .adapter(adapter) );
    regmodel.default_map.set_base_addr('h400);

    predictor_inst.map= regmodel.default_map;
    predictor_inst.adapter= adapter;

    agt.mon.mon_ap.connect(predictor_inst.bus_in);

    regmodel.default_map.set_auto_predict(0);
  endfunction
endclass