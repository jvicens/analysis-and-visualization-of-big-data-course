# Data

Everything the notebooks need is in this folder, so they run offline (and in CI). Files written by the notebooks go to `../outputs/`, never here.

Refresh the API snapshots with `uv run python scripts/download_data.py snapshots` (see that script for the exact queries).

## Files

| Path | What | Source | Licence / terms | Retrieved | Used in |
|---|---|---|---|---|---|
| `Sleep_Patterns_and_Homeostatic_Mechanisms_in_Adolescent_Mice_2013.csv` / `.xlsx` | Sleep measurements in adolescent mice | [Nelson et al. (2013), Brain Sci. 3(1):318–43](https://pubmed.ncbi.nlm.nih.gov/23772316/) | Open-access article | 2023 | 01 |
| `imdb/imdb_top_1000.csv` | IMDB top 1000 films | [Kaggle: IMDB top 1000](https://www.kaggle.com/datasets/omarhanyy/imdb-top-1000) | See the Kaggle page | 2023 | 01, 02 |
| `examples/energy_consumption_municipalities.parquet` | Electricity consumption by municipality and sector (54,611 rows) | [Transparència Catalunya `8idm-becu`](https://analisi.transparenciacatalunya.cat/d/8idm-becu) | Portal terms of use (attribution) | 2026-10-05 | 02, 03 |
| `examples/cooperatives.parquet` | Register of cooperatives (4,883 rows) | [Transparència Catalunya `euku-fzbx`](https://analisi.transparenciacatalunya.cat/d/euku-fzbx) | Portal terms of use (attribution) | 2026-10-05 | 03, 08 |
| `examples/covid_vaccination_daily.parquet` | COVID-19 doses per day and dose number, summed server-side | [Transparència Catalunya `irki-p3c7`](https://analisi.transparenciacatalunya.cat/d/irki-p3c7) | Portal terms of use (attribution) | 2026-10-05 | 09, 10 |
| `examples/covid_vaccination_daily_comarca.parquet` | COVID-19 doses per day and comarca | same as above | same | 2026-10-05 | 08, 09 |
| `examples/bcn_accidents_2024.parquet` | People involved in traffic accidents handled by the Guàrdia Urbana, 2024 | [Open Data BCN](https://opendata-ajuntament.barcelona.cat/data/en/dataset/accidents-persones-gu-bcn) | CC BY 4.0 | 2026-10-05 | 03, 09 |
| `education/school_places_20241007.parquet` | Allocation of school places (pre-enrolment) | [Transparència Catalunya `99md-r3rq`](https://analisi.transparenciacatalunya.cat/d/99md-r3rq) | Portal terms of use (attribution) | 2024-10-07 | examples/schools_dashboard |
| `icgc/*.json` | Catalonia, provinces, comarques (1:250,000) and municipalities (1:1,000,000), EPSG:4326 | [ICGC, Divisions administratives v2r1 (2025-07-30)](https://www.icgc.cat/ca/Geoinformacio-i-mapes/Dades-i-productes/Geoinformacio-cartografica/Divisions-administratives) | ICGC terms of use (attribution) | 2025-07-30 | 08 |
| `bcn/districtes.geojson`, `bcn/barris.geojson` | Barcelona districts and neighbourhoods, EPSG:25831 | [Open Data BCN, administrative units](https://opendata-ajuntament.barcelona.cat/data/en/dataset/20170706-districtes-barris) | CC BY 4.0 | 2026-10-05 | 08 |
| `carto/BCN500_0101S_LIMITE_ADM.*` | Spanish administrative boundaries (BCN500, 1:500,000) | [CNIG download centre](http://centrodedescargas.cnig.es/CentroDescargas/index.jsp) | CNIG terms of use (attribution) | 2023 | 08 |
| `ds-codigos-postales-master/data/*.geojson` | Postal-code areas of the four Catalan provinces | [inigoflores/ds-codigos-postales](https://github.com/inigoflores/ds-codigos-postales) (from CNIG) | No licence file; CNIG source | 2023 | 07, 08 |

Full-resolution boundaries are not committed: `uv run python scripts/download_data.py raw` explains how to get them into `data/raw/` (git-ignored).

## Repositories of open datasets

### Open data portals

- [data.europa.eu](https://data.europa.eu/en) · [datos.gob.es](https://datos.gob.es/es/) · [INE](https://www.ine.es/) · [Eurostat](https://ec.europa.eu/eurostat)
- [Transparència Catalunya](https://analisi.transparenciacatalunya.cat/) · [Dades Obertes DIBA](https://dadesobertes.diba.cat/) · [Open Data BCN](https://opendata-ajuntament.barcelona.cat/es)

### Science

- [CERN Open Data](https://opendata.cern.ch/) · [ESA](https://earth.esa.int/eogateway/catalog) · [NASA](https://data.nasa.gov/) · [SDSS](https://www.sdss4.org/)

### Mobility

- [Open Data MITMA](https://www.mitma.gob.es/ministerio/proyectos-singulares/estudios-de-movilidad-con-big-data/opendata-movilidad)

### Networks

- [Network Repository](http://networkrepository.com/) · [Stanford SNAP](http://snap.stanford.edu/data/) · [Gephi datasets](https://github.com/gephi/gephi/wiki/Datasets)

### Machine learning

- [Kaggle Datasets](https://www.kaggle.com/datasets)
