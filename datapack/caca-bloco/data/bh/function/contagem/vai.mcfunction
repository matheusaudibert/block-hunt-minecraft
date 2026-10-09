function bh:jogo/soltar
scoreboard players set #state bh.var 3
title @a times 0 30 10
$title @a subtitle ["",{"text":"Encontre: ","color":"white"},{"text":"$(nome)","color":"yellow"}]
title @a title {"text":"VAI!","color":"green","bold":true}
execute as @a at @s run playsound minecraft:item.goat_horn.sound.0 master @s ~ ~ ~ 1 1
