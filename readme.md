# PPMC (Process Pool Manager & Controller)

A lightweight process pool manager and load balancer written in Zig. PPMC manages multiple worker processes and efficiently distributes incoming requests across them using a reverse proxy mechanism.

## Overview

PPMC (Process Pool Manager & Controller) is designed to:
1. Spawn and manage multiple worker processes
2. Act as a reverse proxy to distribute incoming requests
3. Provide automatic load balancing across worker processes
4. Handle process lifecycle management

## Usage

```shell
zigpm --p=PORT [--workers=N] -- <command...>
