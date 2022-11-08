`default_nettype none

module seven_segment_seconds #( parameter MAX_COUNT = 1000 ) (
  input [7:0] io_in,
  output [7:0] io_out
);
    
    wire clk = io_in[0];
    wire reset = io_in[1];

    ring_oscillator rs(
        .i_start(io_in[2]),
        .i_nreset(reset),
        .o_pulse(io_out[0])
    );
endmodule
