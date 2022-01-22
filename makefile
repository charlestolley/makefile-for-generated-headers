CC = /usr/bin/gcc

main: main.o
	$(CC) $(LDFLAGS) $^ $(LDLIBS) -o $@

main.h: main.h.txt
	cp $< $@

main.d: main.c
	$(CC) -MM -MG $(CPPFLAGS) $< | sed 's,\($*\.o\)\s*:\s*,\1 $@: ,' > $@

main.o: main.c
	$(CC) $(CPPFLAGS) $(CFLAGS) -c -o $@ $<

include main.d

.PHONY: FORCE clean
clean: FORCE
	rm -f main
	rm -f main.d
	rm -f main.h
	rm -f main.o

FORCE:
