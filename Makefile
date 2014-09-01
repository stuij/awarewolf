TARGET = bin/aw
INCLUDES = -I=/usr/local/include
LIBS = -lrt -lm -L/usr/local/lib -lwiringPi # -L/home/zeno/pi/aware-root/usr/local/lib
CC = /home/zeno/pi/tools/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian/bin/arm-linux-gnueabihf-gcc
CFLAGS = -g -Wall
SYSROOT = --sysroot=/home/zeno/pi/aware-root

.PHONY: default all clean

default: $(TARGET)
all: default

FILES = motor-test.c
OBJECTS = $(patsubst %.c, %.o, $(FILES))
HEADERS = BrickPi.h tick.h

%.o: %.c $(HEADERS)
	$(CC) $(SYSROOT) $(INCLUDES) $(CFLAGS) -c $< -o $@

.PRECIOUS: $(TARGET) $(OBJECTS)

$(TARGET): $(OBJECTS)
	$(CC) $(OBJECTS) $(SYSROOT) -Wall $(LIBS) -o $@

clean:
	-rm -f *.o
	-rm -f $(TARGET)
