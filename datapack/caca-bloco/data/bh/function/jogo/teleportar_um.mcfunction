execute store result storage bh:data tp.n int 1 run scoreboard players get @s bh.vaga
execute if score @s bh.vaga matches 1.. run return run function bh:jogo/teleportar_vaga with storage bh:data tp
tp @s @e[type=marker,tag=bh.spawn,limit=1]
