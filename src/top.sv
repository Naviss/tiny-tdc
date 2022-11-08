`default_nettype none

module top (
  input logic clk,
  input logic rst, 
  input logic start, 
  input logic stop, 
  output logic uart_tx
);
    
    logic [7:0] axi_data;
    logic axi_ready;
    logic axi_valid;


    Uart uart_instance (
        .clk(clk),
        .rst(rst),
        .axi_valid(axi_valid),
        .axi_ready(axi_ready),
        .axi_data(axi_data),
        .uart_tx(uart_tx)
    );
    

endmodule
