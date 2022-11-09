module tdc (
    input start,
    input stop,
    output o_pulse
);
    logic enable;

    always @(posedge start or posedge stop) begin
        if (stop == 1) begin
            enable <= 0;
        end else begin
            enable <= 1;
        end
    end

    logic oscillator_out;
    ring_oscillator ring_oscillator_instance
    (
        .enable(enable),
        .oscillator_out(oscillator_out)
    );
    
endmodule