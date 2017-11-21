cwlVersion: v1.0

class: CommandLineTool

hints:
- class: DockerRequirement
  dockerPull: quay.io/baminou/pcawg-bwa-mem-aligner-ga4gh-result-checker:1.0

inputs:
  result_files:
    type:
      type: array
      items: File
    inputBinding:
      position: 1

outputs:
  report_file:
    type: File
    outputBinding:
      glob: results.json
    doc: A text file contains report of the checker
  report_log:
    type: File
    outputBinding:
      glob: log.txt
    doc: A log file contains additional details of checker report

baseCommand: ["bash", "/usr/local/bin/pcawg-bwa-mem-result-checker.sh"]
