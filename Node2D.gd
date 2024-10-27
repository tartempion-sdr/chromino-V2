extends Node2D 


var ecart = 20

var scene = preload("res://Plateau.tscn")
var x1 = 0
var y1 = 0
var plateau_x
var plateau_y
var child_2 
var x = 0
var y = 0
var num = 2
var jeton_child = 363
var sens = ["verticale-h", "horizontale-d", "verticale-b", "horizontale-g"] 
var nouveau
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
var scene_acceuil = preload("res://acceuil.tscn")
var nb_jetons_pioche = 7

var list_couleurs_jetons = [[jaune, jaune, jaune, true, sens[0]],
[jaune, jaune, vert, true, sens[0]],
[jaune, jaune, bleu, true, sens[0]],
[jaune, jaune, violet, true, sens[0]],
[jaune, jaune, rouge, true, sens[0]],
[jaune, vert, jaune, true, sens[0]],
[jaune, bleu, jaune, true, sens[0]],
[jaune, violet, jaune, true, sens[0]],
[jaune, rouge, jaune, true, sens[0]],
[jaune, vert, bleu, true, sens[0]],
[jaune, vert, violet, true, sens[0]],
[jaune, vert, rouge, true, sens[0]],
[jaune, bleu, vert, true, sens[0]],
[jaune, bleu, violet, true, sens[0]],
[jaune, bleu, rouge, true, sens[0]],
[jaune, violet, vert, true, sens[0]],
[jaune, violet, bleu, true, sens[0]],
[jaune, violet, rouge, true, sens[0]],
[jaune, rouge, vert, true, sens[0]],
[jaune, rouge, bleu, true, sens[0]],
[jaune, rouge, violet, true, sens[0]],

[vert, vert, vert, true, sens[0]],
[vert, vert, jaune, true, sens[0]],
[vert, vert, bleu, true, sens[0]],
[vert, vert, violet, true, sens[0]],
[vert, vert, rouge, true, sens[0]],

[vert, jaune, vert, true, sens[0]],
[vert, bleu, vert, true, sens[0]],
[vert, violet, vert, true, sens[0]],
[vert, rouge, vert, true, sens[0]],
[vert, jaune, bleu, true, sens[0]],
[vert, jaune, violet, true, sens[0]],
[vert, jaune, rouge, true, sens[0]],
[vert, bleu, violet, true, sens[0]],
[vert, bleu, rouge, true, sens[0]],
[vert, violet, bleu,true, sens[0]],
[vert, violet, rouge, true, sens[0]],
[vert, rouge, bleu, true, sens[0]],
[vert, rouge, violet, true, sens[0]],

[bleu, bleu, bleu, true, sens[0]],
[bleu, bleu, jaune, true, sens[0]],
[bleu, bleu, vert, true, sens[0]],
[bleu, bleu, violet, true, sens[0]],
[bleu, bleu, rouge, true, sens[0]],
[bleu, jaune, bleu, true, sens[0]],
[bleu, vert, bleu, true, sens[0]],
[bleu, violet, bleu, true, sens[0]],
[bleu, rouge, bleu, true, sens[0]],
[bleu, jaune, violet, true, sens[0]],
[bleu, jaune, rouge, true, sens[0]],
[bleu, vert, violet, true, sens[0]],
[bleu, vert, rouge, true, sens[0]],
[bleu, violet, rouge, true, sens[0]],
[bleu, rouge, violet, true, sens[0]],

[violet, violet, violet, true, sens[0]],
[violet, violet, jaune, true, sens[0]],
[violet, violet, vert, true, sens[0]],
[violet, violet, bleu, true, sens[0]],
[violet, violet, rouge, true, sens[0]],
[violet, jaune, violet, true, sens[0]],
[violet, vert, violet, true, sens[0]],
[violet, bleu, violet, true, sens[0]],
[violet, rouge, violet, true, sens[0]],
[violet, jaune, rouge, true, sens[0]],
[violet, vert, rouge, true, sens[0]],
[violet, bleu, rouge, true, sens[0]],

[rouge, rouge, rouge, true, sens[0]],
[rouge, rouge, jaune, true, sens[0]],
[rouge, rouge, vert, true, sens[0]],
[rouge, rouge, bleu, true, sens[0]],
[rouge, rouge, violet, true, sens[0]],
[rouge, jaune, rouge, true, sens[0]],
[rouge, vert, rouge, true, sens[0]],
[rouge, bleu, rouge, true, sens[0]],
[rouge, violet, rouge, true, sens[0]],

[jaune, joker, jaune, true, sens[0]],
[vert, joker, vert, true, sens[0]],
[bleu, joker, bleu, true, sens[0]],
[violet, joker, violet, true, sens[0]],
[rouge, joker, rouge, true, sens[0]]]



