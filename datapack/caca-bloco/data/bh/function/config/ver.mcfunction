tellraw @s {"text":"★ Configuração do Caça Bloco ★","color":"gold","bold":true}
tellraw @s ["",{"text":" Rodadas: ","color":"gray"},{"score":{"name":"#rounds","objective":"bh.var"},"color":"yellow"}]
tellraw @s ["",{"text":" Dificuldade: ","color":"gray"},{"nbt":"cfg.dif","storage":"bh:data","color":"yellow"}]
tellraw @s ["",{"text":" Raio do spawn: ","color":"gray"},{"nbt":"cfg.raio","storage":"bh:data","color":"yellow"}]
tellraw @s ["",{"text":" Mestre: ","color":"gray"},{"selector":"@a[tag=bh.master]","color":"yellow"}]
