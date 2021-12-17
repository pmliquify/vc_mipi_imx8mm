# Vision Components MIPI CSI-2 driver for Toradex Verdin i.MX8M Mini
![VC MIPI camera](https://www.vision-components.com/fileadmin/external/documentation/hardware/VC_MIPI_Camera_Module/VC_MIPI_Camera_Module_Hardware_Operating_Manual-Dateien/mipi_sensor_front_back.png)

## Version 0.1.0
* Supported boards
  * Toradex Dahlia Carrier Board V1.0C
* Supported cameras 
  * VC MIPI IMX327C
* Linux kernel 
  * Version 5.4.77
* Features
  * Image Streaming in Y10 and SBGGB10 format.
  * Exposure and Gain can be set via V4L2 library.

## Prerequisites for cross-compiling
### Host PC
* Recommended OS is Ubuntu 18.04 LTS
* You need git to clone this repository
* All other packages are installed by the scripts contained in this repository

# Installation

1. Create a directory and clone the repository. 
   ```
     $ cd <working_dir>
     $ git clone https://github.com/pmliquify/vc_mipi_imx8mm
   ```

2. Setup the toolchain and the kernel sources. The script will additionaly install some necessary packages like *build-essential* and *device-tree-compiler*.
   ```
     $ cd vc_mipi_imx8mm/bin
     $ ./setup.sh --host
   ```

3. Build the kernel image and the device tree file.
   ```
     $ ./build.sh --all
   ```

4. Flash the kernel image and the device tree file to the target and reboot.
   ```
     $ ./flash.sh --reboot --all
   ```

5. Login and check if the driver was loaded properly. You should see something like this in the second box.
   ```
     verdin-imx8mm login: root
     # dmesg | grep 2-001a
   ```
   ```
     [...] vc_mipi_imx 2-001a: imx_probe(): Probing v4l2 sensor at addr 0x1a - Dec 17 2021/14:57:41
     [...] vc_mipi_imx 2-001a: imx_board_setup: VC Sensor device-tree has configured 2 data-lanes: sensor_mode=0
     [...] vc_mipi_imx 2-001a: imx_board_setup(): VC FPGA found!
     [...] vc_mipi_imx 2-001a: [ MAGIC  ] [ mipi-module ]
     [...] vc_mipi_imx 2-001a: [ MANUF. ] [ Vision Components ] [ MID=0x0427 ]
     [...] vc_mipi_imx 2-001a: [ SENSOR ] [ SONY IMX327C ]
     [...] vc_mipi_imx 2-001a: [ MODULE ] [ ID=0x0327 ] [ REV=0x0002 ]
     [...] vc_mipi_imx 2-001a: [ MODES  ] [ NR=0x0002 ] [ BPM=0x0010 ]
     [...] vc_mipi_imx 2-001a: [ COLOR  ] [  C ]
     [...] vc_mipi_imx 2-001a: imx_board_setup(): Detected sensor model: 'IMX327 color'
     [...] mxc_mipi-csi 32e30000.mipi_csi: Registered sensor subdevice: vc_mipi_imx 2-001a
     [...] vc_mipi_imx 2-001a: width,height=1920,1080 bytesperline=3840 sizeimage=4147200 pix_fmt='RG10', sensor_mode=0
     [...] vc_mipi_imx 2-001a: imx_probe(): Probed VC MIPI sensor 'IMX327 color' - Dec 17 2021/14:57:41
   ```

# Testing the camera
To test the camera you can use [Vision Components MIPI CSI-2 demo software](https://github.com/pmliquify/vc_mipi_demo)