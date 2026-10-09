scoreboard players add #t bh.var 1
scoreboard players operation #m bh.tmp = #t bh.var
scoreboard players operation #m bh.tmp %= #3 bh.var
# 0-3s: Aleatorizando... | 3s: O item é... | 4-7s: nome do item | 7-12s: 5 4 3 2 1 | 12s: VAI!
execute if score #t bh.var matches ..59 if score #m bh.tmp matches 0 run function bh:contagem/embaralhar
execute if score #t bh.var matches 60 run function bh:contagem/o_item_e
execute if score #t bh.var matches 80 run function bh:contagem/revelar with storage bh:data current
execute if score #t bh.var matches 140 run function bh:contagem/numero {n:5,cor:"green"}
execute if score #t bh.var matches 160 run function bh:contagem/numero {n:4,cor:"yellow"}
execute if score #t bh.var matches 180 run function bh:contagem/numero {n:3,cor:"gold"}
execute if score #t bh.var matches 200 run function bh:contagem/numero {n:2,cor:"red"}
execute if score #t bh.var matches 220 run function bh:contagem/numero {n:1,cor:"dark_red"}
execute if score #t bh.var matches 240 run function bh:contagem/vai with storage bh:data current
