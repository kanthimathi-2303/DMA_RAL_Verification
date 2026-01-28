interface dma_if (input bit clk,input bit rst_n);

    logic       wr_en;
    logic       rd_en;
    logic [31:0] wdata;
    logic [31:0] addr;
    logic [31:0] rdata;

    clocking drv_cb @(posedge clk);
        output wr_en;
        output rd_en;
        output wdata;
        output addr;
        input  rdata;
    endclocking

    clocking mon_cb @(posedge clk);
        input wr_en;
        input rd_en;
        input wdata;
        input addr;
        input rdata;
    endclocking

    modport DRIVER (clocking drv_cb);
    modport MONITOR (clocking mon_cb);

endinterface