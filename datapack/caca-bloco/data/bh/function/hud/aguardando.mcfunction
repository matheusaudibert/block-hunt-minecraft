function bh:hud/sync
scoreboard objectives modify bh.pts displayname {"text":"★ Caça Bloco ★","color":"gold","bold":true}
data remove entity @e[type=item_display,tag=bh.display,limit=1] item
data modify entity @e[type=text_display,tag=bh.text,limit=1] text set value ["",{"text":"★ CAÇA BLOCO ★\n","color":"gold","bold":true},{"text":"Aguardando o mestre puxar a alavanca","color":"gray"}]
