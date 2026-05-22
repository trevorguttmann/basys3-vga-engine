`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/20/2026 04:02:55 PM
// Design Name: 
// Module Name: vga_timing_driver
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


module vga_timing_driver(
input clk, reset,
output reg [9:0] hcount, vcount,
output reg hsync, vsync,
output wire visible
);

always @(posedge clk)
    begin
    
    if(reset)
        begin
        hcount <= 0;
        vcount <= 0;
        end
        
    else 
        begin
        if(hcount == 799)
            begin
            hcount <= 0;
            if(vcount == 524)
                vcount <= 0;
            else
                vcount <= vcount + 1;
            end
        else
            hcount <= hcount + 1;
            
        end
    end
    
always @(*)
    begin
    hsync = ~(hcount >= 656 && hcount < 752);
    vsync = ~(vcount >= 490 && vcount < 492);
end
    
assign visible = (hcount < 640) && (vcount < 480);
endmodule
