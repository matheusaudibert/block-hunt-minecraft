# 🎯 Caça Bloco (Block Hunt)

Minigame em **datapack** para Minecraft Java. Funciona no **Realms** e em qualquer servidor, sem mods nem plugins.

Um item é sorteado quando o **mestre** puxa a alavanca. Todos saem correndo para consegui-lo, e o **primeiro**
a colocá-lo na moldura do lobby ganha 1 ponto. Todo mundo volta para o lobby, e o mestre puxa a alavanca de novo
para a próxima rodada. Quem tiver mais pontos no final vence.

**[⬇️ Baixar o datapack (caca-bloco.zip)](https://github.com/matheusaudibert/block-hunt-minecraft/raw/main/dist/caca-bloco.zip)**

> Feito para o **Minecraft Java 26.3** (formato de datapack 121).

---

## ✨ Recursos

- 🎲 **Sorteio com animação:** *Aleatorizando… → O item é… → nome do item → 5, 4, 3, 2, 1 → VAI!*
- 🏠 **Lobby pronto com um comando:** um salão circular de madeira com telhado cônico, janelas, vigas, lanternas,
  bancos e 4 portas, gerado automaticamente.
- 🔄 **Holograma** do item da rodada girando em cima do monumento central.
- 📊 **Placar à direita da tela** com o item da rodada, os pontos de cada jogador e "Rodada X de Y".
- 🪧 **Nome e pontos** de cada jogador flutuando em cima da sua vaga.
- 🚧 **Barreiras invisíveis** prendem os jogadores nas vagas durante a contagem e somem no **VAI!**.
- 🛡️ **Lobby protegido:** dentro dele ninguém quebra ou coloca blocos e não há PvP nem dano.
- 🧭 **Bússola** para todos, apontando para o spawn do mundo.
- 🧹 **Inventário limpo** de todos ao fim de cada rodada, para ninguém começar com vantagem.
- 🍖 **Sem fome** e ☀️ **sempre de dia** durante a partida.
- 📦 **193 itens** em 3 dificuldades, com os **nomes oficiais em português**, sem repetir até a lista acabar.
- ❌ Item errado na moldura é **devolvido** para quem colocou.

---

## 🚀 Começo rápido

```
/function bh:construir     ← em um lugar plano: constrói o lobby
/function bh:mestre        ← quem vai comandar o jogo
```

Depois é só o mestre **puxar a alavanca** atrás do monumento. 🎉

---

## 📥 Instalação

### Singleplayer ou servidor

Coloque o `caca-bloco.zip` na pasta `datapacks` do mundo (`.minecraft/saves/<seu mundo>/datapacks/`) e rode `/reload`.
Confira com `/datapack list`: precisa aparecer `file/caca-bloco.zip`.

### Realms

O Realms não aceita enviar um datapack direto, então você envia um **mundo que já tem o datapack**:

1. No singleplayer, crie um mundo novo. Ou baixe o mundo do Realms em *Configurar Realm → Backups → Baixar o mais recente*.
2. Na criação do mundo, clique em **Pacotes de dados** e arraste o `caca-bloco.zip` para dentro.
   Para um mundo que já existe, copie o zip para a pasta `datapacks`.
3. Construa o lobby (`/function bh:construir`) e teste.
4. Envie o mundo: *Configurar Realm → Substituir mundo → Enviar mundo*.

---

## 🎮 Como jogar

| Etapa | O que acontece |
|---|---|
| 1. Mestre puxa a alavanca | Começa o jogo (ou a próxima rodada). Todos vão para suas vagas |
| 2. Sorteio | Os jogadores ficam presos nas vagas enquanto a animação mostra o item da rodada |
| 3. **VAI!** | As barreiras somem. Cada um sai do lobby para conseguir o item |
| 4. Entrega | O **primeiro** a colocar o item na moldura do monumento ganha **+1 ponto** |
| 5. Volta | Todos são teleportados para as vagas com o inventário limpo e uma bússola nova |
| 6. Repete | O mestre puxa a alavanca de novo. Depois da última rodada aparece o vencedor |

**Quem joga:** todos os jogadores online (até 8 vagas), menos quem estiver no espectador.
Quem chegar no meio usa `/function bh:entrar`; para sair, `/function bh:sair`.

**Só o mestre** consegue puxar a alavanca.

---

## ⚙️ Comandos principais

| Comando | Para quê |
|---|---|
| `/function bh:construir` | Constrói o lobby onde você está |
| `/function bh:mestre` | Torna você o mestre |
| `/function bh:definir_mestre {nome:"Jogador"}` | Torna outro jogador o mestre |
| `/function bh:setar_spawn` | Define o spawn do mundo onde você está (a bússola aponta para ele) |
| `/function bh:iniciar` | Começa um jogo novo, com os pontos zerados |
| `/function bh:parar` | Encerra o jogo |
| `/function bh:entrar` / `bh:sair` | Entrar ou sair de uma partida em andamento |
| `/function bh:config/rodadas {n:10}` | Número de rodadas (padrão 10) |
| `/function bh:config/dificuldade {nivel:misto}` | `facil`, `medio`, `dificil` ou `misto` |
| `/function bh:config/raio {r:16}` | Raio da área protegida do lobby |
| `/function bh:config/ver` | Mostra a configuração atual |
| `/function bh:ajuda` | Lista os comandos no jogo |

📖 **Documentação completa de cada comando, exemplos e solução de problemas: [docs/COMANDOS.md](docs/COMANDOS.md).**

> 💡 Comandos com `{...}` precisam dos argumentos entre chaves. Por exemplo, `/function bh:config/rodadas {n:5}`.

### Lobby próprio

Prefere construir o seu? Monte-o e marque os pontos com `bh:manual/centro`, `bh:manual/vaga` (até 8×),
`bh:manual/moldura` e `bh:manual/alavanca`. Veja os detalhes em [docs/COMANDOS.md](docs/COMANDOS.md#lobby-próprio-opcional).

---

## 🛠️ Desenvolvimento

```
datapack/caca-bloco/     ← código-fonte do datapack (funções, conquistas, tags)
tools/gerar.py           ← gera a lista de itens, a construção do lobby e o zip
tools/nomes_pt_br.json   ← nomes oficiais dos itens em português
docs/COMANDOS.md         ← documentação dos comandos
dist/caca-bloco.zip      ← datapack pronto para usar
```

A lista de itens (por dificuldade) e a construção do lobby ficam em `tools/gerar.py`. Depois de editar, rode:

```
python tools/gerar.py
```

Isso regenera `bh:dados/itens` e `bh:construir/interno` e atualiza o `dist/caca-bloco.zip`.
Os nomes em português vêm de `tools/nomes_pt_br.json`, extraído do arquivo de idioma `pt_br` do jogo.

---

## 📄 Licença

[MIT](LICENSE)