var random = RandomNumberGenerator.new()
var hazard

func _ready():

	random.randomize()
	pos_plateau()
	pioche_jetons()
	modifie_plateau(163, list_couleurs_jetons[hazard][0])
	modifie_plateau(182, list_couleurs_jetons[hazard][1])
	modifie_plateau(201, list_couleurs_jetons[hazard][2])
	
	var child_jeton = get_child(363)
	#print("Enfant à l'index ", " : ", child_jeton.name)
	child_jeton.visible = false
	
	Globals.list_affiche_position_porte_jetons.clear()
	affiche_nb_jetons_restant()
	var test_acceuil = scene_acceuil.instance()
	add_child(test_acceuil)
	
func modifie_plateau(numero, couleur):
	
	var child = get_child(numero)
	if child is Area2D:
		
		var childt = child.get_child(0)
		if childt is Sprite:
			childt.texture = couleur
			
func plateau(pos):
	var instance_plateau = scene.instance()
	instance_plateau.position = pos
	instance_plateau.visible = true
	add_child(instance_plateau)

func pos_plateau():
	
	var a = 0
	var retour = 0
	
	for i in range(0, 19):
		for n in range(0, 19):
			
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
	
	for n in range(19):

		for i in range(19):
			
			# Utiliser un index pour accéder à chaque enfant individuellement
			var child = get_child(num)
			if child is Area2D:
				
				child.scale.x = Globals.taille
				child.scale.y = Globals.taille
				child.position = Vector2(x1, y1)
				x1 = x1  + (20 * Globals.taille) 
				num += 1
				retourx = retourx + (20*Globals.taille)
		x1 -= retourx
		retourx = 0
		y1 = y1  + (20 * Globals.taille) 
		retoury = retoury  + (20*Globals.taille)
	y1 -= retoury
	

func pioche_jetons():
	
	
	hazard = random.randi_range(0, 79)
	while list_couleurs_jetons[hazard][3] == false:
		hazard = random.randi_range(0, 79)
	list_couleurs_jetons[hazard][3] = false
	var instance_jeton = scene_jeton.instance()
	
	instance_jeton.get_node("Area2D/jetons/Spritemilieu/Spritehaut").texture = list_couleurs_jetons[hazard][0]
	instance_jeton.get_node("Area2D/jetons/Spritemilieu").texture = list_couleurs_jetons[hazard][1]
	instance_jeton.get_node("Area2D/jetons/Spritemilieu/Spritebas").texture = list_couleurs_jetons[hazard][2]
	
	var rech = instance_jeton.get_child(0)
	jeton_child = rech.get_instance_id()
	add_child(instance_jeton)
	#print("id jeton " + str(jeton_child))
	
	
	#print(instance_jeton.name)
	Globals.affiche_jetons_piocher()

	

func affiche_nb_jetons_restant():
	
	var count = 0
	for sublist in list_couleurs_jetons:
		if sublist.size() >= 4 and sublist[3] == true:
			count += 1
	$TextureRect2/Button_pioche/RichTextLabel.text = "JETONS = %d" % count

