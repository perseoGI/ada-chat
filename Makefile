CC := gprbuild
CFLAGS := -g
PROFILE_FLAGS := -f -cargs -fprofile-arcs -ftest-coverage -largs -fprofile-arcs

prepare:
	mkdir obj

compile:
	$(CC) $(CFLAGS) -q -P AdaChat.gpr $(PROFILE_FLAGS)

test:
	./obj/main

clean:
	rm -rf ./obj

all: prepare compile test
