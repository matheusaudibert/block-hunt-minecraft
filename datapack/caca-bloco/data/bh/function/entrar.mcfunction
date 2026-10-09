# Entra na partida em andamento (pega a próxima vaga livre)
execute unless score #state bh.var matches 1.. run return run tellraw @s {"text":"✖ Nenhuma partida em andamento. O mestre precisa puxar a alavanca.","color":"red"}
execute if entity @s[tag=bh.player] run return run tellraw @s {"text":"Você já está na partida.","color":"gray"}
function bh:jogo/atribuir
function bh:jogo/teleportar_um
