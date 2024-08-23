extends Node2D 
var ecart = 20
var taille = 1
var scene = preload("res://Area2D.tscn")
var x = 40
var y = 40

var num = 2


func _ready():
	
	pos_plateau()
	
func pos_plateau():
	
	var a = 0
	var retour = 0
	
	for i in range(0, 9):
		for n in range(0, 9):
			
			plateau(Vector2(x, y))
			
			a = 20
			x += 20 
			retour = retour + a
			
		x -= retour
		retour = 0
		y += 20
	x = 40
	y = 40   
	
func souris_pos_plateau():
	var mouse_position = get_viewport().get_mouse_position()
	var x = mouse_position.x
	var y = mouse_position.y
	
	for n in range(9):
		y = y + (n * (20 * taille))
		
		for i in range(9):
			
			x = x + (i * (20 * taille))
			
			# Utiliser un index pour accéder à chaque enfant individuellement
			var child = get_child(num)
			
			if child is Area2D:

				child.scale.x = taille
				child.scale.y = taille
				child.position = Vector2(x, y)
				num += 1
			x = mouse_position.x
		y = mouse_position.y
	num = 2

				
func plateau(pos):
	var instance_plateau = scene.instance()
	instance_plateau.position = pos
	instance_plateau.visible = true
	add_child(instance_plateau)



func _process(delta):
	if Input.is_mouse_button_pressed(BUTTON_LEFT):
		print("Le clic gauche de la souris est enfoncé")
		souris_pos_plateau()

func _input(event):
	var instance_plateau = scene.instance()
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_WHEEL_UP:
			# Action pour le défilement vers le haut
			print("Défilement vers le haut")
			taille -= 0.1
			souris_pos_plateau()
			
		elif event.button_index == BUTTON_WHEEL_DOWN:
			# Action pour le défilement vers le bas
			print("Défilement vers le bas")
			taille += 0.1
			souris_pos_plateau()
			
			
