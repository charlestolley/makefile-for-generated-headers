CC = /usr/bin/gcc

main: main.o
	$(CC) $(LDFLAGS) $^ $(LDLIBS) -o $@

main.h: main.h.txt
	cp $< $@

main.o: main.c main.h
	$(CC) $(CPPFLAGS) $(CFLAGS) -c -o $@ $<

.PHONY: FORCE clean
clean: FORCE
	rm -f main
	rm -f main.h
	rm -f main.o

FORCE:
