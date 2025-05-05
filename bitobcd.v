`timescale 1ns / 1ps

module bitobcd(
input  [7:0] binary_in,
    output reg [7:0] bcd_out
);
    integer i;
    reg [19:0] shift_reg;

    always @(*) begin
        // Initialize shift register with binary input
        shift_reg = 20'd0;
        shift_reg[7:0] = binary_in;

        // Perform 8 iterations of the double dabble algorithm
        for (i = 0; i < 8; i = i + 1) begin
            if (shift_reg[11:8] >= 5)
                shift_reg[11:8] = shift_reg[11:8] + 3;
            if (shift_reg[15:12] >= 5)
                shift_reg[15:12] = shift_reg[15:12] + 3;

            shift_reg = shift_reg << 1;
        end

        // Pack two BCD digits (tens and ones) into 8 bits
        bcd_out = {shift_reg[15:12], shift_reg[11:8]};
    end
    endmodule 
