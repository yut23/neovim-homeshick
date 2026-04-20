" fix string highlighting
syntax match  dtsStringProperty "\".\{-\}\""
" allow multiple labels
syntax match  dtsLabel          "^\%([[:space:]]*[[:alpha:][:digit:]_]\+:\)\+"
