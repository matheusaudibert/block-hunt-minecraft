# Fique do lado da alavanca do mestre.
kill @e[type=marker,tag=bh.lever]
summon marker ~ ~ ~ {Tags:["bh.obj","bh.lever"]}
tellraw @s {"text":"✔ Alavanca do mestre definida (vale para alavancas a até ~6 blocos daqui).","color":"green"}
