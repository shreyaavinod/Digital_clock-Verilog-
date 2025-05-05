`timescale 1ns / 1ps

module clock(
    input clk,
    input rst,
    output [7:0]mincount,
    output [7:0]secondcount,
    output [7:0]hrcount,

    output led
    );
    reg clk2;
    reg [31:0]counter;
    
    always @(posedge clk or negedge rst)begin 
    if (rst==0)begin
    counter<=0;
    end
    else if (counter==32'd50000000)begin
    counter<=0;
    clk2<=~clk2;
    end
    else begin 
    counter<=counter+1;
    end
    end
 
    reg [7:0]count=8'b0;
    reg [7:0]count1=8'b0;
    reg [7:0]count2=8'b0;
    reg led1=1'b0;
    
always @(posedge clk2 or negedge rst)begin
if (rst==0) begin
count <= 0;
end
else if (count == 8'd59) begin
    count <= 0;
end
else begin
    count <= count + 1;
end

if (rst==0) begin
    count1 <= 0;
end
else if (count == 8'd59 && count1<8'd59 ) begin
    count1 <= count1+1;
end
else if (count==8'd59 && count1==8'd59) begin
    count1 <= 0;
end

if (rst==0) begin
    count1 <= 0;
end
else if (count == 8'd59 && count1==8'd59 && count2<8'd23 ) begin
    count2 <= count2+1;
end
else if (count==8'd59 && count1==8'd59 && count2==8'd23) begin
    count2 <= 0;
end
end
assign secondcount=count;

assign mincount=count1;

assign hrcount=count2;
    
endmodule
