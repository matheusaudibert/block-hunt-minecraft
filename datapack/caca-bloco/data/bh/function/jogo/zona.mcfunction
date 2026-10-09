# Dentro do spawn: modo aventura (não quebra/coloca blocos) + Resistência V (sem PvP/dano)
$execute at @e[type=marker,tag=bh.center,limit=1] run tag @a[tag=bh.player,distance=..$(raio)] add bh.in
gamemode adventure @a[tag=bh.in,gamemode=survival]
gamemode survival @a[tag=bh.player,tag=!bh.in,gamemode=adventure]
execute if score #clock bh.var matches 0 run effect give @a[tag=bh.in] resistance 2 4 true
execute if score #state bh.var matches 1..2 as @a[tag=bh.player,tag=!bh.in] run function bh:jogo/guia
tag @a remove bh.in
