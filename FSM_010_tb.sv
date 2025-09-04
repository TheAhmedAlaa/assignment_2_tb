import Q3::*;
module FSM_010_tb ();
  logic x, clk, rst;
  logic y;
  logic [9:0] users_count;
  logic [30:0] correct_counter, false_counter;
  FSM_010 DUT (
      clk,
      rst,
      x,
      y,
      users_count
  );
  state_e cs, ns;
  //GOLDEN MODEL
  //ns logic
  always @(*) begin
    case (cs)
      IDLE: begin
        if (x) ns = IDLE;
        else ns = ZERO;
      end
      ZERO: begin
        if (x) ns = ONE;
        else ns = ZERO;
      end
      ONE: begin
        if (x) ns = IDLE;
        else ns = STORE;
      end
      STORE: begin
        if (x) ns = IDLE;
        else ns = ZERO;
      end
      default: ns = IDLE;

    endcase
  end
  //state memory
  always @(posedge clk or posedge rst) begin
    if (rst) begin
      cs <= IDLE;
    end else cs <= ns;
  end
  //output logic
  always @(posedge clk or posedge rst) begin
    if (rst) begin
      users_count_tb <= 0;
    end else begin
      if (cs == STORE) users_count_tb <= users_count_tb + 1;
    end
  end
  assign y_tb = (cs == STORE) ? 1 : 0;

  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end
  task check(input logic y, y_tb, logic [9:0] users_count, users_count_tb);
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
      check(y, y_tb, users_count, users_count_tb);
    end
    $display("correct_counter=%d,false_counter=%d", correct_counter, false_counter);
    $stop;
  end
endmodule
