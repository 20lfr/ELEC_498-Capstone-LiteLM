# Makefile for corrected FPGA firmware
CXX = g++
CXXFLAGS = -std=c++17 -Wall -O2 -I./include
LDFLAGS = -lpthread

SRCS = src/pl_interface.cpp src/inference_engine.cpp
OBJS = $(SRCS:.cpp=.o)
TARGET = inference_engine

# ARM cross-compile (uncomment for Zynq)
# CXX = aarch64-linux-gnu-g++

all: $(TARGET)

$(TARGET): $(OBJS)
	$(CXX) $(CXXFLAGS) -o $@ $^ $(LDFLAGS)

%.o: %.cpp
	$(CXX) $(CXXFLAGS) -c -o $@ $<

clean:
	rm -f $(OBJS) $(TARGET)

.PHONY: all clean
