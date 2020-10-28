cwlVersion: v1.0
class: CommandLineTool
baseCommand:
  - bowtie
requirements:
  - class: ShellCommandRequirement
  - class: InlineJavascriptRequirement
    expressionLib:
      - var default_output_filename = function(ext) { if (inputs.output_filename !=
        "" && !ext){ return inputs.output_filename; } ext = ext || ".sam"; var root
        = ""; if (inputs.output_filename != ""){ root = inputs.output_filename.split('.').slice(0,-1).join('.');
        return (root == "")?inputs.output_filename+ext:root+ext; } else if (Array.isArray(inputs.upstream_filelist)
        && inputs.upstream_filelist.length > 0){ root = inputs.upstream_filelist[0].basename.split('.').slice(0,-1).join('.');
        return (root == "")?inputs.upstream_filelist[0].basename+ext:root+ext; } else
        if (inputs.upstream_filelist != null){ root = inputs.upstream_filelist.basename.split('.').slice(0,-1).join('.');
        return (root == "")?inputs.upstream_filelist.basename+ext:root+ext; } else
        if (Array.isArray(inputs.downstream_filelist) && inputs.downstream_filelist.length
        > 0){ root = inputs.downstream_filelist[0].basename.split('.').slice(0,-1).join('.');
        return (root == "")?inputs.downstream_filelist[0].basename+ext:root+ext; }
        else if (inputs.downstream_filelist != null){ root = inputs.downstream_filelist.basename.split('.').slice(0,-1).join('.');
        return (root == "")?inputs.downstream_filelist.basename+ext:root+ext; } else
        if (Array.isArray(inputs.crossbow_filelist) && inputs.crossbow_filelist.length
        > 0){ root = inputs.crossbow_filelist[0].basename.split('.').slice(0,-1).join('.');
        return (root == "")?inputs.crossbow_filelist[0].basename+ext:root+ext; } else
        if (inputs.crossbow_filelist != null){ root = inputs.crossbow_filelist.basename.split('.').slice(0,-1).join('.');
        return (root == "")?inputs.crossbow_filelist.basename+ext:root+ext; } else
        { return null; } };
hints:
  - dockerPull: truwl/bowtie:1.3.0
    class: DockerRequirement
  - packages:
      bowtie:
        specs: ["http://identifiers.org/biotools/bowtie"]
        version: ["1.3.0"]
    class: SoftwareRequirement
arguments: []
doc: |-
  Tool maps input raw reads files to reference genome using Bowtie.

  `default_output_filename` function returns default name for SAM output and log files. In case when `sam` and
  `output_filename` inputs are not set, default filename will have `.sam` extension but format may not correspond SAM
  specification. To set output filename manually use `output_filename` input. Default output filename is based on
  `output_filename` or basename of `upstream_filelist`, `downstream_filelist` or `crossbow_filelist` file (if array,
  the first file in array is taken). If function is called without argenments and `output_filename` input is set, it
  will be returned from the function.

  For single-end input data any of the `upstream_filelist` or `downstream_filelist` inputs can be used.

  Log filename (`log_file` output) is generated by `default_output_filename` function with ex='.bw'

  `indices_folder` defines folder to contain Bowtie indices. Based on the first found file with `rev.1.ebwt` or
  `rev.1.ebwtl` extension, bowtie index prefix is returned from input's `valueFrom` field.
inputs:
  B:
    type:
      - 'null'
      - int
    inputBinding:
      prefix: '-B'
      position: 1
    doc: |
      --offbase <int> leftmost ref offset = <int> in bowtie output (default: 0)
  C:
    type:
      - 'null'
      - boolean
    inputBinding:
      prefix: '-C'
      position: 1
    doc: |
      reads and index are in colorspace
  I:
    type:
      - 'null'
      - int
    inputBinding:
      prefix: '-I'
      position: 1
    doc: |
      --minins <int>  minimum insert size for paired-end alignment (default: 0)
  M:
    type:
      - 'null'
      - int
    inputBinding:
      prefix: '-M'
      position: 1
    doc: |
      <int> like -m, but reports 1 random hit (MAPQ=0)
  Q:
    type:
      - 'null'
      - File
    inputBinding:
      prefix: '-Q'
      position: 1
    doc: |
      QV file(s) corresponding to CSFASTA inputs; use with -f -C
  Q1:
    type:
      - 'null'
      - File
    inputBinding:
      prefix: '--Q1'
      position: 1
    doc: |
      --Q1/--Q2 <file>   same as -Q, but for mate files 1 and 2 respectively
  Q2:
    type:
      - 'null'
      - File
    inputBinding:
      prefix: '--Q2'
      position: 1
    doc: |
      --Q1/--Q2 <file>   same as -Q, but for mate files 1 and 2 respectively
  X:
    type:
      - 'null'
      - int
    inputBinding:
      prefix: '-X'
      position: 1
    doc: |
      --maxins <int>  maximum insert size for paired-end alignment (default: 250)
  a:
    type:
      - 'null'
      - boolean
    inputBinding:
      prefix: '-a'
      position: 1
    doc: |
      --all           report all alignments per read (much slower than low -k)
  al:
    type:
      - 'null'
      - string
    inputBinding:
      prefix: '--al'
      position: 1
    doc: |
      <fname>       write aligned reads/pairs to file(s) <fname>
  best:
    type:
      - 'null'
      - boolean
    inputBinding:
      prefix: '--best'
      position: 1
    doc: |
      hits guaranteed best stratum; ties broken by quality
  c:
    type:
      - 'null'
      - boolean
    inputBinding:
      prefix: '-c'
      position: 1
    doc: |
      query sequences given on cmd line (as <mates>, <singles>)
  chunkmbs:
    type:
      - 'null'
      - int
    inputBinding:
      prefix: '--chunkmbs'
      position: 1
    doc: |
      <int>   max megabytes of RAM for best-first search frames (def: 64)
  clip_3p_end:
    type:
      - 'null'
      - int
    inputBinding:
      prefix: '-3'
      position: 1
    doc: |
      --trim3 <int>   trim <int> bases from 3' (right) end of reads
  clip_5p_end:
    type:
      - 'null'
      - int
    inputBinding:
      prefix: '-5'
      position: 1
    doc: |
      --trim5 <int>   trim <int> bases from 5' (left) end of reads
  col_cqual:
    type:
      - 'null'
      - boolean
    inputBinding:
      prefix: '--col-cqual'
      position: 1
    doc: |
      print original colorspace quals, not decoded quals
  col_cseq:
    type:
      - 'null'
      - boolean
    inputBinding:
      prefix: '--col-cseq'
      position: 1
    doc: |
      print aligned colorspace seqs as colors, not decoded bases
  col_keepends:
    type:
      - 'null'
      - boolean
    inputBinding:
      prefix: '--col-keepends'
      position: 1
    doc: |
      keep nucleotides at extreme ends of decoded alignment
  e:
    type:
      - 'null'
      - int
    inputBinding:
      prefix: '-e'
      position: 1
    doc: |
      --maqerr <int>  max sum of mismatch quals across alignment for -n (def: 70)
  f:
    type:
      - 'null'
      - boolean
    inputBinding:
      prefix: '-f'
      position: 1
    doc: |
      query input files are (multi-)FASTA .fa/.mfa
  ff:
    type:
      - 'null'
      - boolean
    inputBinding:
      prefix: '--ff'
      position: 1
    doc: |
      --fr/--rf/--ff     -1, -2 mates align fw/rev, rev/fw, fw/fw (default: --fr)
  fr:
    type:
      - 'null'
      - boolean
    inputBinding:
      prefix: '--fr'
      position: 1
    doc: |
      --fr/--rf/--ff     -1, -2 mates align fw/rev, rev/fw, fw/fw (default: --fr)
  fullref:
    type:
      - 'null'
      - boolean
    inputBinding:
      prefix: '--fullref'
      position: 1
    doc: |
      write entire ref name (default: only up to 1st space)
  integer_quals:
    type:
      - 'null'
      - boolean
    inputBinding:
      prefix: '--integer-quals'
      position: 1
    doc: |
      qualities are given as space-separated integers (not ASCII)
  k:
    type:
      - 'null'
      - int
    inputBinding:
      prefix: '-k'
      position: 1
    doc: |
      <int>           report up to <int> good alignments per read (default: 1)
  l:
    type:
      - 'null'
      - int
    inputBinding:
      prefix: '-l'
      position: 1
    doc: |
      --seedlen <int> seed length for -n (default: 28)
  large_index:
    type:
      - 'null'
      - boolean
    inputBinding:
      prefix: '--large-index'
      position: 1
    doc: |
      force usage of a 'large' index, even if a small one is present
  m:
    type:
      - 'null'
      - int
    inputBinding:
      prefix: '-m'
      position: 1
    doc: |
      <int>           suppress all alignments if > <int> exist (def: no limit)
  mapq:
    type:
      - 'null'
      - int
    inputBinding:
      prefix: '--mapq'
      position: 1
    doc: |
      <int>       default mapping quality (MAPQ) to print for SAM alignments
  max:
    type:
      - 'null'
      - string
    inputBinding:
      prefix: '--max'
      position: 1
    doc: |
      <fname>      write reads/pairs over -m limit to file(s) <fname>
  maxbts:
    type:
      - 'null'
      - int
    inputBinding:
      prefix: '--maxbts'
      position: 1
    doc: |
      <int>     max # backtracks for -n 2/3 (default: 125, 800 for --best)
  mm:
    type:
      - 'null'
      - boolean
    inputBinding:
      prefix: '--mm'
      position: 1
    doc: |
      use memory-mapped I/O for index; many 'bowtie's can share
  n:
    type:
      - 'null'
      - int
    inputBinding:
      prefix: '-n'
      position: 1
    doc: |
      --seedmms <int> max mismatches in seed (can be 0-3, default: -n 2)
  nofw:
    type:
      - 'null'
      - boolean
    inputBinding:
      prefix: '--nofw'
      position: 1
    doc: |
      --norc      do not align to forward/reverse-complement reference strand
  nomaqround:
    type:
      - 'null'
      - boolean
    inputBinding:
      prefix: '--nomaqround'
      position: 1
    doc: |
      disable Maq-like quality rounding for -n (nearest 10 <= 30)
  o:
    type:
      - 'null'
      - int
    inputBinding:
      prefix: '-o'
      position: 1
    doc: |
      --offrate <int> override offrate of index; must be >= index's offrate
  pairtries:
    type:
      - 'null'
      - int
    inputBinding:
      prefix: '--pairtries'
      position: 1
    doc: |
      <int>  max # attempts to find mate for anchor hit (default: 100)
  phred33_quals:
    type:
      - 'null'
      - boolean
    inputBinding:
      prefix: '--phred33-quals'
      position: 1
    doc: |
      input quals are Phred+33 (default)
  phred64_quals:
    type:
      - 'null'
      - boolean
    inputBinding:
      prefix: '--phred64-quals'
      position: 1
    doc: |
      input quals are Phred+64 (same as --solexa1.3-quals)
  q:
    type:
      - 'null'
      - boolean
    inputBinding:
      prefix: '-q'
      position: 1
    doc: |
      query input files are FASTQ .fq/.fastq (default)
  quiet:
    type:
      - 'null'
      - boolean
    inputBinding:
      prefix: '--quiet'
      position: 1
    doc: |
      print nothing but the alignments
  r:
    type:
      - 'null'
      - boolean
    inputBinding:
      prefix: '-r'
      position: 1
    doc: |
      query input files are raw one-sequence-per-line
  reads_per_batch:
    type:
      - 'null'
      - int
    inputBinding:
      prefix: '--reads-per-batch'
      position: 1
    doc: |
      # of reads to read from input file at once (default: 16)
  refidx:
    type:
      - 'null'
      - boolean
    inputBinding:
      prefix: '--refidx'
      position: 1
    doc: |
      refer to ref. seqs by 0-based index rather than name
  refout:
    type:
      - 'null'
      - boolean
    inputBinding:
      prefix: '--refout'
      position: 1
    doc: |
      write alignments to files refXXXXX.map, 1 map per reference
  rf:
    type:
      - 'null'
      - boolean
    inputBinding:
      prefix: '--rf'
      position: 1
    doc: |
      --fr/--rf/--ff     -1, -2 mates align fw/rev, rev/fw, fw/fw (default: --fr)
  s:
    type:
      - 'null'
      - int
    inputBinding:
      prefix: '-s'
      position: 1
    doc: |
      --skip <int>    skip the first <int> reads/pairs in the input
  sam:
    type:
      - 'null'
      - boolean
    inputBinding:
      prefix: '-S'
      position: 1
    doc: |
      --sam write hits in SAM format
  sam_RG:
    type:
      - 'null'
      - string
    inputBinding:
      prefix: '--sam-RG'
      position: 1
    doc: |
      <text>    add <text> (usually "lab=value") to @RG line of SAM header
  sam_nohead:
    type:
      - 'null'
      - boolean
    inputBinding:
      prefix: '--sam-nohead'
      position: 1
    doc: |
      supppress header lines (starting with @) for SAM output
  sam_nosq:
    type:
      - 'null'
      - boolean
    inputBinding:
      prefix: '--sam-nosq'
      position: 1
    doc: |
      supppress @SQ header lines for SAM output
  seed:
    type:
      - 'null'
      - int
    inputBinding:
      prefix: '--seed'
      position: 1
    doc: |
      <int>       seed for random number generator
  shmem:
    type:
      - 'null'
      - boolean
    inputBinding:
      prefix: '--shmem'
      position: 1
    doc: |
      use shared mem for index
  snpfrac:
    type:
      - 'null'
      - float
    inputBinding:
      prefix: '--snpfrac'
      position: 1
    doc: |
      <dec>    approx. fraction of SNP bases (e.g. 0.001); sets --snpphred
  snpphred:
    type:
      - 'null'
      - int
    inputBinding:
      prefix: '--snpphred'
      position: 1
    doc: |
      <int>   Phred penalty for SNP when decoding colorspace (def: 30)
  solexa1.3_quals:
    type:
      - 'null'
      - boolean
    inputBinding:
      prefix: '--solexa1.3-quals'
      position: 1
    doc: |
      input quals are from GA Pipeline ver. >= 1.3
  solexa_quals:
    type:
      - 'null'
      - boolean
    inputBinding:
      prefix: '--solexa-quals'
      position: 1
    doc: |
      input quals are from GA Pipeline ver. < 1.3
  strata:
    type:
      - 'null'
      - boolean
    inputBinding:
      prefix: '--strata'
      position: 1
    doc: |
      hits in sub-optimal strata aren't reported (requires --best)
  suppress:
    type:
      - 'null'
      - string
    inputBinding:
      prefix: '--suppress'
      position: 1
    doc: |
      <cols>  suppresses given columns (comma-delim'ed) in default output
  t:
    type:
      - 'null'
      - boolean
    inputBinding:
      prefix: '-t'
      position: 1
    doc: |
      --time          print wall-clock time taken by search phases
  threads:
    type:
      - 'null'
      - int
    inputBinding:
      prefix: '-p'
      position: 1
    doc: |
      --threads <int> number of alignment threads to launch (default: 1)
  u:
    type:
      - 'null'
      - int
    inputBinding:
      prefix: '-u'
      position: 1
    doc: |
      --qupto <int>   stop after first <int> reads/pairs (excl. skipped reads)
  un:
    type:
      - 'null'
      - string
    inputBinding:
      prefix: '--un'
      position: 1
    doc: |
      <fname>       write unaligned reads/pairs to file(s) <fname>
  v:
    type:
      - 'null'
      - int
    inputBinding:
      prefix: '-v'
      position: 1
    doc: |
      report end-to-end hits w/ <=v mismatches; ignore qualities
  verbose:
    type:
      - 'null'
      - boolean
    inputBinding:
      prefix: '--verbose'
      position: 1
    doc: |
      verbose output (for debugging)
  y:
    type:
      - 'null'
      - boolean
    inputBinding:
      prefix: '-y'
      position: 1
    doc: |
      --tryhard try hard to find valid alignments, at the expense of speed
  indices_folder:
    type: Directory
    inputBinding:
      position: 81
      valueFrom: |
        ${
            for (var i = 0; i < self.listing.length; i++) {
                if (self.listing[i].path.split('.').slice(-3).join('.') == 'rev.1.ebwt' ||
                    self.listing[i].path.split('.').slice(-3).join('.') == 'rev.1.ebwtl'){
                  return self.listing[i].path.split('.').slice(0,-3).join('.');
                }
            }
            return null;
        }
    doc: |
      Folder with Bowtie indices
  upstream_filelist:
    type:
      - 'null'
      - File
      - name: _:0deb7310-e407-4917-a504-7ab27912d38a
        items: File
        type: array
    inputBinding:
      position: 83
      itemSeparator: ","
    doc: |
      Comma-separated list of files containing upstream mates (or the
      sequences themselves, if -c is set) paired with mates in <m2>
  downstream_filelist:
    type:
      - 'null'
      - File
      - name: _:00e731ec-2c1c-449e-8391-1dae419d05d9
        items: File
        type: array
    inputBinding:
      position: 85
      itemSeparator: ","
    doc: |
      Comma-separated list of files containing downstream mates (or the
      sequences themselves if -c is set) paired with mates in <m1>
  crossbow_filelist:
    type:
      - 'null'
      - File
      - name: _:0308ba20-8126-42f4-a2d1-19067eafe9b7
        items: File
        type: array
    inputBinding:
      prefix: "-12"
      position: 86
      itemSeparator: ","
    doc: |
      Comma-separated list of files containing Crossbow-style reads.
      Can be a mixture of paired and unpaired.  Specify "-"for stdin.
  output_filename:
    type:
      - 'null'
      - string
    inputBinding:
      position: 90
      valueFrom: $(default_output_filename())
    doc: |
      Generates default output filename on the base of upstream_filelist/downstream_filelist files
outputs:
  aligned_file:
    type:
      - 'null'
      - File
    outputBinding:
      glob: $(inputs.al)
  log_file:
    type: File
    outputBinding:
      glob: $(default_output_filename(".bw"))
  mapped_reads_number:
    type: int
    outputBinding:
      loadContents: true
      glob: $(default_output_filename(".bw"))
      outputEval: |
        ${
          var mappedRegex = /alignment\:.*/;
          return parseInt(self[0].contents.match(mappedRegex)[0].split(" ")[1]);
        }
  multimapped_file:
    type:
      - 'null'
      - File
    outputBinding:
      glob: $(inputs.max)
  refout_file:
    type:
      - 'null'
      - name: _:1eb0197b-84eb-4851-819e-2d89bf0946ed
        items: File
        type: array
    outputBinding:
      glob: "*ref*.map*"
  sam_file:
    type:
      - 'null'
      - File
    outputBinding:
      glob: $(default_output_filename())
  total_reads_number:
    type: int
    outputBinding:
      loadContents: true
      glob: $(default_output_filename(".bw"))
      outputEval: |
        ${
          var totalRegex = /processed\:.*/;
          return parseInt(self[0].contents.match(totalRegex)[0].split(" ")[1]);
        }
  unaligned_file:
    type:
      - 'null'
      - File
    outputBinding:
      glob: $(inputs.un)
  unmapped_reads_number:
    type: int
    outputBinding:
      loadContents: true
      glob: $(default_output_filename(".bw"))
      outputEval: |
        ${
          var unmappedRegex = /align\:.*/;
          return parseInt(self[0].contents.match(unmappedRegex)[0].split(" ")[1]);
        }
