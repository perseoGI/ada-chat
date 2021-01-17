
prepare:
	mkdir obj

compile:
	gprbuild -q -P AdaChat.gpr

test:
	./obj/main

clean:
	rm -rf ./obj

all: prepare compile test
