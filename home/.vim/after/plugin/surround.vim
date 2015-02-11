" Avoid a 'timeoutlen' delay (due to surround.vim's "cs" mapping)
" when I type my "c" mapping. I normally have "l" (nore)mapped to "c", so
" I would like to use "ls" as the "change surround" mapping.
execute 'nmap ls' maparg('cs', 'n')
execute 'nmap lS' maparg('cS', 'n')
nunmap cs
nunmap cS
