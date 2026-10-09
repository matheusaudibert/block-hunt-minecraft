execute unless data entity @e[type=#bh:molduras,tag=bh.frame,limit=1] Item run return 0
$execute if score #state bh.var matches 3 if items entity @e[type=#bh:molduras,tag=bh.frame,limit=1] contents $(id) run return run function bh:jogo/pontuar
function bh:jogo/rejeitar
