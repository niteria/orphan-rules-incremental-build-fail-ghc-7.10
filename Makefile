HC      = ghc
# aeson-0.9.0.1 is the last version that has `(.=)` function.
# It's a typeclass method after that.
HC_OPTS = -O2 -Wall -package aeson-0.9.0.1 $(EXTRA_HC_OPTS)

SRCS = Types.hs JoinPoint.hs SomethingInBetween.hs Main.hs Types2.hs SomethingInBetween2.hs
OBJS = Types.o JoinPoint.o SomethingInBetween.o Main.o Types2.o SomethingInBetween2.o
HIS = Types.hi JoinPoint.hi SomethingInBetween.hi Main.hi Types2.hi SomethingInBetween2.hi

.SUFFIXES : .o .hs .hi .lhs .hc .s

cool_pgm : $(OBJS)
	rm -f $@
	$(HC) -o $@ $(HC_OPTS) $(OBJS)

# Standard suffix rules
.o.hi:
	@:

.hs.o:
	$(HC) -c $< $(HC_OPTS)

depend :
	$(HC) -M -dep-suffix '' $(HC_OPTS) $(SRCS)

clean:
	rm $(OBJS)
	rm $(HIS)
	rm cool_pgm

# DO NOT DELETE: Beginning of Haskell dependencies
Types2.o : Types2.hs
Main.o : Main.hs
SomethingInBetween2.o : SomethingInBetween2.hs
SomethingInBetween2.o : Types2.hi
Types.o : Types.hs
SomethingInBetween.o : SomethingInBetween.hs
SomethingInBetween.o : Types.hi
JoinPoint.o : JoinPoint.hs
JoinPoint.o : SomethingInBetween2.hi
JoinPoint.o : SomethingInBetween.hi
# DO NOT DELETE: End of Haskell dependencies
