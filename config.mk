GSC = ${shell [ `which gambit-gsc 2>/dev/null` ] && echo gambit-gsc || echo gsc}

all: ${targets}

%.o1: %.scm
	-rm -f $@ 2>/dev/null
	${GSC} ${GSCFLAGS} -cc-options "${CFLAGS}" -ld-options "${LDFLAGS}" $<

clean:
	-rm -f ${targets} 2>/dev/null
