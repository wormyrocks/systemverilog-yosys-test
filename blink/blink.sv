module blink

  #(parameter main_count_1HZ   =  25000000, // Divider to make each clock blink LED at 1Hz
    parameter core_count_1HZ   = 180000000, 
    parameter spdif_count_1HZ  = 196666666)

  (input  clk_25m_i,
   output reg led_o = 1'b0);

	pll_spdif pll_spdif (
		.inclk0				( clk_25m_i ),
		.c0					( clk_spdif )
	);

	pll_core pll_core (
		.inclk0				( clk_25m_i ),
		.c0					( clk_core )
	);



  reg [64:0] r_Count_1Hz = 0;
  
  always @(posedge clk_spdif)
  begin
    if (r_Count_1Hz == spdif_count_1HZ)
    begin
      led_o       <= ~led_o;
      r_Count_1Hz <= 0;
    end
    else
      r_Count_1Hz <= r_Count_1Hz + 1;
  end

endmodule
