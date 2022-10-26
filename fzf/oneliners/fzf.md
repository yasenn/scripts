# `fzf` oneliners

Some useful onliners to work with `fzf`

# Contents

- [`fzf` oneliners](#`fzf` oneliners)
  - [Searching file contents](#`fzf` oneliners#Searching file contents)

## Searching file contents
  ```
  grep --line-buffered --color=never -r "" * | fzf
  ```
  
## Find CLI tool written on Rust by it's name or description

```
curl -s https://lib.rs/command-line-utilities |  w3m  -T text/html -dump  | awk '/•/{if (NR!=1)print "";next}{printf "%s ",$0}END{print "";}' | fzf
```

see also: [rust-repos/github.csv at master · rust-lang/rust-repos](https://github.com/rust-lang/rust-repos/blob/master/data/github.csv)
