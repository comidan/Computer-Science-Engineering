# Advanced Operating Systems

## Topics

### Introduction and background

- General characteristics and roadmaps of the embedded systems.
- Peculiarities of the applications and system software for embedded systems.
- Reading technical documentation of microcontrollers and peripherals with the aim of developing device drivers.
- Example of main showstoppers: energy of software, system-level power management, memory footprint, reactivity.

### Management of contention and concurrency
- Scheduling of CPU for single and multi-many core architectures.
- Frameworks for the run-time management of resources.
- Access to shared resources: management of deadlock and starvation, primitives for IPC in systems with processes and threads.
- Design patterns and common pitfalls in concurrent programming, using the C++11 threading API as a reference.

### Software development for dedicated applications
- Main abstractions: assembler, source, libraries, system software, firmware, middleware.
- Real-time operating systems: general characteristics, limits of traditional schedulers, configuration, user control.
- System boot: exception vector and interrupts, C runtime initialization, role of boot loader and kernel initialization (ex. with ARM and STM32).
- Interfacing external devices (e.g. UART, Bluetooth), management of interrupts and GPIOs.
- Software development and management of code (e.g. GIT, GCC, Shell).
- Tools for analysis/profiling of embedded code (e.g. STM Studio, Keil).
- Examples based on Linux.

### Device drivers
- Memory management, I/O memory and ports, the unix filesystem as an abstraction to access peripherals: char devices and file operations.
- The interaction of time management and process scheduling with the development of device drivers.
- Interrupt management.
- Examples based on Miosix RTOS.
- Some hands-on (optional) experiments using an STM32 board under the supervision of the assistants are foreseen to familiarize the student with the development of applications, by exploiting real development platforms.

### Interfacing external sensors
- Type and characteristics of commercial sensors.
- Use of standard protocols (SPI, I2C) with a MCU and interface to the analog world.
- Examples of interfacing photodiodes using ADC, 3-axes accelerometer via SPI.

### Management of time and timers.
