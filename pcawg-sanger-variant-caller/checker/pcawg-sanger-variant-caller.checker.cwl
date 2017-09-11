cwlVersion: v1.0

class: CommandLineTool

hints:
  - class: DockerRequirement
    dockerPull: quay.io/junjun_zhang/pcawg-sanger-variant-caller-ga4gh-result-checker

inputs:
  reference_results:
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
      glob: HCC1143.*.tar.gz

outputs:
  report_file:
    type: File
    outputBinding:
      glob: checker_report.txt
    doc: A text file contains report of the checker
  report_log:
    type: File
    outputBinding:
      glob: checker_report.log
    doc: A log file contains additional details of checker report

baseCommand: ["bash", "/usr/local/bin/pcawg-sanger-result-checker.sh"]

