
all:
	gprbuild -q -P AdaChat.gpr

test:
	./obj/main
