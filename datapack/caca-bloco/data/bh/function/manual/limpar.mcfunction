# Remove todos os marcadores/entidades do jogo (não mexe nos blocos)
kill @e[type=!player,tag=bh.obj]
tellraw @s {"text":"✔ Marcadores do Caça Bloco removidos.","color":"green"}
