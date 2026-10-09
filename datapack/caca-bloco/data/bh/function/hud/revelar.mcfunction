$scoreboard objectives modify bh.pts displayname ["",{"text":"» ","color":"gray"},{"text":"$(nome)","color":"yellow","bold":true}]
$data modify entity @e[type=item_display,tag=bh.display,limit=1] item set value {id:"$(id)",count:1}
$data modify entity @e[type=text_display,tag=bh.text,limit=1] text set value ["",{"text":"★ CAÇA BLOCO ★\n","color":"gold","bold":true},{"text":"Procurem: ","color":"white"},{"text":"$(nome)","color":"yellow"}]