func child_pioche_jetons():
	for d in nb_jetons_pioche:
		pioche_jetons()
		
		list_couleurs_jetons[hazard].append(jeton_child)
		
		Globals.list_affiche_position_porte_jetons.insert(0, list_couleurs_jetons[hazard])
		Globals.affiche_jetons_piocher()
		affiche_nb_jetons_restant()

func _input(event):

	if event is InputEventMouseButton:
		if event.button_index == BUTTON_WHEEL_UP:
			if Globals.taille > 0.7 :
				# Action pour le défilement vers le haut
				print("ZOOM -")
				Globals.taille -= 0.1
				souris_pos_plateau()
				Globals.affiche_jetons_piocher()
			
		elif event.button_index == BUTTON_WHEEL_DOWN:
			if Globals.taille < 1.8 :
				# Action pour le défilement vers le bas
				print("ZOOM +")
				Globals.taille += 0.1
				souris_pos_plateau()
				Globals.affiche_jetons_piocher()
				
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
	#print(Globals.list_affiche_position_porte_jetons)
	
func _on_Button_droite_button_down():
	
	if len(Globals.list_affiche_position_porte_jetons) == 0:
		print("pioche d'abord")
	elif len(Globals.list_affiche_position_porte_jetons) >= 0:
		print("droite")
		var last_element = Globals.list_affiche_position_porte_jetons.pop_back()
		Globals.list_affiche_position_porte_jetons.insert(0, last_element)
		Globals.affiche_jetons_piocher()

func _on_Button_gauche_button_down():

	if len(Globals.list_affiche_position_porte_jetons) == 0:
		print("pioche d'abore")
		
	elif len(Globals.list_affiche_position_porte_jetons) >= 0:
	
		var prem_element = Globals.list_affiche_position_porte_jetons.pop_front()
		Globals.list_affiche_position_porte_jetons.append(prem_element)
		Globals.affiche_jetons_piocher()
		
func _on_Button_tourne_button_down():
	
	if len(Globals.list_affiche_position_porte_jetons) == 0:
		print("pioche d'abord")
	
	elif len(Globals.list_affiche_position_porte_jetons) >= 0:
		
		var target_id = Globals.list_affiche_position_porte_jetons[0][5]  # Remplace par ton ID de nœud
		var node = find_node_by_instance_id(get_tree().root, target_id)
		#print("target" + str(target_id))
		if node:
			
			node.rotation_degrees += 90
			#child_jeton.get_node("Area2D").rotation_degrees += 90
			
			var actuel =  sens.find(Globals.list_affiche_position_porte_jetons[0][4])
			
			if actuel < 3:
				nouveau = actuel + 1
			else:
				nouveau = 0
			Globals.list_affiche_position_porte_jetons[0][4] = sens[nouveau]
			#print(Globals.list_affiche_position_porte_jetons[0][4])
			#print("tourn_n_child" + str(Globals.list_affiche_position_porte_jetons[0][5]))
			#print("list " + str(Globals.list_affiche_position_porte_jetons))

func find_node_by_instance_id(node, target_id):
	if node.get_instance_id() == target_id:
		return node
		
	for child in node.get_children():
		var result = find_node_by_instance_id(child, target_id)
		if result:
			return result


func _on_helperjeu_pressed():
	var acceuil = find_node_recursive(get_tree().root, "acceuil")
	if acceuil:
		print("Le nœud 'acceuil' trouvé : ", acceuil.name)
		if acceuil is TextureRect:
			acceuil.visible = true

			print("Le TextureRect 'acceuil' est maintenant invisible.")
		else:
			print("Le nœud 'acceuil' trouvé n'est pas un TextureRect.")
	else:
		print("Le nœud 'acceuil' n'a pas été trouvé.")

func find_node_recursive(parent, name):
	if parent.name == name:
		return parent

	for child in parent.get_children():
		var result = find_node_recursive(child, name)
		if result != null:
			return result

	return null

