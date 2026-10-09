# Sai da partida (e não é colocado de volta automaticamente na próxima rodada)
tag @s remove bh.player
tag @s add bh.fora
scoreboard players reset @s bh.pts
gamemode survival @s[gamemode=adventure]
tellraw @s {"text":"Você saiu da partida. Use /function bh:entrar para voltar.","color":"gray"}
