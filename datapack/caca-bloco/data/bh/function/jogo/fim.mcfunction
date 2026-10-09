scoreboard players set #max bh.tmp -999
scoreboard players operation #max bh.tmp > @a[tag=bh.player] bh.pts
execute as @a[tag=bh.player] if score @s bh.pts = #max bh.tmp run tag @s add bh.win

title @a times 10 100 20
title @a subtitle ["",{"text":"Vencedor: ","color":"white"},{"selector":"@a[tag=bh.win]","color":"yellow","bold":true}]
title @a title {"text":"★ FIM DE JOGO ★","color":"gold","bold":true}
tellraw @a {"text":"\n★ Placar final ★","color":"gold","bold":true}
execute as @a[tag=bh.player] run tellraw @a ["",{"text":" • ","color":"gray"},{"selector":"@s"},{"text":": ","color":"gray"},{"score":{"name":"@s","objective":"bh.pts"},"color":"yellow"},{"text":" pts","color":"gray"}]
tellraw @a {"text":"O mestre pode puxar a alavanca para começar um novo jogo.","color":"gray","italic":true}

execute as @a at @s run playsound minecraft:ui.toast.challenge_complete master @s ~ ~ ~ 1 1
execute as @a at @s run playsound minecraft:entity.firework_rocket.twinkle master @s ~ ~ ~ 1 1
execute at @a[tag=bh.win] run particle minecraft:totem_of_undying ~ ~1 ~ 0.5 1 0.5 0.6 200 force
tag @a remove bh.win
