//Digital Electronics Lab Project
//Submitted to: Dr. Sheeba Rani J, Assosiate Professor, IIST
//Submitted by: Neha Binny (Sc19B090), Nirbhay Tyagi (SC19B091)

// Verilog Code - Vending Machine Controller
module vending_machine(one_in,two_in,five_in,clk,reset,one_balance,two_balance,dispense);//Module Declaration for vending Machine Controller
//State Assignment
parameter S0=8'b0000_0001, S1=8'b0000_0010, S2=8'b0000_0100, S3=8'b0000_1000, S4=8'b0001_0000, S5 = 8'b0010_0000, S6 = 8'b0100_0000, S7 = 8'b1000_0000;
//
input one_in,  // Input rupee 1 coin
      two_in,  // Input rupee 2 coin
      five_in, // Input rupee 5 coin
      clk,     // Clock of frequency 100MHz
      reset;   // Reset Active High
output reg one_balance,   // Change of rupee 1 
           two_balance,   // Change of rupee 2
           dispense;      // Dispenses a mask
reg [7:0] current_state, next_state;
//Next State
always @(posedge clk) begin
    if(reset) 
    current_state <=S0;
    else
    current_state<=next_state;
end
//Finite State Machine
always @(one_in, two_in, five_in) begin

    case (current_state)
        S0: begin     // Reset State
          if(one_in==1) begin
            next_state=S1;
            {one_balance, two_balance, dispense} = 3'b000;
          end
          else if(two_in==1) begin
            next_state=S2;
            {one_balance, two_balance, dispense} = 3'b000;
          end
          else if(five_in==1) begin
            next_state=S5;
            {one_balance, two_balance, dispense} = 3'b000;
          end
          else begin
            next_state=S0;
            {one_balance, two_balance, dispense} = 3'b000;
          end
        end
        
        S1: begin     //Money Count is Rupee 1
          if(one_in==1) begin
            next_state=S2;
            {one_balance, two_balance, dispense} = 3'b000;
          end
          else if(two_in==1) begin
            next_state=S3;
            {one_balance, two_balance, dispense} = 3'b000;
          end
          else if(five_in==1) begin
            next_state=S6;
            {one_balance, two_balance, dispense} = 3'b000;
          end
          else begin
            next_state=S1;
            {one_balance, two_balance, dispense} = 3'b000;
          end
        end

        S2: begin     //Money Count is Rupee 2
          if(one_in==1) begin
            next_state=S3;
            {one_balance, two_balance, dispense} = 3'b000;
          end
          else if(two_in==1) begin
            next_state=S4;
            {one_balance, two_balance, dispense} = 3'b000;
          end
          else if(five_in==1) begin
            next_state=S0;
            {one_balance, two_balance, dispense} = 3'b001;    //Dispenses a mask and No change
          end
          else begin
            next_state=S2;
            {one_balance, two_balance, dispense} = 3'b000;
          end
        end

        S3: begin     //Money Count is Rupee 3
          if(one_in==1) begin
            next_state=S4;
            {one_balance, two_balance, dispense} = 3'b000;
          end
          else if(two_in==1) begin
            next_state=S5;
            {one_balance, two_balance, dispense} = 3'b000;
          end
          else if(five_in==1) begin
            next_state=S0;
            {one_balance, two_balance, dispense} = 3'b101;    //Dispenses a mask and 1 Rupee change
          end
          else begin
            next_state=S3;
            {one_balance, two_balance, dispense} = 3'b000;
          end
        end

        S4: begin     //Money Count is Rupee 4
          if(one_in==1) begin
            next_state=S5;
            {one_balance, two_balance, dispense} = 3'b000;
          end
          else if(two_in==1) begin
            next_state=S6;
            {one_balance, two_balance, dispense} = 3'b000;
          end
          else if(five_in==1) begin
            next_state=S0;
            {one_balance, two_balance, dispense} = 3'b011;    //Dispenses a mask and 2 rupee change
          end
          else begin
            next_state=S4;
            {one_balance, two_balance, dispense} = 3'b000;
          end
        end      

        S5: begin     //Money Count is Rupee 5
          if(one_in==1) begin
            next_state=S6;
            {one_balance, two_balance, dispense} = 3'b000;
          end
          else if(two_in==1) begin
            next_state=S0;
            {one_balance, two_balance, dispense} = 3'b001;    //Dispenses a mask and No change
          end
          else if(five_in==1) begin
            next_state=S0;
            {one_balance, two_balance, dispense} = 3'b111;    //Dispenses a mask and a change of rupee 1 and rupee 2
          end
          else begin
            next_state=S5;
            {one_balance, two_balance, dispense} = 3'b000;
          end
        end 

        S6: begin     //Money Count is Rupee 6
          if(one_in==1) begin
            next_state=S0;
            {one_balance, two_balance, dispense} = 3'b001;    //Dispenses a mask and No change
          end
          else if(two_in==1) begin
            next_state=S0;
            {one_balance, two_balance, dispense} = 3'b101;    //Dispenses a mask anda change of rupee 1
          end
          else if(five_in==1) begin
            next_state=S7;
            {one_balance, two_balance, dispense} = 3'b011;    //Dispenses a mask and a change of rupee 2
          end
          else begin
            next_state=S6;
          end
        end

        S7: begin     // Returns remaining change of rupee 2 for a total of rupee 11 
          next_state=S0;
          {one_balance, two_balance, dispense} = 3'b010;    //Dispenses no mask but a change of rupee 2
        end

        default: begin
          next_state=S0;
          {one_balance, two_balance, dispense} = 3'b000;
        end
    endcase
end
endmodule