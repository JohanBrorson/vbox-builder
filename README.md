# vbox-builder

Tool for building VirtualBox images.

_Some pieces to this repo has been borrowed from [Windows Templates for Packer](https://github.com/joefitzgerald/packer-windows)._

## Prerequisites
- [packer](https://packer.io/) should be installed and the packer direcorty should be added to the search path
- [VirtualBox](https://www.virtualbox.org/)
- [Python 2.7.x](https://www.python.org/downloads/)
- Download Windows 10 Enterprise Evaluation Copy from [https://www.microsoft.com/en-us/evalcenter/evaluate-windows-10-enterprise?i=1] and save it in ./iso

## Create Virtual Machine

```
$ python run_packer.py --username myUser --password myPassword
```
