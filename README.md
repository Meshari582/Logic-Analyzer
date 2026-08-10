## FPGA (Verilog)
- `sync` — 2-flop synchronizer for all async inputs (probe, strobe, arm)
- `rate_div` — sample-rate clock enable generator (10 kS/s–10 MS/s)
- `trigger` — edge-triggered detection, selectable polarity
- `capture` — capture state machine (IDLE → ARMED → RUNNING → FULL)
- `buffer` — 16384-deep, 1-bit on-chip RAM; sample 0 = trigger sample
- `readout` — strobe-driven serial readout to the MCU

## Firmware (C)
STM32 firmware handling the FPGA readout link and host communication.

## PC App (Python)
Waveform display and measurement tool.

## Status
🚧 In development — single-channel end-to-end chain, built incrementally as part of a 1-month internship project.
