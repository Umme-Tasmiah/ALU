SRC = src/ALU.v src/ALU_tb.v
OUT = sim/ALU_sim
WAVE = sim/ALU_wave.vcd

all:
	iverilog -o $(OUT) $(SRC)
	vvp $(OUT)
	gtkwave $(WAVE)

clean:
	rm -f $(OUT) $(WAVE)
