
NAME=adder
SIMTIME=60ns

all:
	gvhdl $(NAME).vhd
	echo -e 'd\nr $(SIMTIME)\nd\nq\n' | ./$(NAME)
	gtkwave wave.dmp

clean:
	rm -f *.o *.cc $(NAME) wave.dmp
