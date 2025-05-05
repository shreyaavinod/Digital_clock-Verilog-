`timescale 1ns / 1ps

module sevseg(
input clk,
input rst,
output reg [3:0]AN,
output reg [7:0]seg,
output  [7:0]hr

    );
    
    wire [7:0]m,s,h;
    
    wire [3:0]mo,mt,so,st;
    wire [7:0]mbcd,sbcd;
    wire [15:0]sev;
    
    clock u1(clk,rst,m,s,h);
    
    bitobcd b1(m,mbcd);
    bitobcd b2(s,sbcd);
    assign sev={mbcd[7:0],sbcd[7:0]};
    assign mt=sev[15:12];
    assign mo=sev[11:8];
    assign st=sev[7:4];
    assign so=sev[3:0];
    assign hr=h[7:0];
    
    localparam zero=8'b11000000;
    localparam one=8'b11111001;
    localparam two=8'b10100100;
    localparam three=8'b10110000;
    localparam four=8'b10011001;
    localparam five=8'b10010010;
    localparam six=8'b10000010;
    localparam seven=8'b11111000;
    localparam eight=8'b10000000;
    localparam nine=8'b10010000;
    
    reg [31:0]anodetimer=31'd0;
    reg [1:0]anodeselect=2'b00;
    
    always @(posedge clk or negedge rst)begin
    if (rst==0)begin
    anodetimer<=0;
    end
    else if(anodetimer==31'd99999)begin
    anodeselect<=anodeselect+1;
    anodetimer<=0;
    end
    else begin
    anodetimer=anodetimer+1;
    end
    end
    
    always @(anodeselect)begin
    case (anodeselect)
    
    2'b00: begin
    AN=4'b1110;
    end
    
    2'b01: begin
    AN=4'b1101;
    end
    
    2'b10:begin
    AN=4'b1011;
    end
    
    2'b11:begin
    AN=4'b0111;
    end
    
    endcase
    end

    
    always @(*)begin
     case(anodeselect)
     
     2'b00:begin
     case(mo)
     
     4'b0000: seg=zero;
     4'b0001: seg=one;
     4'b0010: seg=two;
     4'b0011: seg=three;
     4'b0100: seg=four;
     4'b0101: seg=five;
     4'b0110: seg=six;
     4'b0111: seg=seven;
     4'b1000: seg=eight;
     4'b1001: seg=nine;
     endcase
     end
     
     2'b01:begin
     case(mt)
     4'b0000: seg=zero;
     4'b0001: seg=one;
     4'b0010: seg=two;
     4'b0011: seg=three;
     4'b0100: seg=four;
     4'b0101: seg=five;
     endcase
     end
     
     2'b10:begin
     case(so)
     4'b0000: seg=zero;
     4'b0001: seg=one;
     4'b0010: seg=two;
     4'b0011: seg=three;
     4'b0100: seg=four;
     4'b0101: seg=five;
     4'b0110: seg=six;
     4'b0111: seg=seven;
     4'b1000: seg=eight;
     4'b1001: seg=nine;
     endcase
     end
     
     2'b11:begin
     case(st)
     4'b0000: seg=zero;
     4'b0001: seg=one;
     4'b0010: seg=two;
     4'b0011: seg=three;
     4'b0100: seg=four;
     4'b0101: seg=five;

     endcase
     end
     
     endcase
     end  
endmodule
