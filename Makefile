SRC = ALU.v ALU_tb.v
OUT = ALU_sim
WAVE = ALU_wave.vcd

all:
	iverilog -o $(OUT) $(SRC)
	vvp $(OUT)
	gtkwave $(WAVE)

clean:
	rm -f $(OUT) $(WAVE)
