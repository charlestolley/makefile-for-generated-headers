$(info MAKE_RESTARTS = $(MAKE_RESTARTS))
$(info MAKELEVEL = $(MAKELEVEL))

CC = /usr/bin/gcc

main: main.o

ifeq ($(MAKELEVEL),0)
main:
	$(CC) $(LDFLAGS) $^ $(LDLIBS) -o $@

main.h: main.h.txt
	cp $< $@

main.d: main.c
	$(CC) -MM -MG $(CPPFLAGS) $< | sed 's,\($*\.o\)\s*:\s*,\1 $@: ,' > $@

main.o: main.c
	$(CC) $(CPPFLAGS) $(CFLAGS) -c -o $@ $<

INCLUDES_TARGET = .includes.mk
ifeq ($(MAKE_RESTARTS),)
INCLUDES_PREREQS = FORCE
endif

$(INCLUDES_TARGET): $(INCLUDES_PREREQS)
	$(MAKE) $(MAKECMDGOALS) > $@.tmp || touch $@.tmp
	grep "^include .*\.d\$$" $@.tmp | sort -u > $@
	rm $@.tmp

include $(INCLUDES_TARGET)
else
main.o main.d: FORCE
	echo include $(patsubst %.o,%.d,$@)

.SUFFIXES:
.DEFAULT:
	true
endif

.PHONY: FORCE clean
clean: FORCE
	rm -f $(INCLUDES_TARGET)
	rm -f main
	rm -f main.d
	rm -f main.h
	rm -f main.o

FORCE:
