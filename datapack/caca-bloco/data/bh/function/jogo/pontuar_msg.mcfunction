title @a times 5 50 10
$title @a subtitle ["",{"text":"encontrou ","color":"white"},{"text":"$(nome)","color":"yellow"},{"text":" (+1 ponto)","color":"white"}]
title @a title {"selector":"@a[tag=bh.scorer]","color":"gold","bold":true}
$tellraw @a ["",{"text":"★ ","color":"gold"},{"selector":"@a[tag=bh.scorer]","color":"gold"},{"text":" encontrou ","color":"gray"},{"text":"$(nome)","color":"yellow"},{"text":" e ganhou 1 ponto!","color":"gray"}]
