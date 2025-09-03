# Inputs -----------------------------------------------------------
rule all:
    input:
        "container.sif",
        "out/cyl.csv",
        "out/paths.txt",
        "out/plot.png"

# Rules -----------------------------------------------------------------------
rule apptainer_build:
    input:  
        def_file = "container.def",
        lock_file = "renv.lock"
    output:
        "container.sif"
    shell:
        """
        apptainer build {output} {input.def_file}
        """

rule run_test_script:
    input:  
        # container = "container.sif",
        file = "in/mtcars.csv"
    singularity:
        "container.sif"
    output:
        "out/cyl.csv",
        "out/paths.txt"
    script:
        "scripts/test_script.R"

rule run_test_script2:
    singularity:
        "container.sif"
    output:
        "out/plot.png"
    script:
        "scripts/test_script2.R"