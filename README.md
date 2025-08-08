# smtdfc OS

 After dedicating several days to in-depth research on the Linux Kernel, I have developed this project. Although I am not a specialist in C/C++ and possess only a fundamental understanding of operating systems and the inner workings of the Linux kernel, I have nonetheless contributed by creating several supplementary tools and a package manager. These additions were implemented using Golang, my preferred programming language, to enhance and extend the functionality of the project.
 
### Requirements
Before you begin, ensure your system meets the following requirements:
 * Operating System: A Linux-based distribution (e.g., Ubuntu, Debian, Fedora, Arch).
 * Internet Connection: A stable internet connection is required to download tools and source code.
 * Dependencies: The `scripts/prepare.sh` script will install the following packages, which are essential for building the project:
   * bzip2 git vim make gcc libncurses-dev flex bison bc cpio libelf-dev libssl-dev syslinux dosfstools nano git
   * qemu-system-x86
   * e2fsprogs
   * grub-pc-bin grub-efi-amd64-bin xorriso
   * golang-go
 * Device Configuration: To ensure a smooth and efficient build process, the following hardware specifications are recommended:
   * CPU: A multi-core processor (4 cores or more) is highly recommended as the kernel compilation time depends on the number of threads.
   * RAM: A minimum of 4GB of RAM is needed, with 8GB or more recommended for a faster and more stable build process.
   * Storage: At least 10GB of free disk space is required for the source code, build artifacts, and intermediate files.


### Getting Started
First, clone this repository:
```bash
git clone https://github.com/smtdfc/os
```

### Environment Setup
This project uses a prepare script to automate the setup of the development environment.
```bash
bash scripts/prepare.sh
```

This script will install the necessary packages listed in the Dependencies section, download the Linux kernel source code, and also fetch the BusyBox source code.

### Configuration
Perform the configurations according to your requirements in the config directory:
 * `config/linux/.config`: Configure the Linux kernel
 * `config/busybox/.config`: Configure BusyBox
 * `config/config.conf`: General configuration

### Build Kernel
Next, compile the kernel with the following command:
```bash
bash script/kernel/build.sh
```

The compilation process will begin, and its speed will depend on the number of threads on your machine.
After compilation is complete, the kernel will be located at `build/bzImage`.

### Build BusyBox
Continue by compiling BusyBox:
```bash
bash script/busybox/build.sh
```

### Initialize RootFS
To be able to boot the operating system, we need a root filesystem (rootfs) initialized as an initramfs for the system to boot. Initialize it by running:
```bash
bash scripts/rootfs/init.sh
```

### Install the system commands from BusyBox into the rootfs:
```bash
bash scripts/rootfs/install_sys.sh
```

### Install the pre-built tools from the tools directory into the rootfs:
```bash
bash scripts/rootfs/install_tool.sh
```

Then, create the init.cpio file:
```bash
bash scripts/rootfs/create.sh
```

### Boot the OS
Once all processes are complete, the operating system is ready to boot:
```bash
bash scripts/start.sh
```

### Create and Boot from an ISO
You can create an ISO file using the following command:
```bash
bash scripts/iso/create.sh
```

The ISO file will be created at build/smtdfc_os.iso.
You can also boot from the ISO file:
```bash
bash scripts/iso/boot.sh
```

### References
Here are some key resources related to this project for further reading and exploration:
 * Linux Kernel Documentation: The official documentation for the Linux kernel.
 * BusyBox Documentation: The official website for BusyBox, a multi-call binary that combines many common Unix utilities into a single executable.
 * QEMU Documentation: Documentation for the QEMU emulator, which is used to boot and test the operating system.
 * GRUB (GNU GRand Unified Bootloader): Documentation for GRUB, the bootloader used to create the bootable ISO file.
