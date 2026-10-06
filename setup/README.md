# Set up your working environment

You need **one** Python environment for the course, with Python 3.12, pandas 3 and the geospatial stack (GeoPandas). Choose **one** of the three paths below, then check it with `notebooks/00_setup_check.ipynb`.

| Your situation | Use |
|---|---|
| macOS or Linux, no conda installed | **A. uv** (recommended) |
| Windows, or you already have Anaconda / Miniconda / Anaconda Navigator | **B. conda** |
| Nothing works, or you prefer containers | **C. Docker** |

> **Already have Anaconda, Miniconda or Anaconda Navigator? Do not install a second conda.** Two condas on the same computer were the most common setup problem. Use path B with the conda you already have.

Environment name used everywhere in the course: **`ub-bigdata-viz`**.

## 0. Get the course repository

Install Git if needed (`git --version` to check):

- macOS: `xcode-select --install` or `brew install git`
- Linux: `sudo apt-get install git`
- Windows: install [Git for Windows](https://git-scm.com/download/win) (you also need it for `04_git_and_github.ipynb`)

Then clone the repository in a folder **without accents or spaces in the path** and, on Windows, **outside OneDrive-synced folders** (e.g. `C:\Users\<you>\code\`):

```console
git clone https://github.com/jvicens/analysis-and-visualization-of-big-data-course.git
cd analysis-and-visualization-of-big-data-course
```

## A. uv (recommended on macOS / Linux)

[uv](https://docs.astral.sh/uv/) installs Python and all packages from `pyproject.toml` and `uv.lock`, so everybody gets the same versions.

```console
# install uv once
curl -LsSf https://astral.sh/uv/install.sh | sh          # macOS / Linux
# powershell -c "irm https://astral.sh/uv/install.ps1 | iex"   # Windows

# in the repository folder
uv sync                 # creates .venv with Python 3.12 and all packages
uv run python -m ipykernel install --user --name ub-bigdata-viz --display-name "Python (ub-bigdata-viz)"
uv run jupyter lab      # starts Jupyter inside that environment
```

The second command registers the environment as the Jupyter kernel `ub-bigdata-viz`, the kernel every course notebook asks for. Run it once (and again if you move the repository).

`uv sync` is also how you update after the repository changes. Add a package to your own project with `uv add <package>`.

## B. conda (Windows, or if you already have conda)

All conda paths read the same file, `setup/environment.yml`, and create the environment `ub-bigdata-viz` from the conda-forge channel (this is what makes GeoPandas install cleanly on Windows).

### B1. Script — macOS / Linux

```console
bash setup/install_env.sh
```

### B2. Script — Windows, Anaconda Prompt

1. Open **Anaconda Prompt** from the Start menu.
2. `cd` to the repository folder, e.g. `cd %USERPROFILE%\code\analysis-and-visualization-of-big-data-course`
3. Run `setup\install_env.bat`

### B3. Script — Windows PowerShell

Only if conda already works in PowerShell (otherwise run `conda init powershell` once from the Anaconda Prompt and open a new PowerShell):

```console
powershell -ExecutionPolicy Bypass -File setup\install_env.ps1
```

### B4. Anaconda Navigator (no command line)

1. Open **Anaconda Navigator** → **Environments** → **Import**.
2. Choose **Local drive** and select `setup/environment.yml` from the repository folder.
3. Name: `ub-bigdata-viz` → **Import**. Wait until it finishes (several minutes).
4. Select `ub-bigdata-viz` in the list, go to **Home** and **Launch JupyterLab** (install it there if Navigator asks).

### B5. By hand (any OS)

```console
conda env create -f setup/environment.yml
conda activate ub-bigdata-viz
python -m ipykernel install --user --name ub-bigdata-viz --display-name "Python (ub-bigdata-viz)"
jupyter lab
```

After the repository changes: `conda env update -f setup/environment.yml --prune`.

## C. Docker

```console
docker build -t avbd .
docker run --rm -p 8888:8888 -v "$(pwd)":/home/student/course avbd
```

Open the `http://127.0.0.1:8888/lab?token=...` link printed in the terminal. Your files stay in the repository folder on your computer.

## Check your setup

1. Start Jupyter **from your environment** (`uv run jupyter lab`, or `conda activate ub-bigdata-viz` then `jupyter lab`, or Navigator with `ub-bigdata-viz` selected).
2. Open `notebooks/00_setup_check.ipynb` and run all cells (**Run → Run All Cells**).
3. Every line should show ✅. If not, the last cell tells you what to send to the teacher.

## IDEs

VS Code, PyCharm and Spyder can use the same environment: select the interpreter `.venv` (uv) or `ub-bigdata-viz` (conda) as the notebook kernel.

- [Jupyter kernels in VS Code](https://code.visualstudio.com/docs/datascience/jupyter-kernel-management)
- [Jupyter notebooks in PyCharm](https://www.jetbrains.com/help/pycharm/jupyter-notebook-support.html)

## Troubleshooting

| Symptom | Fix |
|---|---|
| `conda` not found (Windows) | Use the **Anaconda Prompt**, not the plain Command Prompt. |
| Two condas installed (e.g. Navigator and Miniconda) | Keep one; uninstall the other, then repeat path B. |
| `ModuleNotFoundError` in a notebook | The notebook runs on another kernel: pick **Python (ub-bigdata-viz)** in the top-right kernel menu. If it is not listed, run the kernel registration command of your path again. |
| GeoPandas or GDAL errors on Windows | Install with conda (path B), never with `pip install geopandas`. |
| Paths with accents, spaces or OneDrive | Move the repository to `C:\Users\<you>\code\` and retry. |
