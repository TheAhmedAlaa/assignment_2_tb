import Q3::*;
module FSM_010_tb ();
  bit x, clk, rst;
  bit y;
  reg [9:0] users_count;
  reg [30:0] correct_counter, false_counter;
  logic y_tb;
  reg [9:0] users_count_tb;
  FSM_010 DUT (
      clk,
      rst,
      x,
      y,
      users_count
  );
  GOLDEN_MODEL DUTT (
      clk,
      rst,
      x,
      y_tb,
      users_count_tb
  );
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end
  task check();
    @(negedge clk);
    if (y === y_tb && users_count === users_count_tb) begin
      $display("Correct");
      correct_counter = correct_counter + 1;
    end else begin
      $display("false");
      false_counter = false_counter + 1;
    end
  endtask
  fsm_transaction fsm_;
  initial begin
    fsm_ = new();
    correct_counter = 0;
    false_counter = 0;
    for (int i = 0; i < 1000; i++) begin
      assert (fsm_.randomize());
      x   = fsm_.x;
      rst = fsm_.rst;
      check();
    end
    for (int i = 0; i < 4000; i++) begin
      x = 0;
      @(posedge clk);
      x = 1;
      @(posedge clk);
      x = 0;
      check;
    end

    $display("correct_counter=%d,false_counter=%d", correct_counter, false_counter);
    $stop;
  end
endmodule
