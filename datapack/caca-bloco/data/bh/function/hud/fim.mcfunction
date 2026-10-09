function bh:hud/sync
scoreboard objectives modify bh.pts displayname {"text":"★ Fim de jogo ★","color":"gold","bold":true}
data remove entity @e[type=item_display,tag=bh.display,limit=1] item
data modify entity @e[type=text_display,tag=bh.text,limit=1] text set value ["",{"text":"★ CAÇA BLOCO ★\n","color":"gold","bold":true},{"text":"Fim de jogo!","color":"yellow"}]
