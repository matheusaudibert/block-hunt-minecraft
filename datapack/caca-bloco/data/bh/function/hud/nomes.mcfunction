# Atualiza o letreiro "nome + pontos" em cima de cada vaga
execute as @e[type=text_display,tag=bh.nome] run data modify entity @s text set value ""
execute as @a[tag=bh.player,scores={bh.vaga=1..}] run function bh:hud/nome_jogador
