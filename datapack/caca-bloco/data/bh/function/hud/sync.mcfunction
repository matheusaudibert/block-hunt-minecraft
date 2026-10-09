execute store result storage bh:data hud.round int 1 run scoreboard players get #round bh.var
execute store result storage bh:data hud.rounds int 1 run scoreboard players get #rounds bh.var
scoreboard players set bh_rodada bh.pts -1
scoreboard players display numberformat bh_rodada bh.pts blank
function bh:hud/linha with storage bh:data hud
