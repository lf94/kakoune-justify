# Arguments
# 1 - Width of the fold
# 
# Registers
# l - longest line
# s - number of spaces
# o - original text

define-command -params 1 justify %{
  set-register "o" "%reg{.}"

  evaluate-commands %{
    execute-keys "<a-s>"
    execute-keys -itersel "|wc -m<ret>"
    execute-keys -save-regs '"' "<a-_>"
    execute-keys "|sort -r |head -n 1<ret>"
    set-register "l" "%reg{.}"
    execute-keys "d<space>"
    set-register "s" %sh{ echo $(( ($kak_reg_l - $1) / 2 )) }
  }

 execute-keys "|echo $kak_main_reg_o | fold -s -w %arg{1}<ret>"
 execute-keys "<a-s><a-h>;i"
 execute-keys %sh{
   for i in $(seq $kak_reg_s)
   do echo -n " "
   done
 }
 execute-keys "<esc><a-l>"
}
