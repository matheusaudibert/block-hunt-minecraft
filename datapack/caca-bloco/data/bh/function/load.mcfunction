# Estados (#state bh.var): 0 = parado | 1 = aguardando alavanca | 2 = contagem | 3 = caçando | 4 = fim de jogo
scoreboard objectives add bh.var dummy
scoreboard objectives add bh.tmp dummy
scoreboard objectives add bh.pts dummy {"text":"★ Caça Bloco ★","color":"gold","bold":true}
scoreboard objectives add bh.vaga dummy

scoreboard players set #3 bh.var 3
execute unless score #state bh.var matches 0.. run scoreboard players set #state bh.var 0
execute unless score #rounds bh.var matches 1.. run scoreboard players set #rounds bh.var 10
execute unless data storage bh:data cfg.raio run data modify storage bh:data cfg.raio set value 16
execute unless data storage bh:data cfg.dif run data modify storage bh:data cfg.dif set value "misto"
execute unless data storage bh:data current.nome run data modify storage bh:data current set value {id:"minecraft:barrier",nome:"Barreira"}

function bh:dados/itens
# Atualização: pool salva por versões antigas (sem nomes em português) é refeita
execute if data storage bh:data pool[0] unless data storage bh:data pool[0].nome run function bh:jogo/encher_pool
tellraw @a[gamemode=creative] ["",{"text":"[Caça Bloco] ","color":"gold"},{"text":"Datapack carregado. Use /function bh:ajuda","color":"gray"}]
