TARGET=blink
TOP=blink

all: pll_core.v pll_spdif.v ${TARGET}.bit 

$(TARGET).json: $(TOP).ys blink.sv
	yosys -q $(TOP).ys

$(TARGET)_out.config: $(TARGET).json
	nextpnr-ecp5 --25k --package CABGA381 --speed 6 --json $< --textcfg $@ --lpf $(TARGET).lpf --freq 65

# https://tomverbeure.github.io/2021/01/18/SPDIF-Output-PMOD.html
# https://github.com/ghdl/ghdl/issues/1337

# Hive Core PLL runs at 180 MHz off a 50MHz core clock.
# Hive SP/DIF PLL runs at 196(?) MHz off a 50MHz core clock.

# These fail in synthesis with the --highres option enabled. Related to 
# https://github.com/YosysHQ/prjtrellis/issues/160 ?

pll_core.v: Makefile
	ecppll -n pll_core --clkin_name inclk0 --clkout0_name c0 -i 25 --clkout0 180 -f pll_core.v

pll_spdif.v: Makefile
	ecppll -n pll_spdif --clkin_name inclk0 --clkout0_name c0 -i 25 --clkout0 196.7 -f pll_spdif.v
	
$(TARGET).bit: $(TARGET)_out.config
	ecppack --compress --svf ${TARGET}.svf $< $@

${TARGET}.svf: ${TARGET}.bit

flash: ${TARGET}.bit
	ecpdap flash write $(TARGET).bit

run: ${TARGET}.bit
	ecpdap program $(TARGET).bit

clean:
	rm -f pll_*.v *.svf *.bit *.config *.json

.PHONY: all prog clean flash
