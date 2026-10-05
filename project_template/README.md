# Project title

*One sentence: the question your project answers.*

**Team:** Name Surname (@github-user) · Name Surname (@github-user) · …

## Question

What you want to find out and why it matters (3–5 sentences).

## Data

| Dataset | Source (URL) | Licence | Retrieved | What one row is |
|---|---|---|---|---|
| | | | | |

Raw data are downloaded by `notebooks/01_load_data.ipynb` (or documented here if they cannot be).
Large files are not committed.

## How to run

```console
git clone https://github.com/<org>/<repo>.git
cd <repo>
uv sync            # or: conda env create -f environment.yml
uv run jupyter lab
```

Run the notebooks in order (*Kernel → Restart & Run All*):

1. `notebooks/01_load_data.ipynb` — download and cache the data
2. `notebooks/02_clean.ipynb` — cleaning and joins
3. `notebooks/03_figures.ipynb` — the figures of the article (saved to `plots/`)

## Figures

| Figure | File | Message (one sentence) |
|---|---|---|
| 1 | `plots/fig1.pdf` | |

## Use of AI tools

- Which tools you used, for what (e.g. *drafting the pagination loop in `src/download.py`*).
- What you checked (row counts, units, CRS, every line in `src/`).
- What is entirely yours (question, analysis choices, text).

## Licence

Code: see `LICENSE`. Data: see the licences in the table above.
