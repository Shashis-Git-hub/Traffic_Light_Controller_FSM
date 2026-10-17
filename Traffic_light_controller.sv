/*
systemverilog

Project:  Traffic Light Controller using Moore FSM
Language: SystemVerilog
Architecture: Three-block FSM

Ta, Tb: Traffic-request / vehicle-detection inputs
La, Lb: Encoded traffic-light outputs for roads A and B

State encoding and output signal encoding

Block 1: Sequential logic
Positive-edge-triggered state register
Active-high asynchronous reset to S0

Block 2: Combinational next-state logic
Determines state transitions based on Ta and Tb

Block 3: Combinational output logic
Moore FSM: outputs depend only on the present state
*/

module Traffic_light_controller(input logic clk, reset,Ta,Tb,
    output logic [1:0] La,Lb);

    typedef enum logic [1:0] {S0,S1,S2,S3} statetype;
    statetype state,nextstate;

    localparam Red =    2'b00;
    localparam Yellow = 2'b01;
    localparam Green =  2'b10;


    always_ff @(posedge clk,posedge reset) begin
        if(reset) state <= S0;
        else      state <= nextstate;
    end
//next state logic 
    always_comb begin
        case (state)
        S0: nextstate = Ta ? S0 : S1;
        S1: nextstate = S2;
        S2: nextstate = Tb ? S2 : S3;
        S3: nextstate = S0;
        default: nextstate = S0;
    endcase
    end
//Output logic 
    always_comb begin
        case(state)
        S0: begin
            La = Green;
            Lb = Red;
        end
        S1: begin
            La = Yellow;
            Lb = Red;
        end
        S2: begin
            La = Red;
            Lb = Green;
        end
        S3: begin
            La = Red;
            Lb = Yellow;
        end
        default: begin
            La = Red;
            Lb = Red;
        end
        endcase
    end
endmodule
