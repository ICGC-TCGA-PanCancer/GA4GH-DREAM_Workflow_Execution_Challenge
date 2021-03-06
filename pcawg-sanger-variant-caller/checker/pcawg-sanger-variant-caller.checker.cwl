cwlVersion: v1.0

class: CommandLineTool

hints:
- class: DockerRequirement
  dockerPull: quay.io/junjun_zhang/pcawg-sanger-variant-caller-ga4gh-result-checker:2.0

inputs:
  reference_results_dir:
    type: Directory
    default: reference_results
    inputBinding:
      position: 1
  result_files:
    type:
      type: array
      items: File
    inputBinding:
      position: 2

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

baseCommand: ["bash", "/usr/local/bin/pcawg-sanger-result-checker.sh"]

