# O item modifier resolve o nome/pontos do jogador (@s) no nome de um item; depois copia para o letreiro da vaga
item modify entity @e[type=item_display,tag=bh.buf,limit=1] contents bh:nome_placar
execute store result storage bh:data tp.n int 1 run scoreboard players get @s bh.vaga
function bh:hud/nome_aplicar with storage bh:data tp
