module blink
  #(parameter g_COUNT_10HZ = 25000000)
  (input  clk_i,
   output reg led_o = 1'b0);
  
  // These signals will be the counters:
  reg [31:0] r_Count_10Hz = 0;

  // All processes toggle a specific signal at a different frequency.
  // They all run continuously

  always @(posedge clk_i)
  begin
    if (r_Count_10Hz == g_COUNT_10HZ)
    begin
      led_o      <= ~led_o;
      r_Count_10Hz <= 0;
    end
    else
      r_Count_10Hz <= r_Count_10Hz + 1;
  end
endmodule
