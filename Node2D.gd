extends Node2D


var scene = preload("res://Area2D.tscn")
var x = 40
var y = 40




func _ready():
	
	pos_plateau()
	
func pos_plateau():
	var mouse_position = get_viewport().get_mouse_position()
	var a = int()
	var retour =int()
	for i in range(0, 9):
		for n in range(0, 9):

			
			plateau(Vector2(x, y))
			a = 20
			x += 20 
			retour = retour + a
			
			
		x -= retour
		retour =0
		y += 20
	

func plateau(pos):
	var instance_plateau = scene.instance()
	instance_plateau.position = pos
	add_child(instance_plateau)

func _process(delta):
# Called every fr
	pass
	

func _input(event):
	var instance_plateau = scene.instance()
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_WHEEL_UP:
			# Action pour le défilement vers le haut
			print("Défilement vers le haut")
			for child in get_children():
				if child is Area2D:
			# Modifier la position de l'enfant
					print("up")
		elif event.button_index == BUTTON_WHEEL_DOWN:
			# Action pour le défilement vers le bas
			print("Défilement vers le bas")
		elif event.button_index == BUTTON_LEFT and event.pressed:
		# Action pour le clic gauche
			print("Clic gauche")
			var mouse_position = get_viewport().get_mouse_position()
			print(mouse_position)
			x = mouse_position[0]
			y = mouse_position[1]
			pos_plateau()
			
