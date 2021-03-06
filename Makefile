## Makefile template
## jamie@superjamie,net
# place source and header files in ./src/
# place library files in ./
# place headers to include in ./include/
# objects will be built in ./build/
# exec will be generated in ./
#
## you probably want to change these
# source files to compile
SRCS = main.c other.c
# executable name to compile to
EXEC = executablename
# header files
DEPS = main.h other.h

## you might want to change these
# compiler and linker
CC = gcc
# compiler flags
CFLAGS = -g -Wall -c -Iinclude
# library directory
LIBDIR=-L./
# linker flags
LFLAGS=-lnameoflibrary -Wl,-rpath,./

## dont change these
# directory with all the source in it
VPATH = src
# directory to place objects in
OBJDIR = build
# take source filenames and create object filenames from them
OBJS = $(addprefix $(OBJDIR)/,$(SRCS:.c=.o))

# the first target is run when we type "make"

# the dependencies on sources and executable force us to compile those things first
all: $(SRCS) $(EXEC)

# the executable depends on the objects, so we go to compile them first
$(EXEC): $(OBJS)
	$(CC) $(LIBDIR) $(OBJS) -o $@ $(LFLAGS)

# this finds all source files and compiles them into objects in the object dir
$(OBJDIR)/%.o:%.c $(DEPS)
	$(CC) $(CFLAGS) $< -o $@

# $@ is the left side of the :
# $^ is the right side of the :
# the $< is the first item in the dependencies list
# $@: $< $^

.PHONY: clean

clean:
	rm -f $(OBJS) $(EXEC)
