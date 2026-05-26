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
        
        if(vcount > 50 && vcount < 100)
            begin
            if(hcount > 50 && hcount < 590)
                rgb = 12'hFFF;
            end
        else if(vcount > 380 && vcount < 430)
            begin
            if(hcount > 50 && hcount < 590)
                rgb = 12'hFFF;
            end
        else if((hcount > 50 && hcount < 100) || (hcount > 550 && hcount < 590))
            rgb = 12'hFFF;
        else
            rgb = 12'h000;
        
        end
    else
        rgb = 12'h000;
    end

// VGA outputs
assign vgaRed = rgb[11:8];
assign vgaGreen = rgb[7:4];
assign vgaBlue  = rgb[3:0];

endmodule
