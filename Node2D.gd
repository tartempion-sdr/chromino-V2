extends Node2D 


var ecart = 20
var taille = 1
var scene = preload("res://Plateau.tscn")
var x1 = 0
var y1 = 0
var plateau_x
var plateau_y
var child_2 
var x = 0
var y = 0
var num = 2

#75 chrominos classiques, 
#5 chrominos caméléon combinant 2 couleurs différentes à chaque extrémité
var joker = preload("res://assets/colors/joker.jpg")
var jaune = preload("res://assets/colors/jaune.jpg")
var vert = preload("res://assets/colors/vert.jpg")
var bleu = preload("res://assets/colors/bleu.jpg")
var violet = preload("res://assets/colors/violet.jpg")
var rouge = preload("res://assets/colors/rouge.jpg")

var scene_jeton = preload("res://jetons.tscn")
var nb_jetons_pioche = 7

var list_couleurs_jetons = [[jaune, jaune, jaune, true],
[jaune, jaune, vert, true],
[jaune, jaune, bleu, true],
[jaune, jaune, violet, true],
[jaune, jaune, rouge, true],

[jaune, vert, jaune, true],
[jaune, bleu, jaune, true],
[jaune, violet, jaune, true],
[jaune, rouge, jaune, true],

[jaune, vert, bleu, true],
[jaune, vert, violet, true],
[jaune, vert, rouge, true],

[jaune, bleu, vert, true],
[jaune, bleu, violet, true],
[jaune, bleu, rouge, true],

[jaune, violet, vert, true],
[jaune, violet, bleu, true],
[jaune, violet, rouge, true],

[jaune, rouge, vert, true],
[jaune, rouge, bleu, true],
[jaune, rouge, violet, true],

[vert, vert, vert, true],
[vert, vert, jaune, true],
[vert, vert, bleu, true],
[vert, vert, violet, true],
[vert, vert, rouge, true],

[vert, jaune, vert, true],
[vert, bleu, vert, true],
[vert, violet, vert, true],
[vert, rouge, vert, true],

[vert, jaune, bleu, true],
[vert, jaune, violet, true],
[vert, jaune, rouge, true],


[vert, bleu, violet, true],
[vert, bleu, rouge, true],

[vert, violet, bleu,true],
[vert, violet, rouge, true],

[vert, rouge, bleu, true],
[vert, rouge, violet, true],

[bleu, bleu, bleu, true],
[bleu, bleu, jaune, true],
[bleu, bleu, vert, true],
[bleu, bleu, violet, true],
[bleu, bleu, rouge, true],

[bleu, jaune, bleu, true],
[bleu, vert, bleu, true],
[bleu, violet, bleu, true],
[bleu, rouge, bleu, true],


[bleu, jaune, violet, true],
[bleu, jaune, rouge, true],

[bleu, vert, violet, true],
[bleu, vert, rouge, true],

[bleu, violet, rouge, true],
[bleu, rouge, violet, true],


[violet, violet, violet, true],
[violet, violet, jaune, true],
[violet, violet, vert, true],
[violet, violet, bleu, true],
[violet, violet, rouge, true],

[violet, jaune, violet, true],
[violet, vert, violet, true],
[violet, bleu, violet, true],
[violet, rouge, violet, true],

[violet, jaune, rouge, true],
[violet, vert, rouge, true],
[violet, bleu, rouge, true],


[rouge, rouge, rouge, true],
[rouge, rouge, jaune, true],
[rouge, rouge, vert, true],
[rouge, rouge, bleu, true],
[rouge, rouge, violet, true],

[rouge, jaune, rouge, true],
[rouge, vert, rouge, true],
[rouge, bleu, rouge, true],
[rouge, violet, rouge, true],

[jaune, joker, jaune, true],
[vert, joker, vert, true],
[bleu, joker, bleu, true],
[violet, joker, violet, true],
[rouge, joker, rouge, true]]


var list_position_pioche_jetons = [(Vector2(400, 560)),
(Vector2(450, 560)),
(Vector2(500, 560)),
(Vector2(550, 560)),
(Vector2(600, 560)),
(Vector2(650, 560)),
(Vector2(700, 560))]

var list_affihe_position_porte_jetons = []
var random = RandomNumberGenerator.new()
var hazard
func _ready():
	
	
	random.randomize()

	
	pos_plateau()
	
	
func plateau(pos):
	var instance_plateau = scene.instance()
	instance_plateau.position = pos
	instance_plateau.visible = true
	add_child(instance_plateau)

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

func pioche_jetons(d):
	
	print("nombre de pieces" + str(len(list_couleurs_jetons)))
	hazard = random.randi_range(0, 79)
	print("random" + str(hazard))
	
	var instance_jeton = scene_jeton.instance()
	instance_jeton.position = list_position_pioche_jetons[d]
	instance_jeton.visible = true
	instance_jeton.get_node("CollisionShape2D/Spritemilieu/Spritehaut").texture = list_couleurs_jetons[hazard][0]
	instance_jeton.get_node("CollisionShape2D/Spritemilieu").texture = list_couleurs_jetons[hazard][1]
	instance_jeton.get_node("CollisionShape2D/Spritemilieu/Spritebas").texture = list_couleurs_jetons[hazard][2]
	add_child(instance_jeton)


	
func child_pioche_jetons():
	for d in nb_jetons_pioche:
		pioche_jetons(d)
	
					


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

func _on_Button_pioche_button_down():
	
	child_pioche_jetons()

func _on_Button_droite_button_down():
	pass # Replace with function body.


func _on_Button_gauche_button_down():
	pass # Replace with function body.
