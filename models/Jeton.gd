class_name Jeton extends Node

var color0: Resource
var color1: Resource
var color2: Resource

var sens: String = "verticale-h"

var jeton_id: int
 
func _init(c0, c1, c2):
	color0 = c0
	color1 = c1
	color2 = c2

func is_haut_or_gauche() -> bool:
	return sens == "verticale-h" or sens ==  "horizontale-g"
	
func is_bas_or_droite() -> bool:
	return sens == "verticale-b" or sens ==  "horizontale-d"
