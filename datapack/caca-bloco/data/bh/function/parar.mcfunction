schedule clear bh:jogo/fim
scoreboard players set #state bh.var 0
gamerule advance_time true
function bh:jogo/soltar
gamemode survival @a[tag=bh.player,gamemode=adventure]
tag @a remove bh.player
scoreboard objectives setdisplay sidebar
function bh:hud/ocioso
execute as @e[type=text_display,tag=bh.nome] run data modify entity @s text set value ""
tellraw @a ["",{"text":"[Caça Bloco] ","color":"gold"},{"text":"Jogo encerrado.","color":"gray"}]
