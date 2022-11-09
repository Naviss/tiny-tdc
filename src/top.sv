`default_nettype none

module Naviss_top (
  input [7:0] io_in,
  output [7:0] io_out
);
    logic clk;
    logic rst;
    logic start; 
    logic stop;
    logic uart_tx;


    assign clk = io_in[0];
    assign rst = io_in[1];
    assign start = io_in[2];
    assign stop = io_in[3];

    assign io_out[0] = uart_tx;
    
    
    logic [7:0] counter_data;
    logic counter_valid;
    logic axi_ready;


    tdc tdc_instance
    (
        .clk(clk),
        .rst(rst),
        .start(start),
        .stop(stop), 
        .counter_data(counter_data),
        .counter_valid(counter_valid)
    );

    Uart uart_instance (
        .clk(clk),
        .rst(rst),
        .axi_valid(counter_valid),
        .axi_ready(axi_ready),
        .axi_data(counter_data),
        .uart_tx(uart_tx)
    );
    

endmodule
