# Uso: /function bh:definir_mestre {nome:"NomeDoJogador"}
tag @a remove bh.master
$tag $(nome) add bh.master
tellraw @a ["",{"text":"[Caça Bloco] ","color":"gold"},{"selector":"@a[tag=bh.master]","color":"yellow"},{"text":" agora é o mestre!","color":"gray"}]
