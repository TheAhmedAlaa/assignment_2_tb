module GOLDEN_MODEL (
    clk,
    rst,
    x,
    y_tb,
    users_count_tb
);
  input clk, rst, x;
  output y_tb;
  output reg [9:0] users_count_tb;
  parameter IDLE = 2'b00;
  parameter ZERO = 2'b01;
  parameter ONE = 2'b10;
  parameter STORE = 2'b11;
  reg [1:0] cs, ns;
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
endmodule
