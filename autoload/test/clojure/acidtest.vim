if !exists('g:test#clojure#acidtest#file_pattern')
  let g:test#clojure#acidtest#file_pattern = '\v(_test|^test/.+)\.cljs?$'
end

function! test#clojure#acidtest#test_file(file) abort
  return a:file =~# g:test#clojure#acidtest#file_pattern
endfunction

function! test#clojure#acidtest#build_position(type, position) abort
  if a:type == 'nearest'
    if expand('%:.') == a:position['file']
      return [':.RunTests']
    else
      return [':edit +'.a:position['line'].' '.a:position['file'].' | :.RunTests']
    endif
  elseif a:type == 'file'
    return [':RunTests '.AcidGetNs(a:position['file'])]
  else
    return [':0RunTests']
  endif
endfunction

function! test#clojure#acidtest#build_args(args) abort
  if get(a:args, 0, '') =~# 'RunTests'
    return a:args
  else
    return [':RunTests '.join(a:args)]
  endif
endfunction

function! test#clojure#acidtest#executable() abort
endfunction
