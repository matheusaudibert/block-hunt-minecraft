# Fique no centro do seu lobby. Também vira o ponto de spawn/renascimento.
kill @e[type=marker,tag=bh.center]
kill @e[type=marker,tag=bh.spawn]
execute align xz positioned ~0.5 ~ ~0.5 run summon marker ~ ~ ~ {Tags:["bh.obj","bh.center"]}
execute align xz positioned ~0.5 ~ ~0.5 run summon marker ~ ~ ~ {Tags:["bh.obj","bh.spawn","bh.new"]}
data modify entity @e[type=marker,tag=bh.new,limit=1] Rotation set from entity @s Rotation
data modify entity @e[type=marker,tag=bh.new,limit=1] Rotation[1] set value 0f
tag @e[type=marker,tag=bh.new] remove bh.new
kill @e[type=item_display,tag=bh.buf]
summon item_display ~ ~-3 ~ {Tags:["bh.obj","bh.buf"],item:{id:"minecraft:paper",count:1}}
forceload add ~-16 ~-16 ~16 ~16
setworldspawn ~ ~ ~
tellraw @s {"text":"✔ Centro/spawn definido aqui.","color":"green"}
