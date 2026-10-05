# Repository checklist (Session 14)

Use it before every delivery, and when you review another group's repository.

## Does it run from scratch?

- [ ] A fresh clone plus the environment file (`uv.lock`, `requirements.txt` or `environment.yml`) runs every notebook top to bottom (*Restart & Run All*).
- [ ] Relative paths only (`data/processed/…`), never `C:\Users\…` or `/Users/…`.
- [ ] Raw data are downloaded by code or documented; large files are not in Git.
- [ ] No secrets: tokens live in `.env`, and `.env` is in `.gitignore`.
- [ ] Random seeds fixed where results depend on them.

## Can someone else understand it?

- [ ] `README.md`: question, data sources and licences, how to run, figures produced, authors.
- [ ] `LICENSE` for the code; data licences respected and cited.
- [ ] Notebooks tell a story: markdown between code; one notebook per step (load → clean → analyse → figures).
- [ ] Functions reused across notebooks live in `src/`, with docstrings.
- [ ] An AI-usage note in the README: which tools, for what, and what you checked.

## Can you explain it?

- [ ] Every member can explain any function or cell to another group, without AI.
- [ ] Every figure's message fits in one sentence, and the figure shows it.
