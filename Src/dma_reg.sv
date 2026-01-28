//Register class definition for DMA module

//INTR Register
class intr extends uvm_reg;
    `uvm_object_utils(intr)

    rand uvm_reg_field intr_status;
    rand uvm_reg_field intr_mask;

    covergroup intr_cg;
        option.per_instance = 1;
        status_lsb: coverpoint intr_status.value[0];
        coverpoint intr_mask.value{
            bins mask[] = {[1:16'hFFFF]};
        }
    endgroup

    function new(string name = "intr");
        super.new(name, 32, UVM_CVR_FIELD_VALS);
        if (has_coverage(UVM_CVR_FIELD_VALS))
            intr_cg = new();
    endfunction

    virtual function void sample(uvm_reg_data_t data,uvm_reg_data_t byte_en,bit is_read,uvm_reg_map map);
        intr_cg.sample();
    endfunction

    virtual function void sample_values();
        super.sample_values();
        intr_cg.sample();
    endfunction

    function void build; 
    
    intr_status = uvm_reg_field::type_id::create("intr_status");   

    intr_status.configure(.parent(this), 
                     .size(16), 
                     .lsb_pos(0), 
                     .access("RO"),  
                     .volatile(1), 
                     .reset(0), 
                     .has_reset(1), 
                     .is_rand(0), 
                     .individually_accessible(1));

    intr_mask = uvm_reg_field::type_id::create("intr_mask");   
    intr_mask.configure(.parent(this), 
                     .size(16), 
                     .lsb_pos(16), 
                     .access("RW"),  
                     .volatile(0), 
                     .reset(0), 
                     .has_reset(1), 
                     .is_rand(1), 
                     .individually_accessible(1));    
    endfunction
endclass

//CTRL Register
class ctrl extends uvm_reg;
    `uvm_object_utils(ctrl)

    rand uvm_reg_field start_dma;
    rand uvm_reg_field w_count;
    rand uvm_reg_field io_mem;
    uvm_reg_field reserved;

    covergroup ctrl_cg;
        option.per_instance = 1;
        start_cp: coverpoint start_dma.value;
        w_count_cp: coverpoint w_count.value
        {
        bins w_count_bin[] = {[0:15'h7FFF]};
        }
        io_mem_cp: coverpoint io_mem.value;
    endgroup

    virtual function void sample(uvm_reg_data_t data,uvm_reg_data_t byte_en,bit is_read,uvm_reg_map map);
        ctrl_cg.sample();
    endfunction

    virtual function void sample_values();
        super.sample_values();
        ctrl_cg.sample();
    endfunction

    function new(string name = "ctrl");
        super.new(name, 32, UVM_CVR_FIELD_VALS);
        if (has_coverage(UVM_CVR_FIELD_VALS))
            ctrl_cg = new();
    endfunction

    function void build;
        start_dma = uvm_reg_field::type_id::create("start_dma");
        start_dma.configure(.parent(this), 
                         .size(1), 
                         .lsb_pos(0), 
                         .access("RW"),  
                         .volatile(0), 
                         .reset(0), 
                         .has_reset(1), 
                         .is_rand(1), 
                         .individually_accessible(0));

        w_count = uvm_reg_field::type_id::create("w_count");
        w_count.configure(.parent(this), 
                         .size(15), 
                         .lsb_pos(1), 
                         .access("RW"),  
                         .volatile(0), 
                         .reset(0), 
                         .has_reset(1), 
                         .is_rand(1), 
                         .individually_accessible(0));
        
        io_mem = uvm_reg_field::type_id::create("io_mem");
        io_mem.configure(.parent(this), 
                         .size(1), 
                         .lsb_pos(16), 
                         .access("RW"),  
                         .volatile(0), 
                         .reset(0), 
                         .has_reset(1), 
                         .is_rand(1), 
                         .individually_accessible(0));
        
        reserved = uvm_reg_field::type_id::create("reserved");
        reserved.configure(.parent(this),
                            .size(15), 
                            .lsb_pos(17), 
                            .access("RO"),  
                            .volatile(0), 
                            .reset(0), 
                            .has_reset(1), 
                            .is_rand(0), 
                            .individually_accessible(0));
    endfunction
endclass

//IO_ADDR Register
class io_addr extends uvm_reg;
    `uvm_object_utils(io_addr)

    rand uvm_reg_field io_address;

    covergroup io_addr_cg;
        option.per_instance = 1;
        addr_cp: coverpoint io_address.value{
            bins addr_bins[20] = {[0:32'hFFFFFFFF]};
        }
    endgroup

    function new(string name = "io_addr");
        super.new(name, 32, UVM_CVR_FIELD_VALS);
        if (has_coverage(UVM_CVR_FIELD_VALS))
            io_addr_cg = new();
    endfunction

    virtual function void sample(uvm_reg_data_t data,uvm_reg_data_t byte_en,bit is_read,uvm_reg_map map);
        io_addr_cg.sample();
    endfunction

    virtual function void sample_values();
        super.sample_values();
        io_addr_cg.sample();
    endfunction

    function void build;
        io_address = uvm_reg_field::type_id::create("io_address");
        io_address.configure(.parent(this), 
                         .size(32), 
                         .lsb_pos(0), 
                         .access("RW"),  
                         .volatile(0), 
                         .reset(0), 
                         .has_reset(1), 
                         .is_rand(1), 
                         .individually_accessible(0));
    endfunction
endclass

//MEM_ADDR Register
class mem_addr extends uvm_reg;
    `uvm_object_utils(mem_addr)

    rand uvm_reg_field mem_address;

    covergroup mem_addr_cg;
        option.per_instance = 1;
        addr_cp: coverpoint mem_address.value{
            bins addr_bins[20] = {[0:32'hFFFFFFFF]};
        }
    endgroup

    function new(string name = "mem_addr");
        super.new(name, 32, UVM_CVR_FIELD_VALS);
        if (has_coverage(UVM_CVR_FIELD_VALS))
            mem_addr_cg = new();
    endfunction

    virtual function void sample(uvm_reg_data_t data,uvm_reg_data_t byte_en,bit is_read,uvm_reg_map map);
        mem_addr_cg.sample();
    endfunction

    virtual function void sample_values();
        super.sample_values();
        mem_addr_cg.sample();
    endfunction

    function void build;
        mem_address = uvm_reg_field::type_id::create("mem_address");
        mem_address.configure(.parent(this), 
                         .size(32), 
                         .lsb_pos(0), 
                         .access("RW"),  
                         .volatile(0), 
                         .reset(0), 
                         .has_reset(1), 
                         .is_rand(1), 
                         .individually_accessible(0));
    endfunction
endclass

//EXTRA_INFO Register
class extra_info extends uvm_reg;
    `uvm_object_utils(extra_info)

    rand uvm_reg_field extra_info_field;

    covergroup extra_info_cg;
        option.per_instance = 1;
        info_cp: coverpoint extra_info_field.value{
            bins info_bins[20] = {[0:32'hFFFFFFFF]};
        }
    endgroup

    function new(string name = "extra_info");
        super.new(name, 32, UVM_CVR_FIELD_VALS);
        if (has_coverage(UVM_CVR_FIELD_VALS))
            extra_info_cg = new();
    endfunction

    virtual function void sample(uvm_reg_data_t data,uvm_reg_data_t byte_en,bit is_read,uvm_reg_map map);
        extra_info_cg.sample();
    endfunction

    virtual function void sample_values();
        super.sample_values();
        extra_info_cg.sample();
    endfunction

    function void build;
        extra_info_field = uvm_reg_field::type_id::create("extra_info_field");
        extra_info_field.configure(.parent(this), 
                         .size(32), 
                         .lsb_pos(0), 
                         .access("RW"),  
                         .volatile(0), 
                         .reset(0), 
                         .has_reset(1), 
                         .is_rand(1), 
                         .individually_accessible(0));
    endfunction
endclass

//STATUS Register
class status extends uvm_reg;
    `uvm_object_utils(status)

    rand uvm_reg_field busy;
    rand uvm_reg_field done;
    rand uvm_reg_field error;
    rand uvm_reg_field paused;
    rand uvm_reg_field current_state;
    rand uvm_reg_field fifo_level;
    uvm_reg_field reserved;

    covergroup status_cg;
        option.per_instance = 1;
        busy_cp: coverpoint busy.value;
        done_cp: coverpoint done.value;
        error_cp: coverpoint error.value;
        paused_cp: coverpoint paused.value;
        current_state_cp: coverpoint current_state.value{
            bins state_bins[] = {[0:15]};
        }
        fifo_level_cp: coverpoint fifo_level.value{
            bins level_bins[] = {[0:256]};
        }
    endgroup

    function new(string name = "status");
        super.new(name, 32, UVM_CVR_FIELD_VALS);
        if (has_coverage(UVM_CVR_FIELD_VALS))
            status_cg = new();
    endfunction

    virtual function void sample(uvm_reg_data_t data,uvm_reg_data_t byte_en,bit is_read,uvm_reg_map map);
        status_cg.sample();
    endfunction

    virtual function void sample_values();
        super.sample_values();
        status_cg.sample();
    endfunction

    function void build;
        busy = uvm_reg_field::type_id::create("busy");
        busy.configure(.parent(this), 
                         .size(1), 
                         .lsb_pos(0), 
                         .access("RO"),  
                         .volatile(1), 
                         .reset(0), 
                         .has_reset(1), 
                         .is_rand(0), 
                         .individually_accessible(0));

        done = uvm_reg_field::type_id::create("done");
        done.configure(.parent(this), 
                         .size(1), 
                         .lsb_pos(1), 
                         .access("RO"),  
                         .volatile(1), 
                         .reset(0), 
                         .has_reset(1), 
                         .is_rand(0), 
                         .individually_accessible(0));

        error = uvm_reg_field::type_id::create("error");
        error.configure(.parent(this), 
                         .size(1), 
                         .lsb_pos(2), 
                         .access("RO"),  
                         .volatile(1), 
                         .reset(0), 
                         .has_reset(1), 
                         .is_rand(0), 
                         .individually_accessible(0));

        paused = uvm_reg_field::type_id::create("paused");
        paused.configure(.parent(this), 
                         .size(1), 
                         .lsb_pos(3), 
                         .access("RO"),  
                         .volatile(1), 
                         .reset(0), 
                         .has_reset(1), 
                         .is_rand(0), 
                         .individually_accessible(0));

        current_state = uvm_reg_field::type_id::create("current_state");
        current_state.configure(.parent(this),
                                .size(4),
                                .lsb_pos(4),
                                .access("RO"),
                                .volatile(1),
                                .reset(0),
                                .has_reset(1),
                                .is_rand(0),
                                .individually_accessible(0));

        fifo_level = uvm_reg_field::type_id::create("fifo_level");
        fifo_level.configure(.parent(this),
                             .size(8),
                             .lsb_pos(8),
                             .access("RO"),
                             .volatile(1),
                             .reset(0),
                             .has_reset(1),
                             .is_rand(0),
                             .individually_accessible(0));

        reserved = uvm_reg_field::type_id::create("reserved");
        reserved.configure(.parent(this),
                            .size(16), 
                            .lsb_pos(16), 
                            .access("RO"),  
                            .volatile(0), 
                            .reset(0), 
                            .has_reset(1), 
                            .is_rand(0), 
                            .individually_accessible(0));
    endfunction
endclass

//TRANSFER_COUNT Register
class transfer_count extends uvm_reg;
    `uvm_object_utils(transfer_count)

    rand uvm_reg_field transfer_count;

    covergroup transfer_count_cg;
        option.per_instance = 1;
        count_cp: coverpoint transfer_count.value{
            bins count_bins[20] = {[0:32'hFFFFFFFF]};
        }
    endgroup

    function new(string name = "transfer_count");
        super.new(name, 32, UVM_CVR_FIELD_VALS);
        if (has_coverage(UVM_CVR_FIELD_VALS))
            transfer_count_cg = new();
    endfunction

    virtual function void sample(uvm_reg_data_t data,uvm_reg_data_t byte_en,bit is_read,uvm_reg_map map);
        transfer_count_cg.sample();
    endfunction

    virtual function void sample_values();
        super.sample_values();
        transfer_count_cg.sample();
    endfunction

    function void build;
        transfer_count = uvm_reg_field::type_id::create("transfer_count");
        transfer_count.configure(.parent(this), 
                         .size(32), 
                         .lsb_pos(0), 
                         .access("RO"),  
                         .volatile(1), 
                         .reset(0), 
                         .has_reset(1), 
                         .is_rand(0), 
                         .individually_accessible(0));
    endfunction
endclass

//DESCRIPTOR_ADDR Register
class descriptor_addr extends uvm_reg;
    `uvm_object_utils(descriptor_addr)

    rand uvm_reg_field descriptor_address;

    covergroup descriptor_addr_cg;
        option.per_instance = 1;
        addr_cp: coverpoint descriptor_address.value{
            bins addr_bins[20] = {[0:32'hFFFFFFFF]};
        }
    endgroup

    function new(string name = "descriptor_addr");
        super.new(name, 32, UVM_CVR_FIELD_VALS);
        if (has_coverage(UVM_CVR_FIELD_VALS))
            descriptor_addr_cg = new();
    endfunction

    virtual function void sample(uvm_reg_data_t data,uvm_reg_data_t byte_en,bit is_read,uvm_reg_map map);
        descriptor_addr_cg.sample();
    endfunction

    virtual function void sample_values();
        super.sample_values();
        descriptor_addr_cg.sample();
    endfunction

    function void build;
        descriptor_address = uvm_reg_field::type_id::create("descriptor_address");
        descriptor_address.configure(.parent(this), 
                         .size(32), 
                         .lsb_pos(0), 
                         .access("RW"),  
                         .volatile(0), 
                         .reset(0), 
                         .has_reset(1), 
                         .is_rand(1), 
                         .individually_accessible(0));
    endfunction
endclass

//ERROR_STATUS Register
class error_status extends uvm_reg;
    `uvm_object_utils(error_status)

    rand uvm_reg_field bus_error;
    rand uvm_reg_field timeout_error;
    rand uvm_reg_field alignment_error;
    rand uvm_reg_field overflow_error;
    rand uvm_reg_field underflow_error;
    uvm_reg_field reserved;
    rand uvm_reg_field error_code;
    rand uvm_reg_field error_address_offset;

    covergroup error_status_cg;
        option.per_instance = 1;
        bus_error_cp: coverpoint bus_error.value;
        timeout_error_cp: coverpoint timeout_error.value;
        alignment_error_cp: coverpoint alignment_error.value;
        overflow_error_cp: coverpoint overflow_error.value;
        underflow_error_cp: coverpoint underflow_error.value;
        error_code_cp: coverpoint error_code.value{
            bins code_bins[] = {[0:255]};
        }
        error_address_offset_cp: coverpoint error_address_offset.value{
            bins offset_bins[] = {[0:16'hFFFF]};
        }
    endgroup

    function new(string name = "error_status");
        super.new(name, 32, UVM_CVR_FIELD_VALS);
        if (has_coverage(UVM_CVR_FIELD_VALS))
            error_status_cg = new();
    endfunction

    virtual function void sample(uvm_reg_data_t data,uvm_reg_data_t byte_en,bit is_read,uvm_reg_map map);
        error_status_cg.sample();
    endfunction

    virtual function void sample_values();
        super.sample_values();
        error_status_cg.sample();
    endfunction

    function void build;
        bus_error = uvm_reg_field::type_id::create("bus_error");
        bus_error.configure(.parent(this),
                            .size(1), 
                            .lsb_pos(0), 
                            .access("W1C"),  
                            .volatile(1), 
                            .reset(0), 
                            .has_reset(1), 
                            .is_rand(0), 
                            .individually_accessible(0));

        timeout_error = uvm_reg_field::type_id::create("timeout_error");
        timeout_error.configure(.parent(this),
                            .size(1), 
                            .lsb_pos(1), 
                            .access("W1C"),  
                            .volatile(1), 
                            .reset(0), 
                            .has_reset(1), 
                            .is_rand(0), 
                            .individually_accessible(0));

        alignment_error = uvm_reg_field::type_id::create("alignment_error");
        alignment_error.configure(.parent(this),
                            .size(1), 
                            .lsb_pos(2), 
                            .access("W1C"),  
                            .volatile(1), 
                            .reset(0), 
                            .has_reset(1), 
                            .is_rand(0), 
                            .individually_accessible(0));

        overflow_error = uvm_reg_field::type_id::create("overflow_error");
        overflow_error.configure(.parent(this),
                            .size(1), 
                            .lsb_pos(3), 
                            .access("W1C"),  
                            .volatile(1), 
                            .reset(0), 
                            .has_reset(1), 
                            .is_rand(0), 
                            .individually_accessible(0));

        underflow_error = uvm_reg_field::type_id::create("underflow_error");
        underflow_error.configure(.parent(this),
                             .size(1), 
                             .lsb_pos(4), 
                             .access("W1C"),  
                             .volatile(1), 
                             .reset(0), 
                             .has_reset(1), 
                             .is_rand(0), 
                             .individually_accessible(0));

        reserved = uvm_reg_field::type_id::create("reserved");
        reserved.configure(.parent(this),
                            .size(3), 
                            .lsb_pos(5), 
                            .access("RO"),  
                            .volatile(0), 
                            .reset(0), 
                            .has_reset(1), 
                            .is_rand(0), 
                            .individually_accessible(0));
        
        error_code = uvm_reg_field::type_id::create("error_code");
        error_code.configure(.parent(this),
                            .size(8), 
                            .lsb_pos(8), 
                            .access("RO"),  
                            .volatile(1), 
                            .reset(0), 
                            .has_reset(1), 
                            .is_rand(0), 
                            .individually_accessible(0));
        
        error_address_offset = uvm_reg_field::type_id::create("error_address_offset");
        error_address_offset.configure(.parent(this),
                            .size(16), 
                            .lsb_pos(16), 
                            .access("RO"),  
                            .volatile(1), 
                            .reset(0), 
                            .has_reset(1), 
                            .is_rand(0), 
                            .individually_accessible(0));
    endfunction
endclass

//CONFIG Register
class config_reg extends uvm_reg;
    `uvm_object_utils(config_reg)

    rand uvm_reg_field priority_reg;
    rand uvm_reg_field auto_restart;
    rand uvm_reg_field interrupt_enable;
    rand uvm_reg_field burst_size;
    rand uvm_reg_field data_width;
    rand uvm_reg_field descriptor_mode;
    uvm_reg_field reserved;

    covergroup config_reg_cg;
        option.per_instance = 1;
        priority_cp: coverpoint priority_reg.value{
            bins priority_bins[] = {[0:3]};
        }
        auto_restart_cp: coverpoint auto_restart.value;
        interrupt_enable_cp: coverpoint interrupt_enable.value;
        burst_size_cp: coverpoint burst_size.value{
            bins burst_bins[] = {[0:3]};
        }
        data_width_cp: coverpoint data_width.value{
            bins width_bins[] = {[0:3]};
        }
        descriptor_mode_cp: coverpoint descriptor_mode.value;
    endgroup

    function new(string name = "config_reg");
        super.new(name, 32, UVM_CVR_FIELD_VALS);
        if (has_coverage(UVM_CVR_FIELD_VALS))
            config_reg_cg = new();
    endfunction

    virtual function void sample(uvm_reg_data_t data,uvm_reg_data_t byte_en,bit is_read,uvm_reg_map map);
        config_reg_cg.sample();
    endfunction

    virtual function void sample_values();
        super.sample_values();
        config_reg_cg.sample();
    endfunction

    function void build;
        priority_reg = uvm_reg_field::type_id::create("priority_reg");
        priority_reg.configure(.parent(this),
                            .size(2), 
                            .lsb_pos(0), 
                            .access("RW"),  
                            .volatile(0), 
                            .reset(0), 
                            .has_reset(1), 
                            .is_rand(1), 
                            .individually_accessible(0));
        
        auto_restart = uvm_reg_field::type_id::create("auto_restart");
        auto_restart.configure(.parent(this),
                            .size(1), 
                            .lsb_pos(2), 
                            .access("RW"),  
                            .volatile(0), 
                            .reset(0), 
                            .has_reset(1), 
                            .is_rand(1), 
                            .individually_accessible(0));
    
        interrupt_enable = uvm_reg_field::type_id::create("interrupt_enable");
        interrupt_enable.configure(.parent(this),
                            .size(1), 
                            .lsb_pos(3), 
                            .access("RW"),  
                            .volatile(0), 
                            .reset(0), 
                            .has_reset(1), 
                            .is_rand(1), 
                            .individually_accessible(0));
        
        burst_size = uvm_reg_field::type_id::create("burst_size");
        burst_size.configure(.parent(this),
                            .size(2), 
                            .lsb_pos(4), 
                            .access("RW"),  
                            .volatile(0), 
                            .reset(0), 
                            .has_reset(1), 
                            .is_rand(1), 
                            .individually_accessible(0));
        
        data_width = uvm_reg_field::type_id::create("data_width");
        data_width.configure(.parent(this),
                            .size(2), 
                            .lsb_pos(6), 
                            .access("RW"),  
                            .volatile(0), 
                            .reset(0), 
                            .has_reset(1), 
                            .is_rand(1), 
                            .individually_accessible(0));
        descriptor_mode = uvm_reg_field::type_id::create("descriptor_mode");
        descriptor_mode.configure(.parent(this),
                            .size(1), 
                            .lsb_pos(8), 
                            .access("RW"),  
                            .volatile(0), 
                            .reset(0), 
                            .has_reset(1), 
                            .is_rand(1), 
                            .individually_accessible(0));
        reserved = uvm_reg_field::type_id::create("reserved");
        reserved.configure(.parent(this),
                           .size(23),
                           .lsb_pos(9),
                           .access("RO"),
                           .volatile(0),
                           .reset(0),
                           .has_reset(1),
                           .is_rand(0),
                           .individually_accessible(0));
    endfunction
endclass