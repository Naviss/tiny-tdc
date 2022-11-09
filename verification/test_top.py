import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, FallingEdge, Timer, ClockCycles


segments = [ 63, 6, 91, 79, 102, 109, 124, 7, 127, 103 ]

@cocotb.test()
async def test_7seg(dut):
    dut._log.info("start")
    clock = Clock(dut.clk, 10, units="us")
    cocotb.fork(clock.start())
    dut.stop.value = 0
    dut.start.value = 0

    dut._log.info("reset")
    dut.rst.value = 1
    await ClockCycles(dut.clk, 10)
    dut.rst.value = 0
    await ClockCycles(dut.clk, 10)
    dut.start.value = 1
    await ClockCycles(dut.clk, 1)
    dut.stop.value = 1
    await ClockCycles(dut.clk, 10)
    dut.stop.value = 0
    dut.start.value = 0
    await ClockCycles(dut.clk, 10)
