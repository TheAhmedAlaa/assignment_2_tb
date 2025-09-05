module Q1 ();
  bit [11:0] my_array[3:0];
  initial begin
    my_array[0] = 12'h012;
    my_array[1] = 12'h345;
    my_array[2] = 12'h678;
    my_array[3] = 12'h9AB;
    for (int i = 3; i >= 0; i--) begin
      $display("for[%d] = %b", i, my_array[i][5:4]);
    end
    foreach (my_array[i]) begin
      $display("foreach[%d] = %b", i, my_array[i][5:4]);
    end
  end

endmodule
