extends Node2D 

var list_jetons = []
var ecart = 20
var taille = 1
var scene = preload("res://Area2D.tscn")
var x1 = 0
var y1 = 0
var plateau_x
var plateau_y
var child_2 

var x = 0
var y = 0
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
	x = 0
	y = 0   
	
func souris_pos_plateau():
	
	var retourx = 0
	var retoury = 0
	num = 2
	
	
	
	for n in range(9):

		for i in range(9):
			
			# Utiliser un index pour accéder à chaque enfant individuellement
			var child = get_child(num)
			
			if child is Area2D:
				
				child.scale.x = taille
				child.scale.y = taille
				child.position = Vector2(x1, y1)
				x1 = x1  + (20 * taille) 
				num += 1
				retourx = retourx + (20*taille)
		x1 -= retourx
		retourx = 0
		y1 = y1  + (20 * taille) 
		retoury = retoury  + (20*taille)
		
	y1 -= retoury
	print(taille)


func plateau(pos):
	var instance_plateau = scene.instance()
	instance_plateau.position = pos
	instance_plateau.visible = true
	add_child(instance_plateau)


		
		
func _input(event):

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
			
	if Input.is_key_pressed(KEY_LEFT):
		
		x1 -= 10
		souris_pos_plateau()

	if Input.is_key_pressed(KEY_RIGHT):
		
		x1 += 10
		souris_pos_plateau()

	if Input.is_key_pressed(KEY_UP):
		
		y1 -= 10
		souris_pos_plateau()

	if Input.is_key_pressed(KEY_DOWN):
		
		y1 += 10
		souris_pos_plateau()
