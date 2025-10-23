#!/usr/bin/env bash
# ============================================================
#  UB Big Data & Visualization - Linux/macOS Miniconda Setup
#  Creates a conda env 'ub-bigdata-viz' (Python 3.11)
#  Installs Jupyter + data/plotting libraries (incl. GeoPandas)
# ============================================================

source "$HOME/miniconda3/etc/profile.d/conda.sh"
set -e  # stop if any command fails

echo "=== Checking conda installation ==="
if ! command -v conda &> /dev/null
then
  echo "[ERROR] Conda not found. Please install Miniconda or Anaconda first:"
  echo "https://docs.conda.io/projects/conda/en/latest/user-guide/install/"
  exit 1
fi

echo "=== Accepting ToS conda channels ==="

conda tos accept --override-channels --channel https://repo.anaconda.com/pkgs/main
conda tos accept --override-channels --channel https://repo.anaconda.com/pkgs/r


echo "=== Updating conda base ==="
conda update -n base -c defaults conda -y


echo "=== Creating environment 'ub-bigdata-viz' with Python 3.11 ==="
conda create -n ub-bigdata-viz python=3.11 -y

echo "=== Activating environment ==="
# Activate environment within the script
source "$(conda info --base)/etc/profile.d/conda.sh"
conda activate ub-bigdata-viz

echo "=== Ensuring conda-forge channel priority ==="
conda config --add channels conda-forge
conda config --set channel_priority strict

if [[ -f "environment.yml" ]]; then
  echo "=== Installing packages from environment.yml ==="
  conda env update -n ub-bigdata-viz -f environment.yml
else
  echo "=== Installing default packages directly ==="
  conda install -n ub-bigdata-viz jupyterlab ipykernel numpy pandas matplotlib seaborn scipy openpyxl plotly geopandas fiona shapely pyproj rtree -y
  pip install ydata-profiling sodapy pandas-bokeh
fi

echo "=== Registering kernel for Jupyter ==="
python -m ipykernel install --user --name ub-bigdata-viz --display-name "Python (ub-bigdata-viz)"

echo
echo "======================================================="
echo " Setup complete!"
echo " To start working, open a terminal and run:"
echo "     conda activate ub-bigdata-viz"
echo "     jupyter lab"
echo "======================================================="
