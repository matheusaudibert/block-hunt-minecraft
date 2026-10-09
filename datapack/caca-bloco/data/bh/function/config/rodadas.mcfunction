$scoreboard players set #rounds bh.var $(n)
tellraw @s ["",{"text":"[Caça Bloco] ","color":"gold"},{"text":"Rodadas: ","color":"gray"},{"score":{"name":"#rounds","objective":"bh.var"},"color":"yellow"}]
execute if score #state bh.var matches 1.. run function bh:hud/sync
