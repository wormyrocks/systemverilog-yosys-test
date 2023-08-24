TARGET=blink
TOP=blink

all: ${TARGET}.bit

$(TARGET).json: $(TOP).ys
	yosys -q $(TOP).ys

$(TARGET)_out.config: $(TARGET).json
	nextpnr-ecp5 --25k --package CABGA381 --speed 6 --json $< --textcfg $@ --lpf $(TARGET).lpf --freq 65

$(TARGET).bit: $(TARGET)_out.config
	ecppack --compress --svf ${TARGET}.svf $< $@

${TARGET}.svf: ${TARGET}.bit

flash: ${TARGET}.bit
	ecpdap flash write $(TARGET).bit

prog: ${TARGET}.bit
	ecpdap program $(TARGET).bit

clean:
	rm -f *.svf *.bit *.config *.json

.PHONY: all prog clean flash
