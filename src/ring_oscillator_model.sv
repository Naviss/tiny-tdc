module ring_oscillator
#(
    parameter LENGTH = 9
)
(
    input logic enable,
    output logic oscillator_out
);

initial begin
    while(1) begin
        if (enable) begin
            oscillator_out = 1'b0;
            #100; 
            oscillator_out = 1'b1;
            #100;
        end else begin
            oscillator_out = 1'b0;
            #10;
        end
    end
end

endmodule