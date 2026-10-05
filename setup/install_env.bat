@echo off
REM ============================================================
REM  Analysis and Visualization of Big Data - conda setup (Windows)
REM  Run it from the "Anaconda Prompt" (Start menu), in the repository folder:
REM      setup\install_env.bat
REM  Creates or updates the environment 'ub-bigdata-viz' from setup\environment.yml
REM  and registers it as a Jupyter kernel. Does not change your global conda settings.
REM ============================================================
setlocal

set "ENV_NAME=ub-bigdata-viz"
set "ENV_FILE=%~dp0environment.yml"

echo === 1/4 Looking for conda ===
where conda >nul 2>&1
if errorlevel 1 (
  echo [ERROR] conda was not found.
  echo Open the "Anaconda Prompt" from the Start menu and run this script from there.
  goto :error
)
for /f "delims=" %%i in ('conda info --base') do set "CONDA_BASE=%%i"
echo Using conda at: %CONDA_BASE%

echo === 2/4 Creating or updating %ENV_NAME% (this can take several minutes) ===
call conda env list | findstr /b /c:"%ENV_NAME% " >nul
if errorlevel 1 (
  call conda env create -n %ENV_NAME% -f "%ENV_FILE%"
) else (
  call conda env update -n %ENV_NAME% -f "%ENV_FILE%" --prune
)
if errorlevel 1 (
  echo [ERROR] Could not create or update the environment.
  goto :error
)

echo === 3/4 Registering the Jupyter kernel ===
call conda activate %ENV_NAME%
if errorlevel 1 (
  echo [ERROR] Could not activate %ENV_NAME%.
  goto :error
)
python -m ipykernel install --user --name %ENV_NAME% --display-name "Python (%ENV_NAME%)"
if errorlevel 1 (
  echo [ERROR] Could not register the Jupyter kernel.
  goto :error
)

echo === 4/4 Quick check ===
python -c "import pandas, geopandas, matplotlib; print('pandas', pandas.__version__, '| geopandas', geopandas.__version__)"
if errorlevel 1 (
  echo [ERROR] The libraries do not import.
  goto :error
)

echo.
echo =======================================================
echo  Setup complete. Every time you work on the course:
echo      conda activate %ENV_NAME%
echo      jupyter lab
echo  Then open notebooks\00_setup_check.ipynb and run all cells.
echo =======================================================
pause
exit /b 0

:error
echo.
echo If you cannot solve it, copy this whole window and send it to the teacher.
pause
exit /b 1
