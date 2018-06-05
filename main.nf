#!/usr/bin/env nextflow

flowName = "TrimFlow"
version = v1.0

/*
* HELP
*/
def helpMessage() {
  log.info"""
  ========================
  ${flowName} ${version}:${workflow.revision ? workflow.revision : 'latest'}
  ========================
  Usage:
  The typical command for running the pipeline is as follows:
  nextflow run mhebrard/TrimFlow --reads 'data/*_R{1,2}*'

  Mandatory arguments:
    --reads     Path to input data (./ or sub-folder path with a wildcard on filenames --*--)

  Options:
    --help      Display help and stop the execution
    --name      Name for the pipeline run. If not specified, Nextflow will automatically generate a name.
    --outdir    The output directory where the results will be saved
    """.stripIndent()
}

/*
* PARAMS
*/

params.help = false
params.name = false
// params.outdir // defined in nextflow.config

// Show help message
if (params.help){
  helpMessage()
  exit 0
}

// Use --name or let nextflow generate one
custom_runName = params.name
if( !(workflow.runName ==~ /[a-z]+_[a-z]+/) ){
  custom_runName = workflow.runName
}

/*
 * Create a channel for input read files
 */

Channel
    .fromFilePairs(params.reads)
    .ifEmpty {exit 1, "Cannot find any reads matching: ${params.reads}\nNB: Path requires at least one * wildcard!"}
    .set {c_reads}

/*
* Logs
*/

def summary = [
  'Run Name': custom_runName ?: workflow.runName,
  'Reads': params.reads,
  'Output dir': params.outdir,
  'Working dir': workflow.workDir,
  'Container': workflow.container,
  'Current home': "$HOME",
  'Current user': "$USER",
  'Current path': "$PWD",
  'Script dir': workflow.projectDir
]

log.info "========================"
log.info " ${flowName} ${version}:${workflow.revision ? workflow.revision : 'latest'}"
log.info "========================"
log.info summary.collect { k,v -> "${k.padRight(15)}: $v" }.join("\n")
log.info "========================"


/*
 * STEP 1 - Trim Galore!
 */

process trim_galore {
  tag "$name"
  publishDir "${params.outdir}/trim_galore", mode: 'copy',
  saveAs: {filename ->
    if (filename.indexOf("_fastqc") > 0) "fastqc/$filename"
    else if (filename.indexOf("trimming_report.txt") > 0) "logs/$filename"
    else null
  }

  input:
  set val(name), file(reads) from c_reads

  output:
  file "*fq.gz" into c_reads_trimmed
  file "*trimming_report.txt" into c_trimgalore_report
  file "*_fastqc.{zip,html}" into trimgalore_fastqc_reports

  """
  trim_galore --paired --nextera --phred33 --gzip --length 50 --fastqc $reads
  """
}

/*
 * Completion
 */
workflow.onComplete {
  log.info "[${flowName}] Pipeline Complete"
}
