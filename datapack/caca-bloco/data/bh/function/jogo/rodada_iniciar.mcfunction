scoreboard players add #round bh.var 1
execute as @a[tag=!bh.player,tag=!bh.fora,gamemode=!spectator] run function bh:jogo/atribuir
function bh:jogo/teleportar
function bh:jogo/prender
function bh:jogo/sortear
effect give @a[tag=bh.player] instant_health 1 4 true

scoreboard players set #t bh.var 0
scoreboard players set #state bh.var 2
function bh:hud/sorteando
title @a times 0 10 0
function bh:contagem/embaralhar
tellraw @a ["",{"text":"[Caça Bloco] ","color":"gold"},{"text":"Rodada ","color":"gray"},{"score":{"name":"#round","objective":"bh.var"},"color":"white"},{"text":" de ","color":"gray"},{"score":{"name":"#rounds","objective":"bh.var"},"color":"white"}]
