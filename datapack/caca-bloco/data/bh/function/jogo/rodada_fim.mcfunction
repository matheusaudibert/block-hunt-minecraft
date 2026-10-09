function bh:jogo/teleportar
# Todos voltam com o inventário limpo (só com a bússola)
execute as @a[tag=bh.player] run function bh:jogo/dar_bussola
effect give @a[tag=bh.player] instant_health 1 4 true
execute if score #round bh.var >= #rounds bh.var run return run function bh:jogo/ultima_rodada
scoreboard players set #state bh.var 1
function bh:hud/aguardando
