//DMA_REG_BLOCK Register Block
class dma_reg_block extends uvm_reg_block;
    `uvm_object_utils(dma_reg_block)

    rand intr            intr_reg;
    rand ctrl            ctrl_reg;
    rand io_addr         io_addr_reg;
    rand mem_addr        mem_addr_reg;
    rand extra_info      extra_info_reg;
    rand status          status_reg;
    rand transfer_count  transfer_count_reg;
    rand descriptor_addr descriptor_addr_reg;
    rand error_status    error_status_reg;
    rand config_reg      config_reg_reg;

    uvm_reg_map default_map;

    function new(string name = "dma_reg_block");
        super.new(name, UVM_NO_COVERAGE);
    endfunction

    virtual function void build();
        uvm_reg::include_coverage("*",UVM_CVR_ALL);

        default_map = create_map("default_map", 'h400, 4, UVM_LITTLE_ENDIAN,1);
        add_hdl_path ("dma_top.dut", "RTL");

        intr_reg = intr::type_id::create("intr_reg");
        intr_reg.build();
        intr_reg.configure(this);
        intr_reg.set_coverage(UVM_CVR_FIELD_VALS);
        intr_reg.add_hdl_path_slice("intr_status", 0, 16);
        intr_reg.add_hdl_path_slice("intr_mask", 16, 16);
        default_map.add_reg(intr_reg, 'h00, "RW");

        ctrl_reg = ctrl::type_id::create("ctrl_reg");
        ctrl_reg.build();
        ctrl_reg.configure(this);
        ctrl_reg.set_coverage(UVM_CVR_FIELD_VALS);
        ctrl_reg.add_hdl_path_slice("ctrl_start_dma", 0, 1);
        ctrl_reg.add_hdl_path_slice("ctrl_w_count", 1, 15);
        ctrl_reg.add_hdl_path_slice("ctrl_io_mem", 16, 1);
        default_map.add_reg(ctrl_reg, 'h04, "RW");

        io_addr_reg = io_addr::type_id::create("io_addr_reg");
        io_addr_reg.build();
        io_addr_reg.configure(this);
        io_addr_reg.set_coverage(UVM_CVR_FIELD_VALS);
        io_addr_reg.add_hdl_path_slice("io_addr", 0, 32);
        default_map.add_reg(io_addr_reg, 'h08, "RW");

        mem_addr_reg = mem_addr::type_id::create("mem_addr_reg");
        mem_addr_reg.build();
        mem_addr_reg.configure(this);
        mem_addr_reg.set_coverage(UVM_CVR_FIELD_VALS);
        mem_addr_reg.add_hdl_path_slice("mem_addr", 0, 32);
        default_map.add_reg(mem_addr_reg, 'h0C, "RW");

        extra_info_reg = extra_info::type_id::create("extra_info_reg");
        extra_info_reg.build();
        extra_info_reg.configure(this);
        extra_info_reg.set_coverage(UVM_CVR_FIELD_VALS);
        extra_info_reg.add_hdl_path_slice("extra_info", 0, 32);
        default_map.add_reg(extra_info_reg, 'h10, "RW");

        status_reg = status::type_id::create("status_reg");
        status_reg.build();
        status_reg.configure(this);
        status_reg.set_coverage(UVM_CVR_FIELD_VALS);
        status_reg.add_hdl_path_slice("status_busy", 0, 1);
        status_reg.add_hdl_path_slice("status_done", 1, 1);
        status_reg.add_hdl_path_slice("status_error", 2, 1);
        status_reg.add_hdl_path_slice("status_paused", 3, 1);
        status_reg.add_hdl_path_slice("status_current_state", 4, 4);
        status_reg.add_hdl_path_slice("status_fifo_level", 8, 8);
        default_map.add_reg(status_reg, 'h14, "RO");

        transfer_count_reg = transfer_count::type_id::create("transfer_count_reg");
        transfer_count_reg.build();
        transfer_count_reg.configure(this);
        transfer_count_reg.set_coverage(UVM_CVR_FIELD_VALS);
        transfer_count_reg.add_hdl_path_slice("transfer_count", 0, 32);
        default_map.add_reg(transfer_count_reg, 'h18, "RO");

        descriptor_addr_reg = descriptor_addr::type_id::create("descriptor_addr_reg");
        descriptor_addr_reg.build();
        descriptor_addr_reg.configure(this);
        descriptor_addr_reg.set_coverage(UVM_CVR_FIELD_VALS);
        descriptor_addr_reg.add_hdl_path_slice("descriptor_addr", 0, 32);
        default_map.add_reg(descriptor_addr_reg, 'h1C, "RW");

        error_status_reg = error_status::type_id::create("error_status_reg");
        error_status_reg.build();
        error_status_reg.configure(this);
        error_status_reg.set_coverage(UVM_CVR_FIELD_VALS);
        error_status_reg.add_hdl_path_slice("error_bus", 0, 1);
        error_status_reg.add_hdl_path_slice("error_timeout", 1,1);
        error_status_reg.add_hdl_path_slice("error_alignment", 2,1);
        error_status_reg.add_hdl_path_slice("error_overflow", 3,1);
        error_status_reg.add_hdl_path_slice("error_underflow", 4,1);
        error_status_reg.add_hdl_path_slice("error_code", 5,8);
        error_status_reg.add_hdl_path_slice("error_addr_offset", 13,16);
        default_map.add_reg(error_status_reg, 'h20, "RW");

        config_reg_reg = config_reg::type_id::create("config_reg_reg");
        config_reg_reg.build();
        config_reg_reg.configure(this);
        config_reg_reg.set_coverage(UVM_CVR_FIELD_VALS);
        config_reg_reg.add_hdl_path_slice("config_priority", 0, 2);
        config_reg_reg.add_hdl_path_slice("config_auto_restart", 2, 1);
        config_reg_reg.add_hdl_path_slice("config_interrupt_enable", 3, 1);
        config_reg_reg.add_hdl_path_slice("config_burst_size", 4, 2);
        config_reg_reg.add_hdl_path_slice("config_data_width", 6, 2);
        config_reg_reg.add_hdl_path_slice("config_descriptor_mode", 8, 1);
        default_map.add_reg(config_reg_reg, 'h24, "RW");

        lock_model();
    endfunction
endclass