"""Download or refresh the course datasets.

    uv run python scripts/download_data.py snapshots   # refresh data/examples/*.parquet from the APIs
    uv run python scripts/download_data.py bcn         # Barcelona districts and neighbourhoods into data/bcn/
    uv run python scripts/download_data.py raw         # how to get full-resolution Catalan boundaries

Run from the repository root. The committed snapshots are what the notebooks use offline
(and in CI); this script documents exactly how each one was made.
"""

import io
import sys
from pathlib import Path

import pandas as pd
import requests

ROOT = Path(__file__).resolve().parents[1]
DATA = ROOT / "data"
SOCRATA = "https://analisi.transparenciacatalunya.cat"
CKAN = "https://opendata-ajuntament.barcelona.cat/data/api/action"


def socrata(dataset_id, params=None, page=50_000):
    """Download a Socrata (Transparència Catalunya) dataset as CSV, page by page."""
    params = dict(params or {})
    frames, offset = [], 0
    while True:
        query = {**params, "$limit": page, "$offset": offset}
        r = requests.get(f"{SOCRATA}/resource/{dataset_id}.csv", params=query, timeout=300)
        r.raise_for_status()
        chunk = pd.read_csv(io.StringIO(r.text))
        if chunk.empty:
            break
        frames.append(chunk)
        offset += page
        if len(chunk) < page:
            break
    return pd.concat(frames, ignore_index=True)


def ckan(resource_id, page=10_000):
    """Download a CKAN (Open Data BCN) datastore resource, page by page."""
    frames, offset = [], 0
    while True:
        r = requests.get(f"{CKAN}/datastore_search",
                         params={"resource_id": resource_id, "limit": page, "offset": offset},
                         timeout=300)
        r.raise_for_status()
        records = r.json()["result"]["records"]
        if not records:
            break
        frames.append(pd.DataFrame(records))
        offset += page
    return pd.concat(frames, ignore_index=True).drop(columns="_id")


def snapshots():
    out = DATA / "examples"
    out.mkdir(parents=True, exist_ok=True)
    jobs = {
        "energy_consumption_municipalities.parquet": lambda: socrata("8idm-becu"),
        "cooperatives.parquet": lambda: socrata("euku-fzbx"),
        "covid_vaccination_daily.parquet": lambda: socrata(
            "irki-p3c7",
            {"$select": "data, dosi, sum(recompte) as dosis", "$group": "data, dosi", "$order": "data, dosi"}),
        "covid_vaccination_daily_comarca.parquet": lambda: socrata(
            "irki-p3c7",
            {"$select": "data, comarca_codi, comarca, sum(recompte) as dosis",
             "$group": "data, comarca_codi, comarca", "$order": "data, comarca_codi"}),
        "bcn_accidents_2024.parquet": lambda: ckan("c78c2bf7-88a6-4db9-a1e9-429f0ce14e88"),
    }
    for name, fetch in jobs.items():
        df = fetch()
        df.to_parquet(out / name, index=False)
        print(f"{name}: {len(df):,} rows")


BCN_DATASET = "https://opendata-ajuntament.barcelona.cat/data/dataset/808daafa-d9ce-48c0-925a-fa5afdb1ed41"
BCN_FILES = {
    "districtes": f"{BCN_DATASET}/resource/5f8974a7-7937-4b50-acbc-89204d570df9/download",
    "barris": f"{BCN_DATASET}/resource/75197dfe-0306-4c5e-9643-34948af07fb6/download",
}
ICGC_PAGE = ("https://www.icgc.cat/ca/Geoinformacio-i-mapes/Dades-i-productes/"
             "Geoinformacio-cartografica/Divisions-administratives")


def bcn_boundaries():
    """Barcelona districts and neighbourhoods (Open Data BCN, CC BY 4.0) as GeoJSON in EPSG:25831."""
    import geopandas as gpd
    from shapely import wkt

    out = DATA / "bcn"
    out.mkdir(parents=True, exist_ok=True)
    for name, url in BCN_FILES.items():
        records = requests.get(url, timeout=300).json()
        df = pd.DataFrame(records)
        geom = gpd.GeoSeries(df.pop("geometria_etrs89").map(wkt.loads), crs="EPSG:25831")
        keep = [c for c in df.columns if not c.startswith("geometria")]
        gdf = gpd.GeoDataFrame(df[keep], geometry=geom)
        gdf.to_file(out / f"{name}.geojson", driver="GeoJSON")
        print(f"bcn/{name}.geojson: {len(gdf)} polygons")


def raw():
    """Full-resolution Catalan boundaries: manual download (ICGC has no stable direct link)."""
    print("Download 'Divisions administratives' (GeoJSON) from")
    print(f"  {ICGC_PAGE}")
    print(f"and unzip it into {DATA / 'raw' / 'icgc'} (git-ignored).")
    print("The light versions the notebooks use are already in data/icgc/.")


if __name__ == "__main__":
    what = sys.argv[1] if len(sys.argv) > 1 else "snapshots"
    {"snapshots": snapshots, "bcn": bcn_boundaries, "raw": raw}[what]()
