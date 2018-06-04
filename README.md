# TrimFlow
workflow example managed with [Nextflow](https://www.nextflow.io/) within [Singularity](http://singularity.lbl.gov/) that run [Trimgalore](https://github.com/FelixKrueger/TrimGalore) on fastq files

## Setup
* Install Singularity : [on Linux](http://singularity.lbl.gov/install-linux) or [on Windows](http://singularity.lbl.gov/install-windows)

* Install Nextflow: [HOWTO](https://www.nextflow.io/#GetStarted)

## Quick start
( change ```path/to/reads/``` to match the folder of your data.
Reads folder must be in the current folder or a subdirectory -- ./data/ )

* let nextflow download the workflow files and the singularity image automatically

```
 nextflow run mhebrard/TrimFlow -with-singularity --reads 'path/to/reads/*_R{1,2}*'
 ```

* download the files first then run nextflow locally

 ```
 nextflow pull mhebrard/TrimFlow
 ```
 ```
 singularity pull --name TrimFlow.img shub://mhebrard/TrimFlow
 ```
 ```
 nextflow run mhebrard/Trimflow -with-singularity ./Trimflow.img --reads 'path/to/reads/*_R{1,2}*'
