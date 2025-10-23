# Setup the working environment

## Table of Contents
1. [Software requirements](#software-requirements)
2. [Setting up your working environment](#setting-up-your-working-environment-a-namesea)
   1. [Install Python and pip](#install-python-and-pip3)
   2. [Create a virtual environment](#create-a-virtual-environment)
      1. [virtualenv](#virtualenv)
      2. [conda](#conda)
      3. [Additional Tips](#additional-tips)
   3. [Automated setup scripts (.bat/.sh)](#Automated-Setup-Scripts)
   4. [Docker](#docker)

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
python3 --version
```
In case you do not have a version of Python installed, you can do it following in this way:

Linux
```console
sudo apt-get update 
sudo apt-get install python3
```

MacOS
```console
brew install python3
```

Check pip3 is installed:
```console
command -v pip3
```

In principle is MacOS pip3 is installed by default with Python, in Linux you need to install it manually:
```console
sudo apt-get install python3-pip
sudo apt-get update 
```

### Create a Virtual Environment
Virtual environments ensures package dependencies don't interfere with your systems libraries or base environments.
Then can install the appropriated libraries by using the file `requirements.txt containing the Python packages to install, 

#### virtualenv

Check if `virtualenv` is installed:

```console
virtualenv –-version
```

In case the library is not installed in your systems:

Linux
```console
sudo apt-get install python3-venv 
```

MacOS
```console
python3 -m pip install --user virtualenv
```

#### Setting up your virtual environment

Via terminal move to the root directory in your repository and create the environment:

```console
python3 -m venv <name_virtual_environment>
```
It creates the venv in the root of your repository. This venv has to be added into `.gitignore` file to avoid commit the
environment.

```console
source <name_virtual_environment>/bin/activate
```

Install the requirements, running the following command: 
```console
pip3 install -r requirements.txt
```

Create a Kernel for Jupyter Notebooks
```
ipython kernel install --name <name_kernel> --user
```

#### Conda

Before proceeding, ensure you have the following installed:
- **Anaconda** or **Miniconda** installed on your Windows / MacOs / Linux machine. You can download:
  - [Anaconda](https://www.anaconda.com/products/individual)
  - [Miniconda](https://docs.conda.io/en/latest/miniconda.html)

Check if Conda is installed. This should display the Conda version installed on your system:
```bash
conda --version
```
Once Conda is installed you can create a new conda environment.
```
conda create --name <name_virtual_environment> python=3.10
```
Once the environment is created you can activate it using:
```
conda activate <name_virtual_environment>
```
To deactivate the environment later you can run:
```
conda deactivate
```
Install the requirements:
```console
conda install --file requirements.txt
```
In case some libraries are not found in Conda add new channels, specially conda-forge that contains the most recent
scientific libraries `conda config --add channels conda-forge`


In the exceptional case that some packages are not available via Conda (i.e., they are only available via pip), you can combine both. 
First, install what Conda can handle and then:
```
pip install -r requirements.txt
```


Once you have all the environment set up create a Kernel for Jupyter Notebooks
```
ipython kernel install --name <name_kernel> --user
```

#### Additional tips

- With `virtualenv` you can create and independent virtual environment: `mkvirtualenv <name_virtual_environment>`
- List all virtual environments installed: `lsvirtualenv -b` or `conda list`
- There is no way to remove a virtual environment with a command. The only way to do it is `sudo rm -rf <name_virtual_environment>` or in the case of conda `conda remove --name <name_virtual_environment> --all`
- Delete a Kernel with this command: `jupyter kernelspec remove old_kernel`
- Save the list of installed packages in an environment with: `pip freeze > requirements.txt` or `conda env export > environment.yml`
- Create an environment from the `environment.yml` file, use: `conda env create -f environment.yml`

### Automated Setup Scripts

The .bat file contains a series of commands written in plain text that Windows executes line by line when you 
double-click the file or run it from the command prompt.

The file `install_env.bat` automates the environment setup for students on Windows with Miniconda.
It performs the following steps:

1. Checks that conda is installed and available.
2. Updates Conda (optional).
3. Creates the environment named `ub-avbd` with Python 3.11.
4. Installs all dependencies from `environment.yml`.
5. Registers the environment as a Jupyter kernel named `Python (ub-avbd)`.
6. Prints instructions to start Jupyter Lab:
```
conda activate ub-avbd
jupyter lab
```

Same procedure is followed by Linux/Mac users but using the file `install_env.sh`.
1. Save it in your course root
2. Then make it executable, in case is not:
```
chmod +x install_env.sh
```
3. and run it:
```
./install_env.sh
```

### Docker

#### Build and Run the Docker Container

1. Build the Docker image: In the directory where your Dockerfile is located, run:
```
docker build -t jupyter-venv .
```
2. Run the Docker container:
```
docker run -p 8888:8888 -v $(pwd):/home/jupyter jupyter-venv
```
This will map port 8888 on your host to the Jupyter notebook running in the Docker container and mount the current directory into the container’s /home/jupyter.

3. Access Jupyter Notebook: Open your browser and go to: `http://localhost:8888`

