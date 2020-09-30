let g:LanguageClient_autoStart = 0 " LanguageClientStart, LanguageClientStop
let g:LanguageClient_diagnosticsEnable = 1
let g:LanguageClient_waitOutputTimeout = 15
let g:LanguageClient_trace = 'off' " 'off' | 'messages' | 'verbose'
" let g:LanguageClient_loggingLevel = 'DEBUG'
let g:LanguageClient_loggingFile = expand('~/languageClient.log')
let g:LanguageClient_serverStderr = expand('~/languageServer.log')
let g:LanguageClient_hoverPreview = 'Auto' " Never | Auto | Always
let g:LanguageClient_diagnosticsDisplay = {
      \ 1: {
      \"name": "Error",
      \"texthl": "ALEError",
      \"signText": "E",
      \"signTexthl": "ALEErrorSign",
      \},
      \ 2: {
      \"name": "Warning",
      \"texthl": "ALEWarning",
      \"signText": "W",
      \"signTexthl": "ALEWarningSign",
      \},
      \ 3: {
      \"name": "Information",
      \"texthl": "ALEInfo",
      \"signText": "I",
      \"signTexthl": "ALEInfoSign",
      \},
      \ 4: {
      \"name": "Hint",
      \"texthl": "ALEInfo",
      \"signText": "H",
      \"signTexthl": "ALEInfoSign",
      \},
      \}

let g:LanguageClient_serverCommands = {
      \ 'python': ['pyls'],
      \ 'java': [
      \   'java',
      \   '-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=1044',
      \   '-Declipse.application=org.eclipse.jdt.ls.core.id1',
      \   '-Dosgi.bundles.defaultStartLevel=4',
      \   '-Declipse.product=org.eclipse.jdt.ls.core.product',
      \   '-Dlog.level=ALL',
      \   '-noverify',
      \   '-Xmx1G',
      \   '-jar',
      \    $HOME . '/lsp/eclipse.jdt.ls/org.eclipse.jdt.ls.product/target/repository/plugins/org.eclipse.equinox.launcher_1.5.400.v20190515-0925.jar',
      \    '-configuration',
      \    $HOME . '/lsp/eclipse.jdt.ls/org.eclipse.jdt.ls.product/target/repository/config_mac'
      \  ],
      \ }
      "\ 'c': [$HOME . '/lsp/cquery/build/release/bin/cquery',$HOME . '/lsp/cq.log'],
      "\ 'cpp': [$HOME . '/lsp/cquery/build/release/bin/cquery',$HOME . '/lsp/cq.log'],
      "\ 'java',
      "\ '-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=1044',
      "\ '-Declipse.application=org.eclipse.jdt.ls.core.id1',
      "\ '-Dosgi.bundles.defaultStartLevel=4',
      "\ '-Declipse.product=org.eclipse.jdt.ls.core.product',
      "\ '-Dlog.protocol=true',
      "\ '-Dlog.level=ALL',
      "\ '-noverify',
      "\ '-Xmx1G',
      "\ '-jar',
      "\ $HOME . '/lsp/jdtlsp/plugins/org.eclipse.equinox.launcher_1.5.100.v20180611-1436.jar',
      "\ '-configuration',
      "\ $HOME . '/lsp/jdtlsp/config_mac',

augroup language_server
  autocmd!
  " autocmd Filetype java nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
  nnoremap <F5> :call LanguageClient_contextMenu()<CR>
  " nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
  nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
  nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
augroup END

