module ring_oscillator #(
    parameter LENGTH = 9
) (
    input i_start,
    input i_nreset,
    output o_pulse
);
    logic [LENGTH-1:0] ring;
    logic en;

    always @(posedge i_start or negedge i_nreset) begin
        if (i_nreset == 0) begin
            en <= 0;
        end else begin
            en <= 1;
        end
    end


    always @(*) begin
        ring[0] <= en && ring[LENGTH-1];
        for (int i = 0; i < LENGTH-1; i++) begin
            ring[i+1] = !ring[i];
        end
    end


endmodule