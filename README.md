# vbox-builder

Tool for building VirtualBox images.

_Some pieces to this repo has been borrowed from [Windows Templates for Packer](https://github.com/joefitzgerald/packer-windows)._

The following software will be installed on the virtual machine:
- 7-Zip
- Sysinternals Suite
- Firefox
- Python
- Git for Windows
- Atom
- IntelliJ IDEA
- Maven

## Prerequisites
- [packer](https://packer.io/) should be installed and the packer directory should be added to the search path
- [VirtualBox](https://www.virtualbox.org/)
- [Python 2.7.x](https://www.python.org/downloads/)
- Download Windows 10 Enterprise Evaluation Copy from <https://www.microsoft.com/en-us/evalcenter/evaluate-windows-10-enterprise?i=1> and save it in ./iso

## Create Virtual Machine
The following command will create a Windows 10 virtual machine
```
$ python run_packer.py --username myUser --password myPassword
```

The `--no-updates` argument will skip the installation of Windows updates and can be used to speed up the creation of a virtual machine.
```
$ python run_packer.py --username myUser --password myPassword --no-updates
```
