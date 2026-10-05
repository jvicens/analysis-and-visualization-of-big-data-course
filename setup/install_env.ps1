# ============================================================
#  Analysis and Visualization of Big Data - conda setup (Windows PowerShell)
#  Run from the repository folder:   powershell -ExecutionPolicy Bypass -File setup\install_env.ps1
#  Requires that conda works in PowerShell (run "conda init powershell" once
#  from the Anaconda Prompt, then open a new PowerShell window).
# ============================================================
$ErrorActionPreference = "Stop"
$EnvName = "ub-bigdata-viz"
$EnvFile = Join-Path $PSScriptRoot "environment.yml"

function Fail($msg) {
    Write-Host ""
    Write-Host "[ERROR] $msg" -ForegroundColor Red
    Write-Host "If you cannot solve it, copy this whole window and send it to the teacher."
    exit 1
}

Write-Host "=== 1/4 Looking for conda ==="
if (-not (Get-Command conda -ErrorAction SilentlyContinue)) {
    Fail "conda is not available in PowerShell. Open the Anaconda Prompt, run 'conda init powershell', open a new PowerShell and retry. Or use setup\install_env.bat from the Anaconda Prompt."
}
$CondaBase = (conda info --base).Trim()
Write-Host "Using conda at: $CondaBase"

Write-Host "=== 2/4 Creating or updating $EnvName (this can take several minutes) ==="
$exists = (conda env list) -match "^$EnvName\s"
if ($exists) {
    conda env update -n $EnvName -f $EnvFile --prune
} else {
    conda env create -n $EnvName -f $EnvFile
}
if ($LASTEXITCODE -ne 0) { Fail "Could not create or update the environment." }

Write-Host "=== 3/4 Registering the Jupyter kernel ==="
conda run -n $EnvName python -m ipykernel install --user --name $EnvName --display-name "Python ($EnvName)"
if ($LASTEXITCODE -ne 0) { Fail "Could not register the Jupyter kernel." }

Write-Host "=== 4/4 Quick check ==="
conda run -n $EnvName python -c "import pandas, geopandas, matplotlib; print('pandas', pandas.__version__, '| geopandas', geopandas.__version__)"
if ($LASTEXITCODE -ne 0) { Fail "The libraries do not import." }

Write-Host ""
Write-Host "======================================================="
Write-Host " Setup complete. Every time you work on the course:"
Write-Host "     conda activate $EnvName"
Write-Host "     jupyter lab"
Write-Host " Then open notebooks\00_setup_check.ipynb and run all cells."
Write-Host "======================================================="
