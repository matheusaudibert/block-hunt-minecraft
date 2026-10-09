# Define o spawn do mundo exatamente onde você está (as bússolas apontam para ele)
execute align xz positioned ~0.5 ~ ~0.5 run setworldspawn ~ ~ ~
tellraw @s ["",{"text":"[Caça Bloco] ","color":"gold"},{"text":"✔ Spawn do mundo definido aqui. As bússolas agora apontam para este ponto.","color":"green"}]
