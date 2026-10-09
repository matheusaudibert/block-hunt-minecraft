scoreboard players add #clock bh.var 1
execute if score #clock bh.var matches 20.. run scoreboard players set #clock bh.var 0

# Sem fome
execute if score #clock bh.var matches 0 run effect give @a[tag=bh.player] saturation 1 0 true
execute if score #clock bh.var matches 0 run function bh:hud/nomes

function bh:jogo/zona with storage bh:data cfg
execute if score #state bh.var matches 2 run function bh:contagem/tick
function bh:jogo/moldura_checar with storage bh:data current
# Holograma: gira e fica sempre centralizado em cima do monumento (centro do lobby)
execute as @e[type=item_display,tag=bh.display] at @s rotated ~4 0 positioned as @e[type=marker,tag=bh.center,limit=1] align xz positioned ~0.5 ~7.6 ~0.5 run tp @s ~ ~ ~ ~ ~
