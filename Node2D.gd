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
var jeton_child = 83
var verticale = "verticale"
var horizontale = "horizontale"
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

var list_couleurs_jetons = [[jaune, jaune, jaune, true, verticale],
[jaune, jaune, vert, true, verticale],
[jaune, jaune, bleu, true, verticale],
[jaune, jaune, violet, true, verticale],
[jaune, jaune, rouge, true, verticale],

[jaune, vert, jaune, true, verticale],
[jaune, bleu, jaune, true, verticale],
[jaune, violet, jaune, true, verticale],
[jaune, rouge, jaune, true, verticale],

[jaune, vert, bleu, true, verticale],
[jaune, vert, violet, true, verticale],
[jaune, vert, rouge, true, verticale],

[jaune, bleu, vert, true, verticale],
[jaune, bleu, violet, true, verticale],
[jaune, bleu, rouge, true, verticale],

[jaune, violet, vert, true, verticale],
[jaune, violet, bleu, true, verticale],
[jaune, violet, rouge, true, verticale],

[jaune, rouge, vert, true, verticale],
[jaune, rouge, bleu, true, verticale],
[jaune, rouge, violet, true, verticale],

[vert, vert, vert, true, verticale],
[vert, vert, jaune, true, verticale],
[vert, vert, bleu, true, verticale],
[vert, vert, violet, true, verticale],
[vert, vert, rouge, true, verticale],

[vert, jaune, vert, true, verticale],
[vert, bleu, vert, true, verticale],
[vert, violet, vert, true, verticale],
[vert, rouge, vert, true, verticale],

[vert, jaune, bleu, true, verticale],
[vert, jaune, violet, true, verticale],
[vert, jaune, rouge, true, verticale],


[vert, bleu, violet, true, verticale],
[vert, bleu, rouge, true, verticale],

[vert, violet, bleu,true, verticale],
[vert, violet, rouge, true, verticale],

[vert, rouge, bleu, true, verticale],
[vert, rouge, violet, true, verticale],

[bleu, bleu, bleu, true, verticale],
[bleu, bleu, jaune, true, verticale],
[bleu, bleu, vert, true, verticale],
[bleu, bleu, violet, true, verticale],
[bleu, bleu, rouge, true, verticale],

[bleu, jaune, bleu, true, verticale],
[bleu, vert, bleu, true, verticale],
[bleu, violet, bleu, true, verticale],
[bleu, rouge, bleu, true, verticale],


[bleu, jaune, violet, true, verticale],
[bleu, jaune, rouge, true, verticale],

[bleu, vert, violet, true, verticale],
[bleu, vert, rouge, true, verticale],

[bleu, violet, rouge, true, verticale],
[bleu, rouge, violet, true, verticale],


[violet, violet, violet, true, verticale],
[violet, violet, jaune, true, verticale],
[violet, violet, vert, true, verticale],
[violet, violet, bleu, true, verticale],
[violet, violet, rouge, true, verticale],

[violet, jaune, violet, true, verticale],
[violet, vert, violet, true, verticale],
[violet, bleu, violet, true, verticale],
[violet, rouge, violet, true, verticale],

[violet, jaune, rouge, true, verticale],
[violet, vert, rouge, true, verticale],
[violet, bleu, rouge, true, verticale],


[rouge, rouge, rouge, true, verticale],
[rouge, rouge, jaune, true, verticale],
[rouge, rouge, vert, true, verticale],
[rouge, rouge, bleu, true, verticale],
[rouge, rouge, violet, true, verticale],

[rouge, jaune, rouge, true, verticale],
[rouge, vert, rouge, true, verticale],
[rouge, bleu, rouge, true, verticale],
[rouge, violet, rouge, true, verticale],

[jaune, joker, jaune, true, verticale],
[vert, joker, vert, true, verticale],
[bleu, joker, bleu, true, verticale],
[violet, joker, violet, true, verticale],
[rouge, joker, rouge, true, verticale]]


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
	while list_couleurs_jetons[hazard][3] == false:
		hazard = random.randi_range(0, 79)
	
	print("random" + str(hazard))
	var instance_jeton = scene_jeton.instance()
	instance_jeton.position = list_position_pioche_jetons[d]
	instance_jeton.visible = true
	instance_jeton.get_node("CollisionShape2D/Spritemilieu/Spritehaut").texture = list_couleurs_jetons[hazard][0]
	instance_jeton.get_node("CollisionShape2D/Spritemilieu").texture = list_couleurs_jetons[hazard][1]
	instance_jeton.get_node("CollisionShape2D/Spritemilieu/Spritebas").texture = list_couleurs_jetons[hazard][2]
	list_couleurs_jetons[hazard][3] = false
	list_affihe_position_porte_jetons.append(list_couleurs_jetons[hazard])
	add_child(instance_jeton)
	list_affihe_position_porte_jetons[-1].append(jeton_child)
	jeton_child += 1
	print(list_affihe_position_porte_jetons[-1])
		

func affiche_nb_jetons_restant():
	
	var count = 0
	for sublist in list_couleurs_jetons:
		if sublist.size() >= 4 and sublist[3] == true:
			count += 1
	print("Nombre d'éléments True à la quatrième position : %d" % count)
	$TextureRect2/Button_pioche/RichTextLabel.text = "JETONS DISPONIBLE = %d" % count


	
				#print(e)
			#print("restant " + str(list_couleurs_jetons[0][3].count(true)))

			
				
func child_pioche_jetons():
	for d in nb_jetons_pioche:
		pioche_jetons(d)
		affiche_nb_jetons_restant()
					


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
	
	if len(list_affihe_position_porte_jetons) == 0:
		print("pioche dabore")
	elif len(list_affihe_position_porte_jetons) >= 0:
			
		var prem_element = list_position_pioche_jetons.pop_front()
		list_position_pioche_jetons.append(prem_element)
			
		for f in len(list_affihe_position_porte_jetons):
			var child_jeton = get_child(list_affihe_position_porte_jetons[f][5])
			
			if child_jeton is Area2D:
				
				child_jeton.position = list_position_pioche_jetons[f]
				print(list_position_pioche_jetons)


func _on_Button_gauche_button_down():
	

	if len(list_affihe_position_porte_jetons) == 0:
		print("pioche dabore")
	elif len(list_affihe_position_porte_jetons) >= 0:
		
		var last_element = list_position_pioche_jetons.pop_back()
		list_position_pioche_jetons.insert(0, last_element)
			
		for f in len(list_affihe_position_porte_jetons):
		
			var child_jeton = get_child(list_affihe_position_porte_jetons[f][5])
			
			if child_jeton is Area2D:
				child_jeton.position = list_position_pioche_jetons[f]

func _on_Button_tourne_button_down():
	
	if len(list_affihe_position_porte_jetons) == 0:
		print("pioche dabore")
	elif len(list_affihe_position_porte_jetons) >= 0:
		print()
		
	elif len(list_affihe_position_porte_jetons) >= 0:
		var child_jeton = get_child(list_affihe_position_porte_jetons[0][5])
			
		if child_jeton is Area2D:
			child_jeton.get_node("CollisionShape2D").rotation_degrees += 90
