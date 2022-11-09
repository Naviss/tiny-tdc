module ring_oscillator
#(
    parameter LENGTH = 9
)
(
    input logic enable,
    output logic oscillator_out
);

    assign oscillator_out = ring[0];
    logic [LENGTH-1:0] ring;

    always @(*) begin
        ring[0] <= enable && ring[LENGTH-1];
        for (int i = 0; i < LENGTH-1; i++) begin
            ring[i+1] = !ring[i];
        end
    end

endmodule