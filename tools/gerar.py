"""Gera as partes "grandes" do datapack Caça Bloco e empacota o .zip.

  - data/bh/function/dados/itens.mcfunction     (listas de itens por dificuldade)
  - data/bh/function/construir/gerar.mcfunction (construção do lobby, bloco a bloco)
  - dist/caca-bloco.zip

Uso:  python tools/gerar.py
"""
import math
import os
import random
import json
import zipfile

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
PACK = os.path.join(ROOT, "datapack", "caca-bloco")
FUNC = os.path.join(PACK, "data", "bh", "function")

# --------------------------------------------------------------------------- itens
# B = bloco (nome vem de block.minecraft.*), I = item (item.minecraft.*)
ITENS = {
    "facil": """
        B oak_log  B birch_log  B spruce_log  B cobblestone  B gravel  B sand  B crafting_table
        B furnace  B chest  B torch  B ladder  B oak_fence  B oak_door  B oak_trapdoor  B oak_stairs
        B oak_slab  B cobblestone_slab  B lever  B dandelion  B poppy  B oak_sapling  B andesite
        B granite  B diorite  B white_wool  B composter  B barrel  B sugar_cane
        I stick  I coal  I charcoal  I flint  I wheat_seeds  I apple  I feather  I string  I bone
        I rotten_flesh  I wooden_pickaxe  I stone_pickaxe  I stone_sword  I stone_axe  I stone_shovel
        I stone_hoe  I bowl  I raw_iron  I raw_copper  I leather  I egg  I beef  I porkchop  I chicken
        I mutton  I bone_meal  I clay_ball  I oak_boat  I white_dye  I red_dye  I yellow_dye  I sugar
    """,
    "medio": """
        B stone  B smooth_stone  B glass  B white_bed  B pumpkin  B carved_pumpkin  B campfire
        B hay_block  B stone_bricks  B bricks  B blast_furnace  B smoker  B lantern  B note_block
        B rail  B terracotta  B mud  B packed_mud  B mud_bricks  B cobbled_deepslate  B tuff
        B pointed_dripstone  B cactus  B iron_bars  B hopper  B copper_block  B flower_pot
        B bookshelf  B loom  B cartography_table  B stonecutter  B grindstone  B tripwire_hook
        B piston  B target  B melon  B brown_mushroom  B red_mushroom
        I iron_ingot  I copper_ingot  I gold_ingot  I raw_gold  I iron_nugget  I gold_nugget  I bucket
        I water_bucket  I shears  I shield  I iron_pickaxe  I iron_sword  I iron_axe  I iron_helmet
        I iron_boots  I golden_pickaxe  I bow  I arrow  I fishing_rod  I cod  I salmon  I cooked_cod
        I bread  I paper  I book  I flint_and_steel  I compass  I redstone  I lapis_lazuli
        I cooked_beef  I cooked_porkchop  I cooked_chicken  I carrot  I potato  I baked_potato
        I melon_slice  I painting  I item_frame  I armor_stand  I minecart  I glass_bottle
        I spider_eye  I gunpowder  I ink_sac  I leather_helmet  I leather_chestplate  I brush
        I sweet_berries  I pumpkin_pie  I mushroom_stew
    """,
    "dificil": """
        B gold_block  B iron_block  B obsidian  B anvil  B jukebox  B tnt  B cake  B cobweb  B lily_pad
        B moss_block  B calcite  B mossy_cobblestone  B white_concrete  B bamboo  B honey_block
        B beehive  B enchanting_table
        I diamond  I emerald  I amethyst_shard  I golden_apple  I diamond_pickaxe  I diamond_sword
        I iron_chestplate  I crossbow  I spyglass  I lead  I map  I clock  I honeycomb  I honey_bottle
        I ender_pearl  I slime_ball  I name_tag  I saddle  I pufferfish  I tropical_fish  I glow_berries
        I cocoa_beans  I cookie  I golden_carrot  I glow_ink_sac  I rabbit_hide  I rabbit_foot
        I glistering_melon_slice
    """,
}


# Nomes oficiais em português (extraídos do pt_br.json do jogo). Item novo sem nome usa o id.
with open(os.path.join(ROOT, "tools", "nomes_pt_br.json"), encoding="utf-8") as _f:
    NOMES = json.load(_f)


def lista_snbt(spec):
    tokens = spec.split()
    entradas = []
    for _tipo, item in zip(tokens[0::2], tokens[1::2]):
        nome = NOMES.get(item, item).replace("\\", "").replace('"', "'")
        entradas.append('{id:"minecraft:%s",nome:"%s"}' % (item, nome))
    return entradas


def gerar_itens():
    linhas = ["# GERADO por tools/gerar.py — edite as listas lá e rode o script de novo"]
    total = 0
    for nivel, spec in ITENS.items():
        e = lista_snbt(spec)
        total += len(e)
        linhas.append("data modify storage bh:data items.%s set value [%s]" % (nivel, ",".join(e)))
    linhas += [
        "data modify storage bh:data items.todos set value []",
        *["data modify storage bh:data items.todos append from storage bh:data items.%s[]" % n for n in ITENS],
        "execute store result score #n bh.tmp run data get storage bh:data items.todos",
        "scoreboard players remove #n bh.tmp 1",
        "execute store result storage bh:data rng_todos.max int 1 run scoreboard players get #n bh.tmp",
    ]
    escrever("dados/itens.mcfunction", linhas)
    return total


# --------------------------------------------------------------------------- lobby
# Origem (0,0,0) = bloco onde o jogador está em pé. Chão em y=-1.
R_PISO = 14.5
SLOT_R = 8


def polar(r, graus):
    a = math.radians(graus)
    return round(r * math.cos(a)), round(r * math.sin(a))


def yaw_para_centro(x, z):
    # yaw do Minecraft: 0 = sul (+z), 90 = oeste (-x), 180 = norte, -90 = leste
    return math.degrees(math.atan2(x, -z))


def gerar_lobby():
    """Salão circular de madeira com telhado cônico.

    Mantém as posições que o jogo usa: vagas em r=8, monumento 3x3 no centro com a moldura
    em (0,1,2) e a alavanca em (0,1,-2), holograma em y=7.6 e letreiro em y=9.2.
    """
    rnd = random.Random(2026)
    cmds = ["# GERADO por tools/gerar.py — lobby do Caça Bloco (salão de madeira)"]
    blocos = {}  # (x,y,z) -> bloco

    def put(x, y, z, b):
        if abs(x) <= 15 and abs(z) <= 15:
            blocos[(x, y, z)] = b

    def eixo_porta(x, z):  # dentro do vão de uma das 4 portas (N/S/L/O)?
        return abs(x) <= 2 or abs(z) <= 2

    R_PAREDE_IN = 13.5

    def altura_telhado(r):  # y do telhado em cada distância do centro
        return 6 + int((R_PISO - r) * 0.55)

    # Vagas: 8 posições em círculo, deslocadas 22,5° das portas (todas à mesma distância delas)
    vagas = [polar(SLOT_R, 22.5 + 45 * k) for k in range(8)]
    vaga_de = {}
    for sx, sz in vagas:
        for dx in (-1, 0, 1):
            for dz in (-1, 0, 1):
                vaga_de[(sx + dx, sz + dz)] = dx == 0 and dz == 0

    luzes_piso = {polar(5, 22.5 + 45 * k) for k in range(8)}

    # ---- piso de tábuas com anéis de madeira escura e tapetes até as portas
    for x in range(-15, 16):
        for z in range(-15, 16):
            r = math.hypot(x, z)
            if r > R_PISO:
                continue
            if (x, z) in vaga_de:
                b = "stripped_oak_wood" if vaga_de[(x, z)] else "dark_oak_planks"
            elif (x, z) in luzes_piso:
                b = "shroomlight"
            elif r <= 2.5:
                b = "dark_oak_planks"
            elif r <= 3.5 or 10.5 < r <= 11.5:
                b = "stripped_dark_oak_wood"
            elif r > R_PAREDE_IN:
                b = "dark_oak_planks"
            else:
                b = "spruce_planks" if rnd.random() < 0.8 else "oak_planks"
            put(x, -1, z, b)
            # tapete marrom do monumento até cada porta
            if 4 <= r <= R_PAREDE_IN and (abs(x) <= 1 or abs(z) <= 1):
                put(x, 0, z, "brown_carpet")
    # varandas de entrada do lado de fora das portas
    for a in range(-3, 4):
        for s in (-15, 15):
            put(a, -1, s, "spruce_planks")
            put(s, -1, a, "spruce_planks")

    # ---- paredes: tábuas, rodapé escuro, janelas, viga no topo e postes de tronco
    postes = set()
    for k in range(16):
        ang = 22.5 * k
        if k % 4 == 0:
            continue  # portas nos pontos cardeais
        postes.add(polar(14, ang))
    batentes = set()
    for a in (-3, 3):
        for s in (-14, 14):
            batentes.add((a, s))
            batentes.add((s, a))

    parede = []
    for x in range(-15, 16):
        for z in range(-15, 16):
            r = math.hypot(x, z)
            if R_PAREDE_IN < r <= R_PISO:
                parede.append((x, z))
    for x, z in parede:
        porta = eixo_porta(x, z)
        if (x, z) in postes or (x, z) in batentes:
            for y in range(0, 5 if (x, z) in batentes else 6):
                put(x, y, z, "dark_oak_log")
            if (x, z) in batentes:
                put(x, 5, z, "stripped_dark_oak_wood")
            continue
        if porta:
            put(x, 4, z, "stripped_dark_oak_wood")  # verga da porta
            put(x, 5, z, "stripped_dark_oak_wood")
            continue
        perto_poste = min(math.dist((x, z), p) for p in postes | batentes) < 1.5
        put(x, 0, z, "dark_oak_planks")
        put(x, 1, z, "spruce_planks")
        janela = "glass" if not perto_poste else "spruce_planks"
        put(x, 2, z, janela)
        put(x, 3, z, janela)
        put(x, 4, z, "spruce_planks")
        put(x, 5, z, "stripped_dark_oak_wood")

    # ---- telhado cônico (faixas alternadas) com beiral, vigas internas e pináculo
    for x in range(-15, 16):
        for z in range(-15, 16):
            r = math.hypot(x, z)
            if r <= R_PISO:
                y = altura_telhado(r)
                put(x, y, z, "dark_oak_planks" if y % 2 == 0 else "spruce_planks")
            elif r <= R_PISO + 1.2:
                put(x, 5, z, "dark_oak_slab[type=top]")  # beiral
    for k in range(8):
        for passo in range(4, 27):
            r = passo / 2
            x, z = polar(r, 45 * k)
            if math.hypot(x, z) <= R_PAREDE_IN:
                put(x, altura_telhado(math.hypot(x, z)) - 1, z, "stripped_dark_oak_wood")
    topo = altura_telhado(0)
    put(0, topo + 1, 0, "dark_oak_fence")
    put(0, topo + 2, 0, "dark_oak_fence")
    put(0, topo + 3, 0, "lantern")

    # ---- colunas nas diagonais, sustentando as vigas
    for k in range(4):
        cx, cz = polar(11, 45 + 90 * k)
        for y in range(0, altura_telhado(math.hypot(cx, cz))):
            put(cx, y, cz, "stripped_dark_oak_log")

    # ---- mãos-francesas com lanternas penduradas em cada poste da parede
    for k in range(16):
        if k % 4 == 0:
            continue
        lx, lz = polar(12.6, 22.5 * k)
        put(lx, 5, lz, "stripped_spruce_wood")
        put(lx, 4, lz, "lantern[hanging=true]")

    # ---- lanternas penduradas por correntes em volta do centro
    for k in range(4):
        hx, hz = polar(3, 90 * k)
        y_teto = altura_telhado(3)
        put(hx, y_teto - 1, hz, "iron_chain")
        put(hx, y_teto - 2, hz, "iron_chain")
        put(hx, y_teto - 3, hz, "lantern[hanging=true]")

    # ---- bancos atrás de cada vaga (encosto virado para a parede) com vasos de planta
    for k in range(8):
        ang = 22.5 + 45 * k
        bx, bz = polar(12, ang)
        if abs(bx) >= abs(bz):
            fora = "east" if bx > 0 else "west"
            lados = [(bx, bz - 1), (bx, bz + 1)]
        else:
            fora = "south" if bz > 0 else "north"
            lados = [(bx - 1, bz), (bx + 1, bz)]
        put(bx, 0, bz, "spruce_stairs[facing=%s]" % fora)
        for i, (px, pz) in enumerate(lados):
            put(px, 0, pz, "potted_azalea_bush" if i == 0 else "potted_fern")

    # ---- postes de luz do lado de fora de cada porta
    for s in (-15, 15):
        for a in (-3, 3):
            for px, pz in ((a, s), (s, a)):
                put(px, 0, pz, "dark_oak_fence")
                put(px, 1, pz, "dark_oak_fence")
                put(px, 2, pz, "lantern")

    # ---- monumento central de madeira (moldura ao sul, alavanca ao norte)
    for x in range(-2, 3):
        for z in range(-2, 3):
            if abs(x) <= 1 and abs(z) <= 1:
                continue
            put(x, 0, z, "spruce_slab[type=bottom]")
    for x in (-1, 0, 1):
        for z in (-1, 0, 1):
            canto = abs(x) == 1 and abs(z) == 1
            put(x, 0, z, "stripped_dark_oak_wood")
            put(x, 1, z, "dark_oak_planks")
            put(x, 2, z, "stripped_dark_oak_log" if canto else "bookshelf")
            put(x, 3, z, "stripped_dark_oak_log" if canto else "spruce_planks")
            put(x, 4, z, "stripped_dark_oak_wood")
            if canto:
                put(x, 5, z, "dark_oak_fence")
                put(x, 6, z, "lantern")
            elif x == 0 and z == 0:
                put(x, 5, z, "shroomlight")
            else:
                put(x, 5, z, "spruce_slab[type=bottom]")
    put(0, 1, -2, "lever[face=wall,facing=north]")
    put(0, 2, -2, 'dark_oak_wall_sign[facing=north]{is_waxed:1b,front_text:{has_glowing_text:1b,color:"yellow",messages:["","★ MESTRE ★","puxe para","sortear"]}}')
    put(0, 2, 2, 'dark_oak_wall_sign[facing=south]{is_waxed:1b,front_text:{has_glowing_text:1b,color:"yellow",messages:["","★ Coloque o ★","item aqui!",""]}}')

    # ---- comandos
    cmds += [
        "kill @e[type=!player,tag=bh.obj]",
        "forceload add ~-16 ~-16 ~16 ~16",
        "fill ~-15 ~ ~-15 ~15 ~20 ~15 air",
    ]
    # fundação (para o piso não ficar flutuando)
    for x in range(-15, 16):
        zs = [z for z in range(-15, 16) if math.hypot(x, z) <= R_PISO]
        if zs:
            cmds.append("fill ~%d ~-4 ~%d ~%d ~-2 ~%d stone_bricks" % (x, zs[0], x, zs[-1]))
    # blocos de baixo pra cima (placas/alavanca depois do que as sustenta)
    for (x, y, z), b in sorted(blocos.items(), key=lambda kv: (kv[0][1], "lever" in kv[1] or "sign" in kv[1])):
        cmds.append("setblock ~%d ~%d ~%d %s" % (x, y, z, b))

    # entidades do jogo
    cmds += [
        'summon marker ~0.5 ~ ~0.5 {Tags:["bh.obj","bh.center"]}',
        'summon marker ~0.5 ~ ~4.5 {Tags:["bh.obj","bh.spawn"],Rotation:[180f,0f]}',
        'summon marker ~0.5 ~1 ~-1.5 {Tags:["bh.obj","bh.lever"]}',
        'summon glow_item_frame ~ ~1 ~2 {Facing:3b,Invulnerable:1b,Tags:["bh.obj","bh.frame"]}',
        'summon item_display ~0.5 ~7.6 ~0.5 {Tags:["bh.obj","bh.display"],teleport_duration:1,billboard:"fixed",'
        'brightness:{sky:15,block:15},transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],'
        'translation:[0f,0f,0f],scale:[1.6f,1.6f,1.6f]}}',
        # buffer escondido dentro do monumento: usado para montar o texto "nome + pontos" de cada vaga
        'summon item_display ~0.5 ~2.5 ~0.5 {Tags:["bh.obj","bh.buf"],item:{id:"minecraft:paper",count:1}}',
        'summon text_display ~0.5 ~9.2 ~0.5 {Tags:["bh.obj","bh.text"],billboard:"center",background:0,shadow:1b,'
        'text:{"text":"★ CAÇA BLOCO ★","color":"gold","bold":true}}',
    ]
    for k, (sx, sz) in enumerate(vagas):
        yaw = yaw_para_centro(sx, sz)
        cmds.append('summon marker ~%.1f ~ ~%.1f {Tags:["bh.obj","bh.slot","bh.v%d"],Rotation:[%.1ff,0f]}' % (sx + 0.5, sz + 0.5, k + 1, yaw))
        cmds.append('summon text_display ~%.1f ~2.4 ~%.1f {Tags:["bh.obj","bh.nome","bh.nome%d"],billboard:"center",'
                    'background:1073741824,alignment:"center",text:""}' % (sx + 0.5, sz + 0.5, k + 1))
    cmds += [
        "setworldspawn ~ ~ ~4",
        "kill @e[type=item,distance=..30]",
    ]
    escrever("construir/interno.mcfunction", cmds)
    return len(cmds)


def escrever(rel, linhas):
    path = os.path.join(FUNC, rel)
    os.makedirs(os.path.dirname(path), exist_ok=True)
    with open(path, "w", encoding="utf-8", newline="\n") as f:
        f.write("\n".join(linhas) + "\n")


def empacotar():
    dist = os.path.join(ROOT, "dist")
    os.makedirs(dist, exist_ok=True)
    destino = os.path.join(dist, "caca-bloco.zip")
    with zipfile.ZipFile(destino, "w", zipfile.ZIP_DEFLATED) as z:
        for pasta, _, arquivos in os.walk(PACK):
            for a in arquivos:
                completo = os.path.join(pasta, a)
                z.write(completo, os.path.relpath(completo, PACK).replace(os.sep, "/"))
    return destino


if __name__ == "__main__":
    n_itens = gerar_itens()
    n_cmds = gerar_lobby()
    zip_path = empacotar()
    print("itens: %d | comandos do lobby: %d | zip: %s" % (n_itens, n_cmds, zip_path))
