# Snakemake R Workflow with Singularity (Apptainer) and `renv`

[![CI](https://github.com/atsyplenkov/snakemake_apptainer_renv/workflows/Run%20Snakemake%20Workflow/badge.svg)](https://github.com/atsyplenkov/snakemake_apptainer_renv/actions)

## How it works
This project uses Snakemake to automate an R workflow inside a reproducible Singularity (Apptainer) container. The workflow builds a container image from a definition file `container.def`, installing R packages listed in the `renv.lock` and system dependencies. Then `snakemake` runs your R scripts within the created container (`container.sif`) in the order defined in the `Snakefile`. It will run only the scripts that need to be re-run to make sure that all targets are met. Such approach makes sure that the computational environment is reproducible and reusable. As an extra bonus, it comes with the continuous integration (CI) that runs the workflow on every push to the `master` branch.

## Plain language summary
Imagine you are doing your R&D work and until the end of the project, you do not know for sure what kind of R packages will be needed. The SOTA approach in such cases is to use `renv` to manage your R packages. This library helps to track the R packages you use and records them in the `renv.lock` file. That is, code is written, money is made. And now you are at the end of the project and happy to archive it and move forward. But after two years your boss says, "We need to reproduce the results." What do you do?

Luckily, `renv` recorded all the R packages and the R version. However, it did not record the system dependencies. What usually happens to me is that I need a specific GDAL version with specific drivers installed (hello, KEA lib), but I do not always record them. Therefore, even if I restore `renv` on a new machine, I'll probably fail to reproduce the results. 

One way to tackle this is to create a container image with all the R packages and system dependencies you need, and then run your code inside that container. This is where `Apptainer` comes to the rescue. Similar to Docker and Podman, it creates `.sif` images from `.def` specification files. By bootstrapping container building by pulling images from Docker Hub, R packages recorded by `renv` can be easily restored and your favourite system dependencies can be manually installed or even built from source.

However, another thing we need to keep in mind in R&D jobs is the order of the steps. Especially in large projects with many inputs, it is not always easy to understand which script to run first. And, mostly, do we need to run all scripts if we change only one input file? For such cases people invented `snakemake`. It allows you to define the order of the steps and run them in a reproducible way, executing only the scripts that need to be re-run.

This repository serves as a template for such projects. The idea is that you start working within `renv`, and create scripts in the `scripts/` directory. Any unusual system dependencies should be specified in the `container.def` file. The order of the steps should be manually recorded in the `Snakefile`. Then, as soon as you finish writing the code, you can run the workflow with the following command:

```shell
# N is the number of cores you want to use
snakemake --use-singularity --cores N
```

This will build the container image from the `container.def` file and run the scripts within the container in the order defined in the `Snakefile`. If it finishes successfully, you can be assured that the results are reproducible and you can rerun them on a new machine in future.


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

# See also
- [A bit more complex implementation](https://github.com/bast/contain-R) of the same approach connecting `renv` and `snakemake` with Singularity by @bast
- [Pat Schloss's project](https://github.com/riffomonas/drought_index/tree/main) on running R workflows with `snakemake` (within `conda`)
- [Snakemake documentation](https://snakemake.readthedocs.io/en/stable/)
- [Singularity documentation](https://apptainer.org/docs/)