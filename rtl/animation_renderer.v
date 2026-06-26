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

module animation_renderer(
input clk,
output Hsync, Vsync,
output [3:0] vgaRed, vgaBlue, vgaGreen
);

wire pixel_clk, visible;
wire [9:0] hcount, vcount;
reg [11:0] rgb;

reg [9:0] x_coord = 100;
reg [9:0] y_coord = 100;
wire frame_tick = (hcount == 0 && vcount == 0);
reg change_x_direction = 0;
reg change_y_direction = 0;

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
    
always @(posedge pixel_clk)
    begin
    if(frame_tick)
        begin
        // Box direction change logic
        if(x_coord >= 590 && change_x_direction == 0)
            change_x_direction <= 1;
        if(x_coord <= 1 && change_x_direction == 1)
            change_x_direction <= 0;
        if(y_coord >= 430 && change_y_direction == 0)
            change_y_direction <= 1;
        if(y_coord <= 1 && change_y_direction == 1)
            change_y_direction <= 0;
            
        // Box movement
        if(change_x_direction)
            x_coord <= x_coord - 1;
        else
            x_coord <= x_coord + 1;
        if(change_y_direction)
            y_coord <= y_coord - 1;
        else
            y_coord <= y_coord + 1;
        end
    end
    
always @(*)
    begin
    rgb = 12'h000;
    if(visible)
        begin
            if(hcount >= x_coord && hcount < x_coord + 50 && vcount >= y_coord && vcount < y_coord + 50)
                rgb = 12'hFFF;
        end
    end

// VGA outputs
assign vgaRed = rgb[11:8];
assign vgaGreen = rgb[7:4];
assign vgaBlue  = rgb[3:0];

endmodule
