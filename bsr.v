`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.05.2024 17:35:37
// Design Name: 
// Module Name: bsr
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module bsr(
input [15:0] din,
input [2:0] shiftcnt,      ////shiftcnt : shiftcount
input shiftdr,             ////shiftdr : shift direction ( 0 - left, 1 - right )
output reg [15:0] dout
    );
    
    
    always @(*)
    begin
    
 if(shiftdr==1'b0)
    begin
    case(shiftcnt)
    3'b000: dout = din;
    3'b001: dout = din << 3'd1;
    3'b010: dout = din << 3'd2;
    3'b011: dout = din << 3'd3;
    3'b100: dout = din << 3'd4;
    3'b101: dout = din << 3'd5;   
    3'b110: dout = din << 3'd6;
    3'b111: dout = din << 3'd7;
    default : dout = 16'd0;   
    endcase
    
    end
    
    
    
 if(shiftdr==1'b1)
    begin
    case(shiftcnt)
    3'b000: dout = din;
    3'b001: dout = din >> 3'd1;
    3'b010: dout = din >> 3'd2;
    3'b011: dout = din >> 3'd3;
    3'b100: dout = din >> 3'd4;
    3'b101: dout = din >> 3'd5;   
    3'b110: dout = din >> 3'd6;
    3'b111: dout = din >> 3'd7;
    default : dout = 16'd0;   
    endcase
    
    end
    
    end
endmodule
