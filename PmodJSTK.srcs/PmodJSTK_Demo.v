////////////////////////////////////////////////////////////////////////////////////////////
// Company: VIT Vellore
// Engineer: Aritra Ghosh
// 
// Create Date:    17/11/2024
// Module Name:    PmodJSTK_Demo
// Project Name: 	 PmodJSTK_Demo
// Target Devices: Nexys3
// Tool versions:  ISE 14.1
// Description: This is the top level module, which integrates everything.
//
// Revision History: 
// 						Revision 0.01 - File Created (Aritra Ghosh)
////////////////////////////////////////////////////////////////////////////////////////////

module PmodJSTK_Demo (
    input CLK,                // 100 MHz clock
    input RST,                // Reset button
    input MISO,               // PmodJSTK data line
    output SS,                // Slave select
    output MOSI,              // Master out, slave in
    output SCLK,              // SPI clock
    output [3:0] AN,          // Seven-segment anodes
    output [6:0] SEG          // Seven-segment cathodes
);
    // Parameters and Wires
    wire [39:0] jstkData;     // Data from PmodJSTK
    wire [9:0] posData;       // Joystick Y-axis position
    wire sndRec;              // Signal to send/receive data
    reg [3:0] counter = 4'b0000; // 4-bit counter
    reg [9:0] lastPosData;    // Holds previous joystick Y-axis value
    reg [2:0] state = 0;      // State machine for debouncing

    // SPI and Joystick Interface
    PmodJSTK joystick (
        .CLK(CLK),
        .RST(RST),
        .sndRec(sndRec),
        .DIN(8'b0),           // Unused, sending static data
        .MISO(MISO),
        .SS(SS),
        .SCLK(SCLK),
        .MOSI(MOSI),
        .DOUT(jstkData)
    );

    // Clock Divider for Send/Receive Signal (~5Hz for smoother updates)
    ClkDiv_5Hz genSndRec (
        .CLK(CLK),
        .RST(RST),
        .CLKOUT(sndRec)
    );

    // Seven-Segment Display Controller
    ssdCtrl display (
        .CLK(CLK),
        .RST(RST),
        .DIN(counter),        // 4-bit counter to SSD
        .AN(AN),
        .SEG(SEG)
    );

    // Joystick Y-axis Data
    assign posData = {jstkData[25:24], jstkData[39:32]};

    // Counter Logic with State Machine for Debouncing
    always @(posedge CLK) begin
        if (RST) begin
            counter <= 4'b0000;         // Reset counter to 0
            state <= 0;
            lastPosData <= 0;
        end else begin
            case (state)
                3'b000: begin
                    if (posData[9:2] > 8'd200 && lastPosData[9:2] <= 8'd200) begin
                        counter <= (counter == 4'b1111) ? 4'b0000 : counter + 1; // Increment
                        state <= 3'b001;    // Move to debounce state
                    end else if (posData[9:2] < 8'd100 && lastPosData[9:2] >= 8'd100) begin
                        counter <= (counter == 4'b0000) ? 4'b1111 : counter - 1; // Decrement
                        state <= 3'b001;    // Move to debounce state
                    end
                end

                3'b001: begin
                    // Wait in debounce state to avoid rapid transitions
                    state <= (sndRec) ? 3'b000 : 3'b001;
                end
            endcase
            lastPosData <= posData; // Update previous position data
        end
    end
endmodule
