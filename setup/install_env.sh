#!/usr/bin/env bash
# ============================================================
#  Analysis and Visualization of Big Data — conda setup (macOS / Linux)
#  Creates or updates the conda environment 'ub-bigdata-viz' from
#  setup/environment.yml and registers it as a Jupyter kernel.
#  Works with Miniconda, Anaconda and Miniforge. Does not change your
#  global conda configuration.
#
#  Run from the repository root:   bash setup/install_env.sh
# ============================================================
set -euo pipefail

ENV_NAME="${AVBD_ENV_NAME:-ub-bigdata-viz}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ENV_FILE="$SCRIPT_DIR/environment.yml"

fail() {
  echo
  echo "[ERROR] $1"
  echo "If you cannot solve it, copy this whole window and send it to the teacher."
  exit 1
}

echo "=== 1/4 Looking for conda ==="
if ! command -v conda >/dev/null 2>&1; then
  for base in "$HOME/miniconda3" "$HOME/anaconda3" "$HOME/miniforge3" "/opt/anaconda3" "/opt/miniconda3"; do
    if [[ -f "$base/etc/profile.d/conda.sh" ]]; then
      # shellcheck disable=SC1091
      source "$base/etc/profile.d/conda.sh"
      break
    fi
  done
fi
command -v conda >/dev/null 2>&1 || fail "conda was not found. Install Miniconda (or use the uv path in setup/README.md)."

CONDA_BASE="$(conda info --base)"
echo "Using conda at: $CONDA_BASE"

found=()
for base in "$HOME/miniconda3" "$HOME/anaconda3" "$HOME/miniforge3" "/opt/anaconda3" "/opt/miniconda3"; do
  [[ -x "$base/bin/conda" ]] && found+=("$base")
done
if (( ${#found[@]} > 1 )); then
  echo "[WARNING] More than one conda installation found: ${found[*]}"
  echo "          Keep only one. This script uses: $CONDA_BASE"
fi

# shellcheck disable=SC1091
source "$CONDA_BASE/etc/profile.d/conda.sh"

echo "=== 2/4 Creating or updating '$ENV_NAME' (this can take several minutes) ==="
if conda env list | awk '{print $1}' | grep -qx "$ENV_NAME"; then
  conda env update -n "$ENV_NAME" -f "$ENV_FILE" --prune || fail "Could not update the environment."
else
  conda env create -n "$ENV_NAME" -f "$ENV_FILE" || fail "Could not create the environment."
fi

echo "=== 3/4 Registering the Jupyter kernel ==="
conda activate "$ENV_NAME"
python -m ipykernel install --user --name "$ENV_NAME" --display-name "Python ($ENV_NAME)" \
  || fail "Could not register the Jupyter kernel."

echo "=== 4/4 Quick check ==="
python -c "import pandas, geopandas, matplotlib; print('pandas', pandas.__version__, '| geopandas', geopandas.__version__)" \
  || fail "The libraries do not import."

echo
echo "======================================================="
echo " Setup complete. Every time you work on the course:"
echo "     conda activate $ENV_NAME"
echo "     jupyter lab"
echo " Then open notebooks/00_setup_check.ipynb and run all cells."
echo "======================================================="
