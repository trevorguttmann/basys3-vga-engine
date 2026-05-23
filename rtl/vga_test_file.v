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
reg [11:0] rgb;

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

always @(*)
    begin
    if(visible)
        begin
        if(hcount < 80)
            rgb = 12'hF00;
        else if(hcount < 160)
            rgb = 12'h0F0;
        else if(hcount < 240)
            rgb = 12'h00F;
        else if(hcount < 320)
            rgb = 12'hF00;
        else if(hcount < 400)
            rgb = 12'h0F0;
        else if(hcount < 480)
            rgb = 12'h00F;
        else if(hcount < 560)
            rgb = 12'hF00;
        else if(hcount < 640)
            rgb = 12'h0F0;
        end
    else
        rgb = 12'h000;
    end

// VGA outputs
assign vgaRed = rgb[11:8];
assign vgaGreen = rgb[7:4];
assign vgaBlue  = rgb[3:0];

endmodule
