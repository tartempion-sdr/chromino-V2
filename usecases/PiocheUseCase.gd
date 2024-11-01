class_name PiocheUseCase extends Node

var colors = Colors.new()
var random = RandomNumberGenerator.new()
var scene_jeton = preload("res://jetons.tscn")

var joker = colors.joker
var jaune = colors.jaune
var vert = colors.vert
var bleu = colors.bleu
var violet = colors.violet
var rouge = colors.rouge
var blanc = colors.blanc

var list_couleurs_jetons: Array = [
	Jeton.new(jaune, jaune, jaune),
	Jeton.new(jaune, jaune, vert),
	Jeton.new(jaune, jaune, bleu),
	Jeton.new(jaune, jaune, violet),
	Jeton.new(jaune, jaune, rouge),
	Jeton.new(jaune, vert, jaune),
	Jeton.new(jaune, bleu, jaune),
	Jeton.new(jaune, violet, jaune),
	Jeton.new(jaune, rouge, jaune),
	Jeton.new(jaune, vert, bleu),
	Jeton.new(jaune, vert, violet),
	Jeton.new(jaune, vert, rouge),
	Jeton.new(jaune, bleu, vert),
	Jeton.new(jaune, bleu, violet),
	Jeton.new(jaune, bleu, rouge),
	Jeton.new(jaune, violet, vert),
	Jeton.new(jaune, violet, bleu),
	Jeton.new(jaune, violet, rouge),
	Jeton.new(jaune, rouge, vert),
	Jeton.new(jaune, rouge, bleu),
	Jeton.new(jaune, rouge, violet),

	Jeton.new(vert, vert, vert),
	Jeton.new(vert, vert, jaune),
	Jeton.new(vert, vert, bleu),
	Jeton.new(vert, vert, violet),
	Jeton.new(vert, vert, rouge),

	Jeton.new(vert, jaune, vert),
	Jeton.new(vert, bleu, vert),
	Jeton.new(vert, violet, vert),
	Jeton.new(vert, rouge, vert),
	Jeton.new(vert, jaune, bleu),
	Jeton.new(vert, jaune, violet),
	Jeton.new(vert, jaune, rouge),
	Jeton.new(vert, bleu, violet),
	Jeton.new(vert, bleu, rouge),
	Jeton.new(vert, violet, bleu),
	Jeton.new(vert, violet, rouge),
	Jeton.new(vert, rouge, bleu),
	Jeton.new(vert, rouge, violet),

	Jeton.new(bleu, bleu, bleu),
	Jeton.new(bleu, bleu, jaune),
	Jeton.new(bleu, bleu, vert),
	Jeton.new(bleu, bleu, violet),
	Jeton.new(bleu, bleu, rouge),
	Jeton.new(bleu, jaune, bleu),
	Jeton.new(bleu, vert, bleu),
	Jeton.new(bleu, violet, bleu),
	Jeton.new(bleu, rouge, bleu),
	Jeton.new(bleu, jaune, violet),
	Jeton.new(bleu, jaune, rouge),
	Jeton.new(bleu, vert, violet),
	Jeton.new(bleu, vert, rouge),
	Jeton.new(bleu, violet, rouge),
	Jeton.new(bleu, rouge, violet),

	Jeton.new(violet, violet, violet),
	Jeton.new(violet, violet, jaune),
	Jeton.new(violet, violet, vert),
	Jeton.new(violet, violet, bleu),
	Jeton.new(violet, violet, rouge),
	Jeton.new(violet, jaune, violet),
	Jeton.new(violet, vert, violet),
	Jeton.new(violet, bleu, violet),
	Jeton.new(violet, rouge, violet),
	Jeton.new(violet, jaune, rouge),
	Jeton.new(violet, vert, rouge),
	Jeton.new(violet, bleu, rouge),

	Jeton.new(rouge, rouge, rouge),
	Jeton.new(rouge, rouge, jaune),
	Jeton.new(rouge, rouge, vert),
	Jeton.new(rouge, rouge, bleu),
	Jeton.new(rouge, rouge, violet),
	Jeton.new(rouge, jaune, rouge),
	Jeton.new(rouge, vert, rouge),
	Jeton.new(rouge, bleu, rouge),
	Jeton.new(rouge, violet, rouge),

	Jeton.new(jaune, joker, jaune),
	Jeton.new(vert, joker, vert),
	Jeton.new(bleu, joker, bleu),
	Jeton.new(violet, joker, violet),
	Jeton.new(rouge, joker, rouge)
]

func pioche_jeton() -> Jeton:
	var hazard = random.randi_range(0, (list_couleurs_jetons.size() - 1))
	var jeton_hazard:Jeton = list_couleurs_jetons[hazard]
	list_couleurs_jetons.remove(hazard)
	return jeton_hazard

func nb_jetons_restant() -> int :
	return list_couleurs_jetons.size()
