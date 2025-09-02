# Variable declarations -------------------------------------------------------
runR = "Rscript --no-save --no-restore"

# Inputs -----------------------------------------------------------
rule all:
    input:
        "container.sif",
        "out/cyl.csv",
        "out/paths.txt"

# Rules -----------------------------------------------------------------------
rule apptainer_build:
    input:  
        def_file = "container.def",
        lock_file = "renv.lock"
    output:
        "container.sif"
    log:
        "logs/container_build.log"
    shell:
        """
        apptainer build {output} {input.def_file}
        """

rule run_test_script:
    input:  
        container = "container.sif",
        file = "in/mtcars.csv"
    output:
        "out/cyl.csv",
        "out/paths.txt"
    log:
        "logs/test_script.log"
    singularity:
        "container.sif"
    script:
        "scripts/test_script.R"
