               CFLAGS:=	-O
            CINCLUDES:=	-I.
              Library:=	libgswteos10.so
      $(Library)_SRCS:=	gsw_oceanographic_toolbox.c \
			gsw_saar.c
      $(Library)_OBJS:=	gsw_oceanographic_toolbox.o \
			gsw_saar.o

all:	$(Library) teos10.so

library:	$(Library)

$(Library):	$($(Library)_SRCS)
	gcc -fPIC -c $(CFLAGS) $(CINCLUDES) $($(Library)_SRCS)
	gcc -shared -o $(Library) $($(Library)_OBJS) -lm
teos10.so:
	R CMD shlib teos10.c

clean:
	rm -f $(Library) $($(Library)_OBJS) teos10.so
