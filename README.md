# ♟️ Chess FSM: Sequential Circuits in Verilog

![Language](https://img.shields.io/badge/Hardware_Description-Verilog-blue.svg)
![Course](https://img.shields.io/badge/Course-BBM233_Logic_Design-orange.svg)
![Institution](https://img.shields.io/badge/Institution-Hacettepe_University-red.svg)

## 📌 Overview

This project implements a finite state machine (FSM) that models simplified stages of a chess game. Based on the principle that "you cannot lose the game unless you make a mistake", this Moore FSM models how the game flows between advantageous states for White or Black, depending on whether a mistake is made by either side.

It was developed as **Experiment 5: Sequential Circuits in Verilog** for the BBM233 Digital Design Lab at Hacettepe University.

## ⚙️ System Architecture

The system is a **7-state Moore Machine** with a 1-bit input (`x` representing player moves/mistakes) and a 1-bit output (`F` representing checkmate state).

### FSM States
The 7 states correspond to the simplified phases of chess play:
* **Initial State (000):** The game begins; White makes the first move.
* **Black Turn (001):** Normal position where Black plays and the position remains balanced.
* **WCC States (100, 101):** White Certain Checkmate. White has a forced winning advantage. Correct play leads to checkmate; mistakes revert to balanced play.
* **BCC States (010, 011):** Black Certain Checkmate. Black has a forced winning advantage. Correct play leads to checkmate; mistakes revert to balanced play.
* **Checkmate (110):** The terminal state where the game ends.

## 🛠️ Implementation Details

The project enforces a strict **Structural Design** approach (behavioral logic is not used for FSM state transitions) and includes two complete implementations:

1. **D Flip-Flop Implementation (Core):**
   * Uses a custom positive-edge-triggered D Flip-Flop (`dff.v`) with high-level asynchronous reset.
   * State logic and structural gate-level FSM design are implemented in `machine_d.v`.
   * Verified via `machine_d_tb.v`.

2. **JK Flip-Flop Implementation (Bonus):**
   * Uses a custom positive-edge-triggered JK Flip-Flop (`jkff.v`) with high-level asynchronous reset.
   * State logic, excitation derivations, and structural gate-level FSM design are implemented in `machine_jk.v`.
   * Verified via `machine_jk_tb.v`.

## 📁 Repository Structure
* `dff.v` & `jkff.v`: Custom Flip-Flop modules.
* `machine_d.v` & `machine_jk.v`: Top-level FSM structural modules.
* `machine_d_tb.v` & `machine_jk_tb.v`: Testbenches for waveform verification.
