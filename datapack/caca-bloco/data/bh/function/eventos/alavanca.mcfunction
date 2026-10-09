# Executado como o jogador que usou uma alavanca (via advancement)
advancement revoke @s only bh:alavanca
execute unless entity @e[type=marker,tag=bh.lever,distance=..6] run return 0
execute unless entity @s[tag=bh.master] run return run tellraw @s {"text":"✖ Só o mestre pode puxar a alavanca!","color":"red"}
execute if score #state bh.var matches 2..3 run return run tellraw @s {"text":"✖ Já existe uma rodada em andamento!","color":"red"}
execute if score #state bh.var matches 0 run function bh:iniciar
execute if score #state bh.var matches 4 run function bh:iniciar
execute if score #state bh.var matches 1 run function bh:jogo/rodada_iniciar
