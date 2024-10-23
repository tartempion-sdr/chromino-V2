class_name JetonUseCases

var nb_jetons_pioche: int    = 7

#region list_couleurs_jetons
var list_couleurs_jetons: Array[Jeton] = \
    [
        Jeton(jaune, jaune, jaune),
        Jeton(jaune, jaune, vert),
        Jeton(jaune, jaune, bleu),
        Jeton(jaune, jaune, violet),
        Jeton(jaune, jaune, rouge),
        Jeton(jaune, vert, jaune),
        Jeton(jaune, bleu, jaune),
        Jeton(jaune, violet, jaune),
        Jeton(jaune, rouge, jaune),
        Jeton(jaune, vert, bleu),
        Jeton(jaune, vert, violet),
        Jeton(jaune, vert, rouge),
        Jeton(jaune, bleu, vert),
        Jeton(jaune, bleu, violet),
        Jeton(jaune, bleu, rouge),
        Jeton(jaune, violet, vert),
        Jeton(jaune, violet, bleu),
        Jeton(jaune, violet, rouge),
        Jeton(jaune, rouge, vert),
        Jeton(jaune, rouge, bleu),
        Jeton(jaune, rouge, violet),

        Jeton(vert, vert, vert),
        Jeton(vert, vert, jaune),
        Jeton(vert, vert, bleu),
        Jeton(vert, vert, violet),
        Jeton(vert, vert, rouge),
        Jeton(vert, jaune, vert),
        Jeton(vert, bleu, vert),
        Jeton(vert, violet, vert),
        Jeton(vert, rouge, vert),
        Jeton(vert, jaune, bleu),
        Jeton(vert, jaune, violet),
        Jeton(vert, jaune, rouge),
        Jeton(vert, bleu, violet),
        Jeton(vert, bleu, rouge),
        Jeton(vert, violet, bleu),
        Jeton(vert, violet, rouge),
        Jeton(vert, rouge, bleu),
        Jeton(vert, rouge, violet),

        Jeton(bleu, bleu, bleu),
        Jeton(bleu, bleu, jaune),
        Jeton(bleu, bleu, vert),
        Jeton(bleu, bleu, violet),
        Jeton(bleu, bleu, rouge),
        Jeton(bleu, jaune, bleu),
        Jeton(bleu, vert, bleu),
        Jeton(bleu, violet, bleu),
        Jeton(bleu, rouge, bleu),
        Jeton(bleu, jaune, violet),
        Jeton(bleu, jaune, rouge),
        Jeton(bleu, vert, violet),
        Jeton(bleu, vert, rouge),
        Jeton(bleu, violet, rouge),
        Jeton(bleu, rouge, violet),

        Jeton(violet, violet, violet),
        Jeton(violet, violet, jaune),
        Jeton(violet, violet, vert),
        Jeton(violet, violet, bleu),
        Jeton(violet, violet, rouge),
        Jeton(violet, jaune, violet),
        Jeton(violet, vert, violet),
        Jeton(violet, bleu, violet),
        Jeton(violet, rouge, violet),
        Jeton(violet, jaune, rouge),
        Jeton(violet, vert, rouge),
        Jeton(violet, bleu, rouge),


        Jeton(rouge, rouge, rouge),
        Jeton(rouge, rouge, jaune),
        Jeton(rouge, rouge, vert),
        Jeton(rouge, rouge, bleu),
        Jeton(rouge, rouge, violet),
        Jeton(rouge, jaune, rouge),
        Jeton(rouge, vert, rouge),
        Jeton(rouge, bleu, rouge),
        Jeton(rouge, violet, rouge),

        Jeton(jaune, joker, jaune),
        Jeton(vert, joker, vert),
        Jeton(bleu, joker, bleu),
        Jeton(violet, joker, violet),
        Jeton(rouge, joker, rouge),
    ]
#endregion

#region list_position_pioche_jetons
var list_position_pioche_jetons: Array[Vector2] = \
    [
    (Vector2(150, 543)),
    (Vector2(280, 543)),
    (Vector2(410, 543)),
    (Vector2(540, 543)),
    (Vector2(670, 543)),
    (Vector2(800, 543)),
    (Vector2(930, 543)),
    (Vector2(1060, 543))
    ]
#endregion


const scene_jeton: PackedScene = preload("res://jetons.tscn")

#75 chrominos classiques,
#5 chrominos caméléon combinant 2 couleurs différentes à chaque extrémité
const joker = preload("res://assets/colors/joker.jpg")
const jaune = preload("res://assets/colors/jaune.jpg")
const vert = preload("res://assets/colors/vert.jpg")
const bleu = preload("res://assets/colors/bleu.jpg")
const violet = preload("res://assets/colors/violet.jpg")
const rouge = preload("res://assets/colors/rouge.jpg")
const blanc = preload("res://assets/colors/carre-blanc.png")
