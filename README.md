# 4-bit Decimal Up/Down Counter using Basys3, PMOD JSTK2, and Verilog

## Description
This project implements a 4-bit decimal up/down counter on the Basys3 FPGA board using Verilog. The counter functionality is controlled through the PMOD JSTK2 (joystick module) for intuitive and interactive user input.

## Key Features
- **4-bit Decimal Counter**: Counts from 0 to 9 in up or down mode.
- **PMOD JSTK2 Integration**:
  - Joystick up to increment the counter.
  - Joystick down to decrement the counter.
- **Display**: Counter value is displayed on the 7-segment display of the Basys3 board.
- **Efficient Verilog Design**: Implemented with modular, reusable, and synthesizable Verilog code.

## Hardware Requirements
- Basys3 FPGA Development Board
- PMOD JSTK2 Joystick Module

## Pin Configuration
| PMODJSTK2 Pin | Function              | Basys 3 Pin |
|---------------|-----------------------|-------------|
| CS            | Chip Select           | JA1         |
| SCLK          | SPI Clock             | JA2         |
| MISO          | Master In Slave Out   | JA3         |
| MOSI          | Master Out Slave In   | JA4         |
| VCC           | Power (3.3V)          | JA7 (3.3V)  |
| GND           | Ground                | JA10 (GND)  |


## Getting Started
1. Clone the repository to your local machine:
   ```bash
   git clone https://github.com/coder-ari/counterJoystickBasys3.git
   ```
2. Open the provided project in Vivado.
3. Connect the PMOD JSTK2 to the Basys3 board as per the pin configuration in the documentation.
4. Synthesize, implement, and program the FPGA.
5. Use the joystick to interact with the counter:
   - Move the joystick **up** to increment.
   - Move the joystick **down** to decrement.

## Applications
- FPGA design practice.
- Demonstrating FPGA-based user input and display systems.
- Learning hardware-software integration for embedded systems.

## File Structure
## File Structure
- **Design Sources**:
  - `PmodJSTK_Demo.v`: Top-level module integrating all components.
  - **joystick**:
    - `PmodJSTK.v`: Interface module for PMOD JSTK2.
    - `spiCtrl.v`: SPI control logic.
    - `spiMode0.v`: SPI Mode 0 implementation.
    - `ClkDiv_66_67kHz.v`: Clock divider for serial clock.
  - **genSndRec**:
    - `ClkDiv_5Hz.v`: Clock divider for 5Hz signal.
  - **display**:
    - `ssdCtrl.v`: Seven-segment display controller.
- **Constraints**:
  - `PmodJSTK_constraints.xdc`: Pin configuration for Basys3 and PMOD JSTK2.
- **Simulation Sources**:
  - `sim_1`: Simulation directory.
    - `PmodJSTK_Demo.v`: Testbench for the top-level module.

## Contributions
Contributions are welcome! Feel free to open issues or submit pull requests to:
- Improve code efficiency.
- Add new features.
- Enhance documentation.

## License
This project is licensed under the [MIT License](LICENSE).

---

### Author
[Aritra Ghosh](https://github.com/your-coder-ari)  
Feel free to reach out for questions or collaboration opportunities!
