schedule clear bh:jogo/fim
execute unless entity @e[type=marker,tag=bh.center] run return run tellraw @s {"text":"✖ Lobby não encontrado! Use /function bh:construir primeiro.","color":"red"}
execute unless entity @e[type=marker,tag=bh.slot] run return run tellraw @s {"text":"✖ Nenhuma vaga de jogador encontrada!","color":"red"}
execute unless entity @e[type=#bh:molduras,tag=bh.frame] run return run tellraw @s {"text":"✖ Moldura do jogo não encontrada!","color":"red"}

function bh:jogo/soltar
tag @a remove bh.player
scoreboard players reset * bh.pts
scoreboard players reset * bh.vaga
scoreboard players set #round bh.var 0
scoreboard players set #next bh.var 1
function bh:jogo/encher_pool
execute as @a[tag=!bh.fora,gamemode=!spectator] run function bh:jogo/atribuir

data modify storage bh:data current set value {id:"minecraft:barrier",nome:"Barreira"}
scoreboard players set #state bh.var 1
# Sempre de dia durante o jogo
gamerule advance_time false
time set noon
scoreboard objectives setdisplay sidebar bh.pts
function bh:jogo/teleportar
function bh:hud/aguardando
function bh:hud/nomes

tellraw @a ["",{"text":"\n[Caça Bloco] ","color":"gold"},{"text":"Novo jogo! ","color":"yellow","bold":true},{"score":{"name":"#rounds","objective":"bh.var"},"color":"white"},{"text":" rodadas. Aguardem o mestre puxar a alavanca.","color":"gray"}]
execute as @a at @s run playsound minecraft:block.beacon.activate master @s ~ ~ ~ 1 1.2
