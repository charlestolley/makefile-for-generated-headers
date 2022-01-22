$(info MAKE_RESTARTS = $(MAKE_RESTARTS))
$(info MAKELEVEL = $(MAKELEVEL))

CC = /usr/bin/gcc

NAMES = main hello
DEP = $(foreach name,$(NAMES),$(name).d)
OBJ = $(foreach name,$(NAMES),$(name).o)
main: $(OBJ)

ifeq ($(MAKELEVEL),0)
main:
	$(CC) $(LDFLAGS) $^ $(LDLIBS) -o $@

%.h: %.h.txt
	cp $< $@

%.d: %.c
	$(CC) -MM -MG $(CPPFLAGS) $< | sed 's,\($*\.o\)\s*:\s*,\1 $@: ,' > $@

%.o: %.c
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
$(DEP) $(OBJ): FORCE
	echo include $(patsubst %.o,%.d,$@)

.SUFFIXES:
.DEFAULT:
	true
endif

.PHONY: FORCE clean
clean: FORCE
	rm -f $(INCLUDES_TARGET)
	rm -f main
	rm -f *.d
	rm -f *.h
	rm -f *.o

FORCE:
