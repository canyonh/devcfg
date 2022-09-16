handle SIG32 nostop

set print pretty on
set print max-depth 2
set history save on
set pagination off
set confirm off

# don't restrict the max size of a variable (we have large size variables in audio server)
set max-value-size unlimited

define hook-add-symbol-file
  set confirm off
  end

define hookpost-add-symbol-file
  set confirm off
  end

set auto-load safe-path /
