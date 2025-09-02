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
        script ="scripts/test_script.R",
        container = "container.sif"  
    output:
        "out/cyl.csv",
        "out/paths.txt"
    log:
        "logs/test_script.log"
    singularity:
        "container.sif"
    shell:
        """
        {runR} {input.script} 
        """
