extends Node2D 


var ecart = 20
var taille = 1
var scene = preload("res://Plateau.tscn")
var x1 = 0
var y1 = 0
var plateau_x
var plateau_y
var child_2 
var x = 10
var y = 10
var num = 2
var jeton_child = 83
var sens = "verticale-h"

#75 chrominos classiques, 
#5 chrominos caméléon combinant 2 couleurs différentes à chaque extrémité
var joker = preload("res://assets/colors/joker.jpg")
var jaune = preload("res://assets/colors/jaune.jpg")
var vert = preload("res://assets/colors/vert.jpg")
var bleu = preload("res://assets/colors/bleu.jpg")
var violet = preload("res://assets/colors/violet.jpg")
var rouge = preload("res://assets/colors/rouge.jpg")
var blanc = preload("res://assets/colors/carre-blanc.png")

var scene_jeton = preload("res://jetons.tscn")
var nb_jetons_pioche = 7

var list_couleurs_jetons = [[jaune, jaune, jaune, true, sens],
[jaune, jaune, vert, true, sens],
[jaune, jaune, bleu, true, sens],
[jaune, jaune, violet, true, sens],
[jaune, jaune, rouge, true, sens],

[jaune, vert, jaune, true, sens],
[jaune, bleu, jaune, true, sens],
[jaune, violet, jaune, true, sens],
[jaune, rouge, jaune, true, sens],

[jaune, vert, bleu, true, sens],
[jaune, vert, violet, true, sens],
[jaune, vert, rouge, true, sens],

[jaune, bleu, vert, true, sens],
[jaune, bleu, violet, true, sens],
[jaune, bleu, rouge, true, sens],

[jaune, violet, vert, true, sens],
[jaune, violet, bleu, true, sens],
[jaune, violet, rouge, true, sens],

[jaune, rouge, vert, true, sens],
[jaune, rouge, bleu, true, sens],
[jaune, rouge, violet, true, sens],

[vert, vert, vert, true, sens],
[vert, vert, jaune, true, sens],
[vert, vert, bleu, true, sens],
[vert, vert, violet, true, sens],
[vert, vert, rouge, true, sens],

[vert, jaune, vert, true, sens],
[vert, bleu, vert, true, sens],
[vert, violet, vert, true, sens],
[vert, rouge, vert, true, sens],

[vert, jaune, bleu, true, sens],
[vert, jaune, violet, true, sens],
[vert, jaune, rouge, true, sens],


[vert, bleu, violet, true, sens],
[vert, bleu, rouge, true, sens],

[vert, violet, bleu,true, sens],
[vert, violet, rouge, true, sens],

[vert, rouge, bleu, true, sens],
[vert, rouge, violet, true, sens],

[bleu, bleu, bleu, true, sens],
[bleu, bleu, jaune, true, sens],
[bleu, bleu, vert, true, sens],
[bleu, bleu, violet, true, sens],
[bleu, bleu, rouge, true, sens],

[bleu, jaune, bleu, true, sens],
[bleu, vert, bleu, true, sens],
[bleu, violet, bleu, true, sens],
[bleu, rouge, bleu, true, sens],


[bleu, jaune, violet, true, sens],
[bleu, jaune, rouge, true, sens],

[bleu, vert, violet, true, sens],
[bleu, vert, rouge, true, sens],

[bleu, violet, rouge, true, sens],
[bleu, rouge, violet, true, sens],


[violet, violet, violet, true, sens],
[violet, violet, jaune, true, sens],
[violet, violet, vert, true, sens],
[violet, violet, bleu, true, sens],
[violet, violet, rouge, true, sens],

[violet, jaune, violet, true, sens],
[violet, vert, violet, true, sens],
[violet, bleu, violet, true, sens],
[violet, rouge, violet, true, sens],

[violet, jaune, rouge, true, sens],
[violet, vert, rouge, true, sens],
[violet, bleu, rouge, true, sens],


[rouge, rouge, rouge, true, sens],
[rouge, rouge, jaune, true, sens],
[rouge, rouge, vert, true, sens],
[rouge, rouge, bleu, true, sens],
[rouge, rouge, violet, true, sens],

[rouge, jaune, rouge, true, sens],
[rouge, vert, rouge, true, sens],
[rouge, bleu, rouge, true, sens],
[rouge, violet, rouge, true, sens],

[jaune, joker, jaune, true, sens],
[vert, joker, vert, true, sens],
[bleu, joker, bleu, true, sens],
[violet, joker, violet, true, sens],
[rouge, joker, rouge, true, sens]]


var list_position_pioche_jetons = [(Vector2(150, 543)),
(Vector2(280, 543)),
(Vector2(410, 543)),
(Vector2(540, 543)),
(Vector2(670, 543)),
(Vector2(800, 543)),
(Vector2(930, 543)),
(Vector2(1060, 543))]


var random = RandomNumberGenerator.new()
var hazard





func _ready():
	
	random.randomize()
	pos_plateau()
	pioche_jetons(1)
	modifie_plateau(33, list_couleurs_jetons[hazard][0])
	modifie_plateau(42, list_couleurs_jetons[hazard][1])
	modifie_plateau(51, list_couleurs_jetons[hazard][2])
	print(Globals.list_affiche_position_porte_jetons)
	print(len(Globals.list_affiche_position_porte_jetons))
	var child_jeton = get_child(Globals.list_affiche_position_porte_jetons[0][5])
	child_jeton.visible = false
	Globals.list_affiche_position_porte_jetons.remove(0)
	print(Globals.list_affiche_position_porte_jetons)
	
	affiche_nb_jetons_restant()

		
func modifie_plateau(numero, couleur):
	var child = get_child(numero)
			
	if child is Area2D:
		
		print("Child: ", child.name, "Type: ", child)
		
		
		var childt = child.get_child(0)
		
		if childt is Sprite:
			print("Child: ", childt.name, "Type: ", childt)
			childt.texture = couleur
			
				
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
	
	
	
	hazard = random.randi_range(0, 79)
	while list_couleurs_jetons[hazard][3] == false:
		hazard = random.randi_range(0, 79)
	
	print("random" + str(hazard))
	var instance_jeton = scene_jeton.instance()

	instance_jeton.get_node("Area2D/jetons/Spritemilieu/Spritehaut").texture = list_couleurs_jetons[hazard][0]
	instance_jeton.get_node("Area2D/jetons/Spritemilieu").texture = list_couleurs_jetons[hazard][1]
	instance_jeton.get_node("Area2D/jetons/Spritemilieu/Spritebas").texture = list_couleurs_jetons[hazard][2]
	#instance_jeton.get_node("jetons").connect("mouse_entered", self, "_input")
	
	list_couleurs_jetons[hazard][3] = false
	list_couleurs_jetons[hazard].append(jeton_child)
	
	Globals.list_affiche_position_porte_jetons.insert(0, list_couleurs_jetons[hazard])
	add_child(instance_jeton)



	jeton_child += 1
	
	affiche_jetons_piocher()
	

	

func affiche_jetons_piocher():
	
	for f in len(Globals.list_affiche_position_porte_jetons):
		var child_jeton = get_child(Globals.list_affiche_position_porte_jetons[f][5])
			
		if child_jeton is Node2D:

			#print($TextureRect2/TextureRect3/jetons/CollisionShape2D.position())
			if f < 8:
				child_jeton.visible = true
				child_jeton.position = list_position_pioche_jetons[f]
				
			else:
				child_jeton.visible = false
				child_jeton.position = list_position_pioche_jetons[7]
				
			child_jeton.scale.x = taille
			child_jeton.scale.y = taille

func affiche_nb_jetons_restant():
	
	var count = 0
	for sublist in list_couleurs_jetons:
		if sublist.size() >= 4 and sublist[3] == true:
			count += 1
	print("Nombre d'éléments True à la quatrième position : %d" % count)
	$TextureRect2/Button_pioche/RichTextLabel.text = "JETONS = %d" % count

func child_pioche_jetons():
	for d in nb_jetons_pioche:
		pioche_jetons(d)

		affiche_jetons_piocher()
		affiche_nb_jetons_restant()

func _input(event):

	if event is InputEventMouseButton:
		if event.button_index == BUTTON_WHEEL_UP:
			if taille > 0.7 :
				# Action pour le défilement vers le haut
				print("Défilement vers le haut")
				taille -= 0.1
				souris_pos_plateau()
				affiche_jetons_piocher()
			
		elif event.button_index == BUTTON_WHEEL_DOWN:
			if taille < 1.8 :
				# Action pour le défilement vers le bas
				print("Défilement vers le bas")
				taille += 0.1
				souris_pos_plateau()
				affiche_jetons_piocher()
				
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
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed :
		pass
		
func _on_Button_pioche_button_down():
	
	child_pioche_jetons()
	
	
func _on_Button_droite_button_down():
	
	if len(Globals.list_affiche_position_porte_jetons) == 0:
		print("pioche dabore")
	elif len(Globals.list_affiche_position_porte_jetons) >= 0:
		print("droite")
		
		var last_element = Globals.list_affiche_position_porte_jetons.pop_back()
		Globals.list_affiche_position_porte_jetons.insert(0, last_element)
			
		affiche_jetons_piocher()


func _on_Button_gauche_button_down():
	

	if len(Globals.list_affiche_position_porte_jetons) == 0:
		print("pioche dabore")
	elif len(Globals.list_affiche_position_porte_jetons) >= 0:
	
		var prem_element = Globals.list_affiche_position_porte_jetons.pop_front()
		Globals.list_affiche_position_porte_jetons.append(prem_element)
			
		
		affiche_jetons_piocher()
		
func _on_Button_tourne_button_down():
	
	if len(Globals.list_affiche_position_porte_jetons) == 0:
		print("pioche dabore")
	
	elif len(Globals.list_affiche_position_porte_jetons) >= 0:
		var child_jeton = get_child(Globals.list_affiche_position_porte_jetons[0][5])
			
		if child_jeton is Node2D:
			
			child_jeton.get_node("Area2D").rotation_degrees += 90
			#child_jeton.get_node("jetons/Spritemilieu/Spritehaut").rotation_degrees += 90
			#child_jeton.get_node("jetons/Spritemilieu/Spritebas").rotation_degrees += 90
			#child_jeton.get_node("jetons/CollisionShape2Dhaut").rotation_degrees += 90
			#child_jeton.get_node("jetons/CollisionShape2Dbas").rotation_degrees += 90
			
			if Globals.list_affiche_position_porte_jetons[0][4] == "verticale-h":
				Globals.list_affiche_position_porte_jetons[0][4] = "horizontale-d"
			elif Globals.list_affiche_position_porte_jetons[0][4] == "horizontale-d":
				Globals.list_affiche_position_porte_jetons[0][4] = "verticale-b"
			elif Globals.list_affiche_position_porte_jetons[0][4] == "verticale-b":
				Globals.list_affiche_position_porte_jetons[0][4] = "horizontale-g"
			elif Globals.list_affiche_position_porte_jetons[0][4] == "horizontale-g":
				Globals.list_affiche_position_porte_jetons[0][4] = "verticale-h"
				
			print(Globals.list_affiche_position_porte_jetons[0][4])

