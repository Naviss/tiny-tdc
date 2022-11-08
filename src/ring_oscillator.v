module ring_oscillator #(
    parameter LENGTH = 9
) (
    input i_start,
    input i_nreset,
    output o_pulse
);
    wire [LENGTH-1:0];
    reg en;

    always @(posedge i_start or negedge i_nreset) begin
        if (i_nreset == 0) begin
            en <= 0;
        end else begin
            en <= 1;
        end
    end


    assign ring[0] = en and ring[LENGTH-1];
    for (i = 0; i < LENGTH-1; i++) {
        assign ring[i+1] = not ring[i];
    }
endmodule