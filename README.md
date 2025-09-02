# Snakemake R Workflow with Singularity (Apptainer) and `renv`

[![CI](https://github.com/atsyplenkov/snakemake_apptainer_renv/workflows/Run%20Snakemake%20Workflow/badge.svg)](https://github.com/atsyplenkov/snakemake_apptainer_renv/actions)

## How it works
This project uses Snakemake to automate an R-based workflow inside a reproducible Singularity (Apptainer) container. The workflow builds a container image from a definition file `container.def`, installing R packages listed in the `renv.lock`. Then `snakemake` runs several R scripts within the created container. 

# Prepare session
1. Install `miniforge3` and `apptainer` using default params. The install `snakemake`:
```shell
conda create -c conda-forge -c bioconda -n snakemake snakemake=9.10.0
```

2. Activate `snakemake` by running:
```shell
conda activate snakemake
```

3. Run the workflow with the followiung command:
```shell
snakemake --use-singularity --cores 1
```