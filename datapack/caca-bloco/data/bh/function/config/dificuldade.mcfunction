$data modify storage bh:data cfg.dif set value "$(nivel)"
tellraw @s ["",{"text":"[Caça Bloco] ","color":"gold"},{"text":"Dificuldade: ","color":"gray"},{"nbt":"cfg.dif","storage":"bh:data","color":"yellow"},{"text":" (vale a partir do próximo jogo)","color":"gray"}]
