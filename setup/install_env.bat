@echo off
REM ============================================================
REM  UB Big Data & Visualization - Windows Miniconda Setup
REM  Creates a conda env 'ub-bigdata-viz' (Python 3.11)
REM  Installs Jupyter + data/plotting libraries (incl. GeoPandas)
REM ============================================================

setlocal enabledelayedexpansion

REM Detect conda
where conda >nul 2>&1
if errorlevel 1 (
  echo [ERROR] 'conda' was not found in PATH.
  echo Please install Miniconda or Anaconda and re-run this script.
  echo https://docs.conda.io/projects/conda/en/latest/user-guide/install/windows.html
  pause
  exit /b 1
)

REM Accepting ToS conda channels
echo Accepting ToS conda channels
conda tos accept --override-channels --channel https://repo.anaconda.com/pkgs/main
conda tos accept --override-channels --channel https://repo.anaconda.com/pkgs/r

REM Update conda (optional but recommended)
echo Updating conda...
conda update -n base -c defaults conda -y

REM Create env
echo Creating conda environment 'ub-bigdata-viz' (Python 3.11)...
conda create -n ub-bigdata-viz python=3.11 -y

REM Activate env
call conda activate ub-bigdata-viz

REM Ensure conda-forge is used for geospatial stack
conda config --add channels conda-forge
conda config --set channel_priority strict

REM Install core packages from environment.yml if available
if exist environment.yml (
  echo Installing packages from environment.yml ...
  conda env update -n ub-bigdata-viz -f environment.yml
) else (
  echo Installing packages directly...
  conda install -n ub-bigdata-viz jupyterlab ipykernel numpy pandas matplotlib seaborn scipy openpyxl plotly geopandas fiona shapely pyproj rtree -y
  pip install ydata-profiling sodapy pandas-bokeh
)

REM Register kernel
python -m ipykernel install --user --name ub-bigdata-viz --display-name "Python (ub-bigdata-viz)"

echo.
echo =====================================
echo   Setup complete!
echo   To start work, run:
echo     conda activate ub-bigdata-viz
echo     jupyter lab
echo =====================================
pause
