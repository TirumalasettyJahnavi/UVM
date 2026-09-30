# D Flip-Flop UVM Verification

## Overview

This project demonstrates the functional verification of a **D Flip-Flop (DFF)** using **SystemVerilog and UVM (Universal Verification Methodology)**.

The objective of this project is to verify the functional behavior of the D Flip-Flop by generating stimulus through a UVM testbench, driving it to the DUT, monitoring the outputs, and checking the actual output against the expected behavior using a scoreboard.

---

## DUT – D Flip-Flop

A D Flip-Flop stores the input data (`D`) on the active edge of the clock and transfers it to the output (`Q`).

### Inputs

* `clk` – Clock signal
* `reset` – Reset signal
* `D` – Data input

### Output

* `Q` – Flip-Flop output

---

## UVM Testbench Architecture

The testbench is developed using the following UVM components:

```text
                    UVM TESTBENCH
                         |
                       TEST
                         |
                        ENV
                         |
                       AGENT
                    ┌────┴────┐
                    │         │
                 DRIVER     MONITOR
                    │         │
                    ↓         ↓
                   DUT    SCOREBOARD
                              |
                         EXPECTED vs
                            ACTUAL
```

### UVM Components

* **Sequence Item** – Defines the transaction-level data used for DFF verification.
* **Sequence** – Generates different DFF stimulus.
* **Sequencer** – Sends sequence items to the driver.
* **Driver** – Drives the generated transactions to the DUT through the virtual interface.
* **Monitor** – Samples DUT signals and converts them into transactions.
* **Agent** – Contains the sequencer, driver, and monitor.
* **Scoreboard** – Compares the expected output with the actual DUT output.
* **Environment** – Integrates the UVM components.
* **Test** – Controls the verification scenario and starts the sequence.

---

## Verification Scenarios

The DFF was verified using different input combinations and clock cycles.

### 1. Reset Verification

Checks the behavior of the DFF when reset is asserted.

### 2. Basic Functional Verification

Checks whether the output `Q` correctly follows the input `D` at the active clock edge.

### 3. Different Data Patterns

Verifies the DFF using different combinations of `0` and `1`.

### 4. Randomized Verification

Randomized stimulus is generated to exercise multiple input combinations.

### 5. Scoreboard Checking

The expected output is calculated and compared with the output observed from the DUT.

---

## Verification Flow

```text
Sequence
   ↓
Sequencer
   ↓
Driver
   ↓
DUT
   ↓
Monitor
   ↓
Scoreboard
   ↓
PASS / FAIL
```

---

## Project Structure

```text
DFF/
│
├── DFF_TB/
│   └── dff_uvm_tb.sv
│
├── RESULTS/
│   ├── waveform.png
│   └── simulation.log
│
└── README.md
```

---

## Results

The DFF functionality was verified through simulation.

The simulation waveform demonstrates the relationship between the clock, input data, reset, and output.

The scoreboard compares the expected and actual outputs during simulation.

### Simulation Result

```text
UVM TEST PASSED
Scoreboard comparison completed successfully.
```

> Add the actual waveform screenshot and simulation log inside the `RESULTS` folder.

---

## Tools & Technologies

* SystemVerilog
* UVM
* QuestaSim / ModelSim
* VS Code
* Git & GitHub

---

## Key Learning Outcomes

Through this project, I gained practical experience with:

* UVM testbench architecture
* Creating UVM components
* Transaction-based verification
* Sequence and sequencer concepts
* Driver and monitor implementation
* Scoreboard-based checking
* Virtual interfaces
* UVM factory registration
* Simulation and waveform analysis
* Debugging UVM testbench issues
* Using Git and GitHub to organize verification projects

---

## Future Enhancements

The testbench can be extended with:

* Functional coverage
* Constraint-based randomization
* Multiple directed test scenarios
* Assertion-based verification
* Code coverage analysis

---

## Author

**Jahnavi Tirumalasetty**

Electronics and Communication Engineering
VLSI / Design Verification Enthusiast
