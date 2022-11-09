`default_nettype none

module Uart (
  input logic clk,
  input logic rst, 
  input logic axi_valid,
  output logic axi_ready,
  input logic [7:0] axi_data,
  output logic uart_tx
);
    
typedef enum logic { IDLE, TRANSMIT  } serializer_state_t;
serializer_state_t serializer_state;
logic [3:0] bit_counter;
logic [7:0] uart_data;

always @(posedge clk) begin
  if(rst) begin
      serializer_state <= IDLE;
      bit_counter <= 0;
      axi_ready <= 0;
      uart_tx <= 1;
      uart_data <= 0;
  end
  else begin
      case (serializer_state)
          IDLE : begin
              if (axi_valid == 1) begin
                  uart_data <= axi_data;
                  serializer_state <= TRANSMIT ;
                  uart_tx <= 0;
                  axi_ready <= 0;
                  bit_counter <= 0;
              end else begin
                  axi_ready <= 1;
                  bit_counter <= 0;
                  uart_tx <= 1;
              end
          end

          TRANSMIT : begin
              if (bit_counter == 8) begin
                  axi_ready <= 1;
                  bit_counter <= 0;
                  serializer_state <= IDLE;
                  uart_tx <= 1;
              end else begin
                  uart_tx <= uart_data [bit_counter];
                  bit_counter <= bit_counter + 1;
                  axi_ready <= 0;
              end
          end
      endcase
  end
end    

endmodule
