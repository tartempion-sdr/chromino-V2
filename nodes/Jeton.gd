class_name Jeton

var color1
var color2
var color3

var isChanged: bool = false
var sens: int       = Sens.Values.VERTICALE_H
var jetonChild: int = null

func _init(color1, color2, color3) -> Jeton:
	return Jeton(color1, color2, color3)