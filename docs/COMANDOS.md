# Caça Bloco — Comandos

Todos os comandos são `/function` e precisam de permissão de operador (no Realms: o dono e os operadores).
Dentro do jogo, `/function bh:ajuda` mostra um resumo.

> **Como passar argumentos:** comandos marcados com 🔧 recebem argumentos entre chaves, logo depois do nome.
> Sem as chaves o Minecraft dá erro `Missing arguments`.
>
> ```
> /function bh:config/rodadas {n:10}        ✔ certo
> /function bh:config/rodadas 10            ✖ errado
> /function bh:config/rodadas               ✖ errado (faltou o argumento)
> ```
> Textos podem ir com ou sem aspas: `{nivel:facil}` ou `{nivel:"facil"}`. Nomes de jogador com
> caracteres especiais precisam de aspas: `{nome:"Jogador_123"}`.

---

## Preparação (uma vez só)

### `/function bh:construir`
Constrói o lobby completo centralizado **no bloco em que você está**.

- Ocupa 31×31 blocos e **apaga tudo** até 20 blocos acima de você: use num lugar plano e vazio.
- Cria: salão de madeira com telhado, janelas, vigas, lanternas, bancos e 4 portas; 8 vagas (com nome + pontos do jogador flutuando em cima); monumento com a **moldura** (lado sul) e a
  **alavanca do mestre** (lado norte), item girando e o letreiro flutuante.
- Mantém os chunks do lobby sempre carregados e define o spawn do mundo no lobby.
- Rodar de novo em outro lugar **move** o lobby: as entidades do lobby antigo são removidas, mas os
  blocos antigos ficam onde estão.

### `/function bh:setar_spawn`
Define o **spawn do mundo** no bloco em que você está. As bússolas dos jogadores apontam para esse ponto.
O `bh:construir` já coloca o spawn na frente do monumento; use este comando se quiser mudar.

> O lugar onde os jogadores **renascem ao morrer** continua sendo o lobby.

### `/function bh:mestre`
Torna **você** o mestre. Só o mestre consegue puxar a alavanca. Só existe um mestre por vez.

### 🔧 `/function bh:definir_mestre {nome:"Jogador"}`
Torna **outro jogador** o mestre.

```
/function bh:definir_mestre {nome:"audibertt"}
```

---

## Partida

### Alavanca (mestre)
Puxar a alavanca do monumento:

| Situação | O que acontece |
|---|---|
| Nenhum jogo rodando | Começa um jogo novo **e** a 1ª rodada |
| Aguardando o mestre | Começa a próxima rodada |
| Rodada em andamento | Nada (aviso "Já existe uma rodada em andamento!") |
| Fim de jogo | Começa um jogo novo, com os pontos zerados |

Se outro jogador puxar a alavanca, ele recebe o aviso "Só o mestre pode puxar a alavanca!" e nada acontece.

### `/function bh:iniciar`
Começa um **jogo novo** sem puxar a alavanca: zera os pontos, sorteia as vagas, teleporta todos, trava o horário
ao meio-dia e dá uma **bússola** para cada jogador.
A 1ª rodada só começa quando o mestre puxar a alavanca.

**Quem entra na partida:** todos os jogadores online, **menos** quem estiver no modo espectador ou com a
tag `bh.fora`. Quem estiver no criativo também entra e é colocado no modo aventura.
As 8 primeiras pessoas ganham uma vaga. Da 9ª em diante, os jogadores nascem no centro do lobby.

### `/function bh:parar`
Encerra o jogo: remove as barreiras, volta todos ao sobrevivência, esconde o placar e religa o ciclo dia/noite.

### `/function bh:entrar`
Entra numa partida que já está em andamento. Útil para quem chegou atrasado ou estava de fora.
Quem entra assim começa com 0 pontos.
Jogadores novos também entram sozinhos no início da rodada seguinte, se não tiverem a tag `bh.fora`.

### `/function bh:sair`
Sai da partida. O jogador ganha a tag `bh.fora` e não volta sozinho nas próximas rodadas.
Para voltar: `/function bh:entrar`.

Para tirar **outro** jogador da partida: `/tag NomeDoJogador add bh.fora`.

---

## Fim de cada rodada

Quando alguém coloca o item certo na moldura:
1. O jogador ganha +1 ponto.
2. Todos são teleportados para as vagas.
3. **O inventário de todos os jogadores é limpo**, e cada um recebe uma **bússola** nova.

## Configuração

### 🔧 `/function bh:config/rodadas {n:10}`
Define o número de rodadas do jogo (padrão: **10**). Pode ser mudado no meio do jogo.

### 🔧 `/function bh:config/dificuldade {nivel:misto}`
Escolhe quais itens podem ser sorteados (padrão: **misto**). Vale a partir do próximo jogo.

| Nível | Exemplos |
|---|---|
| `facil` | troncos, pedregulho, tocha, baú, ferramentas de pedra, carnes cruas |
| `medio` | lingote de ferro, balde, pão, livro, bússola, cama, alvo, funil |
| `dificil` | diamante, esmeralda, maçã dourada, obsidiana, bigorna, pérola do Ender |
| `misto` | todos os anteriores (193 itens) |

### 🔧 `/function bh:config/raio {r:16}`
Raio (em blocos, a partir do centro do lobby) da área protegida (padrão: **16**). Dentro dela os
jogadores ficam no modo aventura (não quebram nem colocam blocos) e não tomam dano (sem PvP).

### `/function bh:config/ver`
Mostra a configuração atual e quem é o mestre.

### `/function bh:ajuda`
Lista os comandos no chat.

---

## Lobby próprio (opcional)

Para usar um lobby que **você** construiu em vez do `bh:construir`:

| Comando | Onde ficar |
|---|---|
| `/function bh:manual/centro` | No centro do lobby. Vira o spawn e o centro da área protegida |
| `/function bh:manual/vaga` | Em cima de cada vaga, olhando para onde o jogador deve olhar. Repita até 8× |
| `/function bh:manual/moldura` | A até 5 blocos da moldura (normal ou brilhante) |
| `/function bh:manual/alavanca` | Do lado da alavanca do mestre |
| `/function bh:manual/limpar` | Remove todos os marcadores (para refazer do zero). Não mexe em blocos |

---

## Tags úteis

| Tag | Significado |
|---|---|
| `bh.master` | É o mestre |
| `bh.player` | Está participando da partida |
| `bh.fora` | Fica de fora (não é colocado na partida automaticamente) |

---

## Problemas comuns

| Sintoma | Causa / solução |
|---|---|
| "Você não está participando da partida" ao usar a moldura | Você está no espectador, tem `bh.fora` ou entrou depois do início. Use `/function bh:entrar` |
| "A rodada ainda não começou!" | Só dá para entregar o item depois do **VAI!** |
| `Missing arguments to function ...` | Faltaram os argumentos `{...}` (veja o topo deste documento) |
| `Unknown function bh:...` | Nome errado. Use Tab para autocompletar depois de `/function bh:` |
| "Lobby não encontrado!" / "Moldura do jogo não encontrada!" | Rode `/function bh:construir` (ou monte o lobby manualmente) |
| Datapack não carrega | Confira `/datapack list`. O pack é feito para o Minecraft **26.3** |

---

## Funções internas (não precisa usar)

| Pasta | O que faz |
|---|---|
| `bh:load`, `bh:tick` | Inicialização e loop principal (rodam sozinhos) |
| `bh:jogo/*` | Lógica da partida: vagas, gaiolas, área protegida, sorteio, moldura, pontuação, fim |
| `bh:contagem/*` | Sequência *Aleatorizando → O item é → nome → 5…1 → VAI!* |
| `bh:hud/*` | Placar lateral, letreiro e item girando no monumento |
| `bh:eventos/*` | Chamadas pelas conquistas ocultas quando alguém usa a alavanca ou a moldura |
| `bh:dados/itens`, `bh:construir/interno` | Gerados por `tools/gerar.py` (não edite à mão) |
