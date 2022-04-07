function! s:GetRelatedSuffix(suffix)
  if a:suffix ==# 'ml'
    return 'mli'
  elseif a:suffix ==# 'mli'
    return 'ml'
  endif
  return v:null
endfunction

function! OpenRelatedFile()
  let prefix = expand('%:r')
  let suffix = expand('%:e')
  let newsuffix = s:GetRelatedSuffix(suffix)
  if newsuffix is v:null
    echom "No related suffix found for" suffix
  else
    let newfile = join([prefix, newsuffix], '.')
    execute 'edit' newfile
  endif
endfunction

command! OpenRelatedFile call OpenRelatedFile()
