import uvm_pkg::*;
`include "uvm_macros.svh"

`include "interface.sv"
`include "seq_item.sv"
`include "base_seq.sv"
`include "sequencer.sv"
`include "drv.sv"
`include "mon.sv"
`include "agent.sv"
`include "sco.sv"
`include "env.sv"
`include "base_test.sv"

module tb;

  bit clk;
  bit rstn;


  shift_reg_intf intf();

  assign intf.clk = clk;
  assign intf.rstn = rstn;

  shift_reg DUT (
    .d    (intf.d),
    .clk  (intf.clk),
    .en   (intf.en),
    .dir  (intf.dir),
    .rstn (intf.rstn),
    .out  (intf.out)
  );

  initial begin
    uvm_config_db#(virtual shift_reg_intf)::set(null, "*", "vif", intf);
    run_test("base_test");
  end

  initial clk = 0;
  always #5 clk = ~clk;

  initial begin
    rstn = 0;
    #15 rstn = 1;
  end

  initial begin
    $dumpvars;
    $dumpfile("dump.vcd");
  end

 

endmodule
