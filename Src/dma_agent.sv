class dma_agent extends uvm_agent;

  `uvm_component_utils(dma_agent)

  dma_driver    drv;
  dma_monitor   mon;
  dma_sequencer sequencer;

  function new(string name = "dma_agent", uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		drv = dma_driver::type_id::create("drv",this);
		sequencer = dma_sequencer::type_id::create("sequencer",this);
		mon = dma_monitor::type_id::create("mon",this);
	endfunction

	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		drv.seq_item_port.connect(sequencer.seq_item_export);
	endfunction
endclass