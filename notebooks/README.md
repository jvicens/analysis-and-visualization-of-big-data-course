# Notebooks

## Software requirements

* Python 3.8 or higher
* Essential Python packages in `requirements.txt`
  * 
* Jupyter Notebooks or Jupyter Lab
  * [Installing Jupyter](https://jupyter.org/install)

## Setting up your working environment

### 1. Install Python and pip3
Check Python version installed:
```console
$ python3 --version
```
In case you do not have a version of Python installed, you can do it following in this way:

**Linux**
```console
$ sudo apt-get update 
$ sudo apt-get install python3
```

**MacOS**
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

### 2. Create a Virtual Environment

Check if `virtualenv` is installed:

```console
$ virtualenv –-version
```

In case the library is not installed in your systems:

**Linux**
```console
$ sudo apt-get install python3-venv 
```

**MacOS**
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

#### Comments

- With `virtualenv` you can create and independent virtual environment: `mkvirtualenv <name_virtual_environment>`
- List all virtual environments installed: `lsvirtualenv -b`
- There is no way to remove a virtual environment with a command. The only way to do it is `sudo rm -rf venv`
- Delete a Kernel with this command: `jupyter kernelspec remove old_kernel`