# Analysis and Visualization of Big Data

[![notebooks](https://github.com/jvicens/analysis-and-visualization-of-big-data-course/actions/workflows/notebooks.yml/badge.svg)](https://github.com/jvicens/analysis-and-visualization-of-big-data-course/actions/workflows/notebooks.yml)

Materials for the course **Analysis and Visualization of Big Data** (574455) in the Master on
[Physics of Complex Systems and Biophysics](https://www.ub.edu/portal/web/physics/university-master-s-degrees/-/ensenyament/detallEnsenyament/10195392)
at the Universitat de Barcelona. Edition 2026/27.

Instructors: Josep Perelló and [Julià Vicens](https://jvicens.github.io)

## Start here

1. Set up your environment: [`setup/README.md`](setup/README.md) (uv, conda — including Windows and Anaconda Navigator — or Docker).
2. Open `notebooks/00_setup_check.ipynb` and run all cells **before Session 3**.

## Notebooks

| Notebook                                                                   | Session                       | Topic                                                         |
| -------------------------------------------------------------------------- | ----------------------------- | ------------------------------------------------------------- |
| [`00_setup_check`](notebooks/00_setup_check.ipynb)                         | before S3                     | Is your environment ready?                                    |
| [`01_pandas_basics`](notebooks/01_pandas_basics.ipynb)                     | S3 · Reproducible Foundations | Loading, Series and DataFrames, pandas 3, cleaning, profiling |
| [`02_pandas_wrangling`](notebooks/02_pandas_wrangling.ipynb)               | S4 · Wrangle and Version      | `groupby`, merging by code, reshaping                         |
| [`03_open_data_apis`](notebooks/03_open_data_apis.ipynb)                   | S4                            | Metadata, Socrata and CKAN APIs, pagination, caching, tokens  |
| [`04_git_and_github`](notebooks/04_git_and_github.ipynb)                   | S4 and S6                     | Git's four areas, branches, conflicts, GitHub                 |
| [`05_matplotlib_canvas`](notebooks/05_matplotlib_canvas.ipynb)             | S6 · Branch and Plot          | Figure and Axes, layouts, exporting                           |
| [`06_scientific_plots`](notebooks/06_scientific_plots.ipynb)               | S6                            | Formulas, 3D, the Kuramoto model                              |
| [`07_plotting_ecosystem`](notebooks/07_plotting_ecosystem.ipynb)           | S8 · Space and Time           | Seaborn, Plotly, Bokeh                                        |
| [`08_geospatial_maps`](notebooks/08_geospatial_maps.ipynb)                 | S8                            | CRS, joins by code, honest choropleths, bivariate maps        |
| [`09_time_series`](notebooks/09_time_series.ipynb)                         | S8                            | Dates, resampling, gaps, time zones                           |
| [`10_plot_redesign`](notebooks/10_plot_redesign.ipynb)                     | S10 · Critique and Redesign   | Ten rules, redesign, colour, AI as critic                     |
| [`examples/schools_dashboard`](notebooks/examples/schools_dashboard.ipynb) | S8 demo                       | A complete interactive Bokeh dashboard                        |

Every notebook starts with questions to answer **without AI**, and its exercises end with ✅ self-check cells:
use AI tools if you want, but make the checks pass with code you can explain.

## Repository

| Folder | Contents |
|---|---|
| `notebooks/` | Course notebooks (committed without outputs: run them yourself) |
| `data/` | Datasets used by the notebooks, with sources and licences in [`data/README.md`](data/README.md) |
| `outputs/` | Files the notebooks write (not committed) |
| `project_template/` | Starting point for your group project, with the [repository checklist](project_template/CHECKLIST.md) |
| `projects/` | [Projects from previous years](projects/README.md) |
| `setup/` | Environment files and installation scripts |
| `scripts/` | How the data snapshots were downloaded |

## For contributors

```console
uv sync
uv run python -m ipykernel install --user --name ub-bigdata-viz
uv run pre-commit install            # strips notebook outputs, lints scripts
OFFLINE=1 uv run pytest --nbmake notebooks/*.ipynb notebooks/examples/*.ipynb
```

## Acknowledgments

These materials build on those developed by [Franziska Peter](https://github.com/Chaotique) and Josep Perelló for the 2021 and 2022 editions ([2022](https://github.com/Chaotique/Master_Visualizations_2022), [2021](https://github.com/Chaotique/Master_Visualizations_2021)).

Course materials are available under [CC-BY-4.0](https://creativecommons.org/licenses/by/4.0/) unless specified otherwise. Datasets keep their own licences (see `data/README.md`).
