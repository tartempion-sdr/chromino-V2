class_name Jeton extends Node

var color0: Resource
var color1: Resource
var color2: Resource

var sens: String = VERTI_H

var jeton_id: int
 
func _init(c0, c1, c2):
	color0 = c0
	color1 = c1
	color2 = c2

func is_haut_or_gauche() -> bool:
	return sens == VERTI_H or sens ==  HORI_G

func is_bas_or_droite() -> bool:
	return sens == VERTI_B or sens ==  HORI_D

func is_vertical() -> bool:
	return sens == VERTI_H or sens == VERTI_B

func is_horizontal() -> bool:
	return sens == HORI_G or sens == HORI_D

const VERTI_H = "verticale-h"
const VERTI_B = "verticale-b"
const HORI_D = "horizontale-d"
const HORI_G = "horizontale-g"
