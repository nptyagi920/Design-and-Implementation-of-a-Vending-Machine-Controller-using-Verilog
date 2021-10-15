//Digital Electronics Lab Project
//Submitted to: Dr. Sheeba Rani J, Assosiate Professor, IIST
//Submitted by: Neha Binny (Sc19B090), Nirbhay Tyagi (SC19B091)

//Test Bench - Vending Machine Controller
`timescale 1ns/1ns                // Time Scale Directive
`include "vending_machine.v"      // Includes the Verilog file
module vending_machine_tb;        //Module Declaration
//DUT Input regs
reg one_in,two_in,five_in,reset;
reg clk=1'b1;
//DUT Output wires
wire one_balance,two_balance,dispense;
//DUT Instntiation
vending_machine DUT(.one_in(one_in),.two_in(two_in),.five_in(five_in),.clk(clk),.reset(reset),.one_balance(one_balance),.two_balance(two_balance),.dispense(dispense));
//Generating .vcd file
initial begin
    $dumpfile("vending_machine_tb.vcd");
    $dumpvars(0,vending_machine_tb);
    repeat(18)    //Determines Simulation limit
    #5 clk=~clk;  //Clock Generation
end
//Test Vectors
initial begin
    one_in=0;
    two_in=0;
    five_in=0;
    reset=1;
    # 10;

    reset=0;
    one_in=1;
    two_in=0;
    five_in=0;
    #10;

    reset=0;
    one_in=0;
    two_in=0;
    five_in=1;
    #10;
    
    reset=0;
    one_in=1;
    two_in=0;
    five_in=0;
    #10;

    one_in=0;
    two_in=0;
    five_in=0;
    #10;

    one_in=0;
    two_in=0;
    five_in=1;
    #10;

    one_in=0;
    two_in=0;
    five_in=0;
    #10;

    one_in=0;
    two_in=0;
    five_in=1;
    #10;

    one_in=0;
    two_in=0;
    five_in=0;
    #10;

end
// Display Output
initial begin
  $monitor("simulation time:%g  Rupee One Input:%b  Rupee Two Input:%b  Rupee Five Input:%b  Rupee one change:%b  Rupee two change:%b  Dispense:%b",$time,one_in,two_in,five_in,one_balance,two_balance,dispense);
end
endmodule