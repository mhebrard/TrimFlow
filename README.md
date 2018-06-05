# TrimFlow
workflow example managed with [Nextflow](https://www.nextflow.io/) within [Singularity](http://singularity.lbl.gov/) that run [Trimgalore](https://github.com/FelixKrueger/TrimGalore) on fastq files

## Setup
* Install Singularity : [on Linux](http://singularity.lbl.gov/install-linux) or [on Windows](http://singularity.lbl.gov/install-windows)
(v2.4.1 and above required)

* Install Nextflow: [HOWTO](https://www.nextflow.io/#GetStarted)

## Quick start
Choose one of the methods below:

( change ```path/to/reads/``` to match the folder of your data.
Reads folder must be in the current folder or a subdirectory -- ```./data/``` )


1. Let nextflow download the workflow files and the container image automatically
```
nextflow run mhebrard/TrimFlow  --reads 'path/to/reads/*_R{1,2}*'
```

2. download the workflow files and the container image manually, then run it locally
````
nextflow pull mhebrard/TrimFlow
singularity pull --name TrimFlow.simg shub://mhebrard/TrimFlow
nextflow run mhebrard/TrimFlow -with-singularity ./Trimflow.simg --reads 'path/to/reads/*_R{1,2}*'
```
