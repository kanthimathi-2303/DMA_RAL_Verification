`timescale 1ns/1ns

`include "dma_if.sv"
`include "dma_design.sv"

`include "dma_pkg.sv"

module dma_top;
    import uvm_pkg::*;
    import dma_pkg::*;  
    
    bit clk;
    bit rst_n;
    
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        rst_n = 0;
        #15;
        rst_n = 1;
    end


    dma_if intf(.clk(clk), .rst_n(rst_n));

    dma_design dut(
        .clk    (clk),
        .rst_n  (intf.rst_n),
        .wr_en  (intf.wr_en),
        .rd_en  (intf.rd_en),
        .wdata  (intf.wdata),
        .addr   (intf.addr),
        .rdata  (intf.rdata)
    );

    initial begin
        run_test();
        #100;
        $finish;
    end
    initial begin
        uvm_config_db#(virtual dma_if)::set(null,"*","vif",intf); 
    end
    
endmodule