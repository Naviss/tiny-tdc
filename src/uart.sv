`default_nettype none

module Uart (
  input logic clk,
  input logic rst, 
  input logic axi_valid,
  output logic axi_ready,
  input logic [7:0] axi_data,
  output logic uart_tx
);
    
typedef enum logic { IDLE, DATA } serializer_state_t;
serializer_state_t serializer_state;
logic [2:0] bit_counter;

always @(posedge clk) begin
  if(rst) begin
      serializer_state <= IDLE;
      bit_counter <= 0;
  end
  else begin
      case (serializer_state)
          IDLE : begin
              if (axi_valid == 1) begin
                  serializer_state <= DATA;
                  uart_tx <= 0;
                  axi_ready <= 0;
                  bit_counter <= 1;

              end else begin
                  axi_ready <= 1;
                  bit_counter <= 0;
                  uart_tx <= 1;
              end
          end

          DATA: begin
              uart_tx <= axi_data[bit_counter];
              bit_counter <= bit_counter + 1;
              axi_ready <= 0;

              if (bit_counter == 7) begin
                  axi_ready <= 1;
                  bit_counter <= 1;
                  serializer_state <= IDLE;
              end
          end
      endcase
  end
end    

endmodule
