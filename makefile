CC = /usr/bin/gcc
CPPFLAGS = -MMD

main: main.o
	$(CC) $(LDFLAGS) $^ $(LDLIBS) -o $@

main.h: main.h.txt
	cp $< $@

main.o: main.c
	$(CC) $(CPPFLAGS) $(CFLAGS) -c -o $@ $<

include $(wildcard main.d)

.PHONY: FORCE clean
clean: FORCE
	rm -f main
	rm -f main.d
	rm -f main.h
	rm -f main.o

FORCE:
