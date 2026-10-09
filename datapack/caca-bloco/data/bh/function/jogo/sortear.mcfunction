# Sorteia um item da pool e o remove (não repete até a pool acabar)
execute unless data storage bh:data pool[0] run function bh:jogo/encher_pool
execute store result score #n bh.tmp run data get storage bh:data pool
scoreboard players remove #n bh.tmp 1
execute store result storage bh:data rng_pool.max int 1 run scoreboard players get #n bh.tmp
data modify storage bh:data sorteio.i set value 0
execute if score #n bh.tmp matches 1.. run function bh:util/rand with storage bh:data rng_pool
function bh:jogo/sortear_pegar with storage bh:data sorteio
