import Q2_ALU::*;
module ALU_tb ();
  bit clk;
  bit reset;
  opcode_typedef opcode;
  bit signed [3:0] A;
  bit signed [3:0] B;
  reg signed [4:0] C, C_tb;
  logic [30:0] Correct_counter, false_counter;
  ALU DUT (
      clk,
      reset,
      opcode,
      A,
      B,
      C
  );
  initial begin
    clk = 0;
    forever begin
      #5 clk = ~clk;
    end
  end
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      C_tb <= 0;
    end else begin
      case (opcode)
        ADD: C_tb <= A + B;
        SUB: C_tb <= A - B;
        bitwise_invert_A: C_tb <= ~A;
        reduction_OR_B: C_tb <= |B;
      endcase
    end
  end

  task Check(input signed [4:0] C, C_tb);
    @(negedge clk);
    if (C === C_tb) begin
      $display("Correct");
      Correct_counter = Correct_counter + 1;
    end else begin
      $display("Wrong");
      false_counter = false_counter + 1;
    end
  endtask
  ALU_Class ALU_;
  initial begin
    ALU_ = new();
    Correct_counter = 0;
    false_counter = 0;
    for (int i = 0; i < 1000; i++) begin
      assert (ALU_.randomize());
      A = ALU_.A;
      B = ALU_.B;
      opcode = ALU_.opcode;
      reset = ALU_.reset;
      Check(C, C_tb);
    end
    $display("correct_counter=%d,false_counter=%d", Correct_counter, false_counter);
    $stop;
  end
endmodule
