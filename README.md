# UART Serial Receiver FSM

This project implements a simple UART (Universal Asynchronous Receiver Transmitter) Serial Data Receiver using a Finite State Machine (FSM) in SystemVerilog.

## 🔧 Features

- FSM-based design for robust data reception
- Detects **start bit**, **8 data bits** (LSB first), and **stop bit**
- Outputs a valid flag when a full byte is received
- Written and simulated in SystemVerilog

## 📁 Files

- `serial_UART.sv`: UART Receiver design using FSM
- `tb_serial_UART.sv`: Testbench to validate the receiver
- `README.md`: Project overview and usage instructions

## 🧠 FSM States

1. **IDLE**: Wait for start bit (`serial_in == 0`)
2. **START**: Confirm start bit
3. **DATA**: Shift in 8 data bits (LSB first)
4. **STOP**: Validate stop bit (`serial_in == 1`)
5. **DONE**: Assert `valid = 1` and output the data

## 🚀 Simulation

You can simulate this design using any SystemVerilog simulator (ModelSim, VCS, or [EDA Playground](https://edaplayground.com/)).

### Steps:

1. Compile and run the testbench:
