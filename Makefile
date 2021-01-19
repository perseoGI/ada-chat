PROFILE_FLAGS := -f -cargs -fprofile-arcs -ftest-coverage -largs -fprofile-arcs

prepare:
	mkdir obj

compile:
	gprbuild -q -P AdaChat.gpr

test:
	./obj/main

clean:
	rm -rf ./obj

all: prepare compile test
