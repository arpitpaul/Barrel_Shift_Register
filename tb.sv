`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Er. Arpit Paul
// 
// Create Date: 03.05.2024 17:52:11
// Design Name: 
// Module Name: tb
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
class transaction;         ///////////Transaction
randc bit [15:0] din;
randc bit [3:0] shiftcnt;
randc bit shiftdr;
bit [15:0] dout;
endclass

////////////

interface bsr_intf();     //////////Interface
logic [15:0] din;
logic [3:0] shiftcnt;
logic shiftdr;
logic [15:0] dout;
endinterface

////////////

class generator;
integer i;                ////////Generator
mailbox mbx;
transaction t;
event done;

function new(mailbox mbx);
this.mbx=mbx;
endfunction

task run();
t=new();
for(i=0; i<20; i++)
begin
t.randomize();
mbx.put(t);
#10;
end

-> done;
endtask
endclass

/////////


class driver;             //////Driver
mailbox mbx;
virtual bsr_intf vif;
transaction t;
function new(mailbox mbx);
this.mbx= mbx;
endfunction


task run();
forever
begin
t=new();
mbx.get(t);
vif.din = t.din;
vif.shiftcnt = t.shiftcnt;
vif.shiftdr = t.shiftdr;
#10;
end

endtask

endclass

////////////

module tb;

mailbox mbx;
transaction t;
generator gen;
driver drv;
bsr_intf vif();

bsr dut(vif.din, vif.shiftcnt, vif.shiftdr, vif.dout);
initial begin
mbx=new();
t=new();
gen=new(mbx);
drv=new(mbx);
drv.vif=vif;

fork

gen.run();
drv.run();

join_any
wait(gen.done.triggered);



end
endmodule
