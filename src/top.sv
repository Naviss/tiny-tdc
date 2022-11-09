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

    logic [7:0] axi_data;
    logic axi_ready;
    logic axi_valid;

    assign clk = io_in[0];
    assign rst = io_in[1];
    assign start = io_in[2];
    assign stop = io_in[3];

    assign io_out[0] = uart_tx;
    
    assign axi_data = 8'h00;
    assign axi_valid = 1;

    Uart uart_instance (
        .clk(clk),
        .rst(rst),
        .axi_valid(axi_valid),
        .axi_ready(axi_ready),
        .axi_data(axi_data),
        .uart_tx(uart_tx)
    );
    

endmodule
