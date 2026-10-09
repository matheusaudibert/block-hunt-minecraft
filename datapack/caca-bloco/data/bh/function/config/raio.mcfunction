$data modify storage bh:data cfg.raio set value $(r)
tellraw @s ["",{"text":"[Caça Bloco] ","color":"gold"},{"text":"Raio protegido do spawn: ","color":"gray"},{"nbt":"cfg.raio","storage":"bh:data","color":"yellow"}]
