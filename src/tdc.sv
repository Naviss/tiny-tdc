module tdc (
    input rst,
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

    logic [7:0] fine_counter;
    always @(posedge oscillator_out or posedge rst) begin
        if (rst) begin
            fine_counter <= 8'b0;
        end else begin
            fine_counter <= fine_counter + 1;
        end
    end

    

endmodule