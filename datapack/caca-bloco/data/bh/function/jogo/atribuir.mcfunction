tag @s add bh.player
tag @s remove bh.fora
gamemode adventure @s[gamemode=!survival,gamemode=!adventure]
scoreboard players set @s bh.pts 0
scoreboard players set @s bh.vaga 0
execute store result score #vagas bh.tmp if entity @e[type=marker,tag=bh.slot]
execute if score #next bh.var <= #vagas bh.tmp run scoreboard players operation @s bh.vaga = #next bh.var
scoreboard players add #next bh.var 1
execute at @e[type=marker,tag=bh.spawn,limit=1] run spawnpoint @s ~ ~ ~
clear @s minecraft:compass
give @s minecraft:compass
tellraw @s ["",{"text":"[Caça Bloco] ","color":"gold"},{"text":"Você está no jogo! Vaga #","color":"gray"},{"score":{"name":"@s","objective":"bh.vaga"},"color":"yellow"}]
