# Item errado (ou fora da rodada): devolve para quem colocou
execute if entity @a[tag=bh.framer] at @a[tag=bh.framer,limit=1,sort=nearest] run summon item ~ ~0.5 ~ {Tags:["bh.devolver"],PickupDelay:0s,Item:{id:"minecraft:stone",count:1}}
execute unless entity @a[tag=bh.framer] run summon item ~ ~ ~ {Tags:["bh.devolver"],PickupDelay:10s,Item:{id:"minecraft:stone",count:1}}
data modify entity @e[type=item,tag=bh.devolver,limit=1] Item set from entity @s Item
tag @e[type=item,tag=bh.devolver] remove bh.devolver
data remove entity @s Item
data modify entity @s ItemRotation set value 0b
execute if score #state bh.var matches 3 run title @a[tag=bh.framer,tag=bh.player] actionbar {"text":"✖ Esse não é o item da rodada!","color":"red"}
execute unless score #state bh.var matches 3 run title @a[tag=bh.framer,tag=bh.player] actionbar {"text":"✖ A rodada ainda não começou!","color":"red"}
tellraw @a[tag=bh.framer,tag=!bh.player] ["",{"text":"✖ Você não está participando da partida. Use ","color":"red"},{"text":"/function bh:entrar","color":"yellow"}]
execute as @a[tag=bh.framer] at @s run playsound minecraft:entity.villager.no master @s ~ ~ ~ 1 1
