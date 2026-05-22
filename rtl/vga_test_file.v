`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/20/2026 04:38:43 PM
// Design Name: 
// Module Name: vga_test_file
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

module vga_test_file(
input clk,
output Hsync, Vsync,
output [3:0] vgaRed, vgaBlue, vgaGreen
);

wire pixel_clk, visible;
wire [9:0] hcount, vcount;

clock_divider pixel_clk_signal(
.clk(clk),
.clk_div(pixel_clk)
);

vga_timing_driver driver(
.clk(pixel_clk),
.reset(1'b0),
.hcount(hcount),
.vcount(vcount),
.hsync(Hsync),
.vsync(Vsync),
.visible(visible)
);

assign vgaRed = (visible) ? 4'hF : 4'h0;
assign vgaGreen = 4'h0;
assign vgaBlue = 4'h0;

endmodule
