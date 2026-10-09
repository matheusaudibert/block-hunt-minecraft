$execute align xz positioned ~0.5 ~ ~0.5 run summon marker ~ ~ ~ {Tags:["bh.obj","bh.slot","bh.v$(n)"]}
$execute align xz positioned ~0.5 ~ ~0.5 run summon text_display ~ ~2.4 ~ {Tags:["bh.obj","bh.nome","bh.nome$(n)"],billboard:"center",background:1073741824,alignment:"center",text:""}
$data modify entity @e[type=marker,tag=bh.v$(n),limit=1] Rotation set from entity @s Rotation
$data modify entity @e[type=marker,tag=bh.v$(n),limit=1] Rotation[1] set value 0f
