cwlVersion: v1.0
class: Workflow

inputs:
  input_file:
    type: File

outputs:
  output_file:
    type: File
    outputSource: md5sum/output_file

steps:
  md5sum:
    run: my_md5sum.cwl
    in:
      input_file: input_file
    out: [output_file]
