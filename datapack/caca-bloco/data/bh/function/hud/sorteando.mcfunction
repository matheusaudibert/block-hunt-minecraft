function bh:hud/sync
scoreboard objectives modify bh.pts displayname {"text":"Sorteando...","color":"aqua","bold":true}
data modify entity @e[type=text_display,tag=bh.text,limit=1] text set value ["",{"text":"★ CAÇA BLOCO ★\n","color":"gold","bold":true},{"text":"Sorteando o item...","color":"aqua"}]
