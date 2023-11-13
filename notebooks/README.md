# Notebooks

## Table of Contents
1. [Software requirements](#software-requirements)
2. [Setting up your working environment](#setting-up-your-working-environment-a-namesea)
   1. [Install Python and pip](#install-python-and-pip3)
   3. [Create a virtual environment](#create-a-virtual-environment)
      1. [virtualenv](#virtualenv)
      2. [conda](#conda)
4. [Comments](#comments)

## Software requirements 

* Python 3.8 or higher
* Essential Python packages in `requirements.txt`
  * [geopandas](https://geopandas.org/)
  * [numpy](https://numpy.org/)
  * [matplotlib](https://matplotlib.org/)
  * [pandas](https://pandas.pydata.org/)
  * [scipy](https://scipy.org/)
  * [sodapy](https://github.com/xmunoz/sodapy)
* Jupyter Notebooks or Jupyter Lab
  * [Installing Jupyter](https://jupyter.org/install)

## Setting up your working environment 

### Install Python and pip3
Check Python version installed:
```console
$ python3 --version
```
In case you do not have a version of Python installed, you can do it following in this way:

Linux
```console
$ sudo apt-get update 
$ sudo apt-get install python3
```

MacOS
```console
$ brew install python3
```

Check pip3 is installed:
```console
$ command -v pip3
```

In principle is MacOS pip3 is installed by default with Python, in Linux you need to install it manually:
```console
$ sudo apt-get install python3-pip
$ sudo apt-get update 
```

### Create a Virtual Environment
#### virtualenv

Check if `virtualenv` is installed:

```console
$ virtualenv –-version
```

In case the library is not installed in your systems:

Linux
```console
$ sudo apt-get install python3-venv 
```

MacOS
```console
$ python3 -m pip install --user virtualenv
```

#### Setting up your virtual environment

Via terminal move to the root directory in your repository and create the environment:

```console
$ python3 -m venv <name_virtual_environment>
```
It creates the venv in the root of your repository. This venv has to be added into `.gitignore` file to avoid commit the
environment.

```console
$ source <name_virtual_environment>/bin/activate
```

Install the requirements:
```console
$ pip3 install -r requirements.txt
```

Create a Kernel for Jupyter Notebooks
```
$ ipython kernel install --name <name_kernel> --user
```

#### Conda

### Comments

- With `virtualenv` you can create and independent virtual environment: `mkvirtualenv <name_virtual_environment>`
- List all virtual environments installed: `lsvirtualenv -b`
- There is no way to remove a virtual environment with a command. The only way to do it is `sudo rm -rf venv`
- Delete a Kernel with this command: `jupyter kernelspec remove old_kernel`