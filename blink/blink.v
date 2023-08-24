module blink (
    input      clk_i,
    output reg led_o
);
localparam MAX = 2_500_000;
localparam WIDTH = $clog2(MAX);

wire rst_s;
wire clk_s;

assign clk_s = clk_i;
//pll_12_16 pll_inst (.clki(clk_i), .clko(clk_s), .rst(rst_s));
rst_gen rst_inst (.clk_i(clk_s), .rst_i(1'b0), .rst_o(rst_s));

reg  [WIDTH-1:0] cpt_s;
wire [WIDTH-1:0] cpt_next_s = cpt_s + 1'b1;

wire             end_s = cpt_s == MAX-1;

always @(posedge clk_s) begin
    cpt_s <= (rst_s || end_s) ? {WIDTH{1'b0}} : cpt_next_s;

    if (rst_s)
        led_o <= 1'b0;
    else if (end_s)
        led_o <= ~led_o;
end
endmodule

module rst_gen (
	input 			clk_i,
	input 			rst_i,
	output			rst_o
);

/* try to generate a reset */
reg [2:0]	rst_cpt;
always @(posedge clk_i) begin
	if (rst_i)
		rst_cpt = 3'b0;
	else begin
		if (rst_cpt == 3'b100)
			rst_cpt = rst_cpt;
		else
			rst_cpt = rst_cpt + 3'b1;
	end
end

assign rst_o = !rst_cpt[2];

endmodule
