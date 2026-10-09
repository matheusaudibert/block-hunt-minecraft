# Fique perto (até 5 blocos) da moldura que será usada no jogo.
tag @e[type=#bh:molduras,tag=bh.frame] remove bh.frame
execute as @e[type=#bh:molduras,distance=..5,sort=nearest,limit=1] run tag @s add bh.frame
tag @e[type=#bh:molduras,tag=bh.frame] add bh.obj
execute as @e[type=#bh:molduras,tag=bh.frame] run data merge entity @s {Invulnerable:1b}
execute if entity @e[tag=bh.frame] run tellraw @s {"text":"✔ Moldura definida.","color":"green"}
execute unless entity @e[tag=bh.frame] run tellraw @s {"text":"✖ Nenhuma moldura a até 5 blocos.","color":"red"}
