# Fique em cima do bloco da vaga, olhando para onde o jogador deve olhar.
execute store result score #n bh.tmp if entity @e[type=marker,tag=bh.slot]
execute store result storage bh:data tp.n int 1 run scoreboard players add #n bh.tmp 1
function bh:manual/vaga_criar with storage bh:data tp
tellraw @s ["",{"text":"✔ Vaga #","color":"green"},{"score":{"name":"#n","objective":"bh.tmp"},"color":"yellow"},{"text":" criada.","color":"green"}]
