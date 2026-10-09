# Constrói o lobby completo centralizado onde você está (área 31x31 — procure um lugar plano)
execute at @s align xyz run function bh:construir/interno
tellraw @s ["",{"text":"[Caça Bloco] ","color":"gold"},{"text":"Lobby construído! Agora use ","color":"gray"},{"text":"/function bh:mestre","color":"yellow"},{"text":" e puxe a alavanca atrás do monumento.","color":"gray"}]
