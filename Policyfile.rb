name "vcruntime"
default_source :supermarket
run_list "vcruntime::vc14"
cookbook "vcruntime", path: "."
# cookbook "vcruntime", ">= 0.2.2", github: "taylormonacelli/vcruntime", branch: 'tm/api-ms-win-crt-runtime-l1-1-0-dll'
