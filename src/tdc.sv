module tdc (
    input logic clk,
    input logic rst,
    input logic start,
    input logic stop,
    output logic [7:0] counter_data,
    output logic counter_valid
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

    logic [2:0] stop_synchronizer;
    logic stop_strobe;
    assign stop_strobe = ~stop_synchronizer[2] & stop_synchronizer[1];
    always @(posedge clk) begin
        if (rst) begin
            stop_synchronizer <= 0;
        end else begin
            stop_synchronizer <= {stop_synchronizer[1:0], stop};
        end
    end

    
    always @(posedge clk) begin
        if (rst) begin
            counter_data <= 0;
            counter_valid <= 0;
        end else begin
            if (stop_strobe) begin
                counter_data <= fine_counter;
                counter_valid <= 1;
            end else begin
                counter_data <= 0;
                counter_valid <= 0; 
            end
        end
    end

endmodule