# Robux Calculator

This program calculates the amount of Robux required to reach a desired number of tokens in a game, including additional Robux for VIP status.

## Table of Contents

- [Overview](#overview)
- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)
- [Notes](#notes)

## Overview

The Robux Calculator is a command-line application written in C++ that helps users determine the Robux needed to achieve a desired number of tokens. It utilizes multi-threading to speed up the calculation process, allowing for parallel processing of token packages.

## Requirements

To compile and run this program, you need:
- C++ compiler that supports C++11 (e.g., g++, clang++)
- CMake (optional, for building with CMake)
- ANSI-compatible terminal for colored output (optional, for better console formatting)


## Notes
- The program uses ANSI escape codes for colored output. Ensure your terminal supports ANSI escape sequences for proper formatting.
- Input validation ensures that token values are non-negative and end in 0 or 5.
- The calculation involves iterating through predefined token packages and using multi-threading for parallel processing.


## Code Attribution

If you find this code useful and decide to use or adapt it, please provide credit to the original author (Hollowen-rocks, Ajvaxs) and provide a link to the repository or mention where you found it. It's important to respect intellectual property and give appropriate credit to contributors.
