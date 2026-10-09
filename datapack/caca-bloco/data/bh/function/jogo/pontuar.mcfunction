tag @a[tag=bh.framer,tag=bh.player,limit=1] add bh.scorer
execute unless entity @a[tag=bh.scorer] unless entity @a[tag=bh.framer] at @e[type=#bh:molduras,tag=bh.frame,limit=1] run tag @p[tag=bh.player,distance=..8] add bh.scorer
execute unless entity @a[tag=bh.scorer] run return run function bh:jogo/rejeitar

data remove entity @e[type=#bh:molduras,tag=bh.frame,limit=1] Item
scoreboard players add @a[tag=bh.scorer] bh.pts 1
function bh:jogo/pontuar_msg with storage bh:data current
function bh:hud/nomes
execute as @a at @s run playsound minecraft:ui.toast.challenge_complete master @s ~ ~ ~ 0.8 1
execute at @a[tag=bh.scorer] run particle minecraft:totem_of_undying ~ ~1 ~ 0.4 0.8 0.4 0.5 80 force
tag @a remove bh.scorer
function bh:jogo/rodada_fim
