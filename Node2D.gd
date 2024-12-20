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
var colors = Colors.new()

var joker = colors.joker
var jaune = colors.jaune
var vert = colors.vert
var bleu = colors.bleu
var violet = colors.violet
var rouge = colors.rouge
var blanc = colors.blanc

var scene_jeton = preload("res://jetons.tscn")
#var scene_acceuil = preload("res://acceuil.tscn")
var nb_jetons_pioche = 7

var list_couleurs_jetons: Array = [
	Jeton.new(jaune, jaune, jaune),
	Jeton.new(jaune, jaune, vert),
	Jeton.new(jaune, jaune, bleu),
	Jeton.new(jaune, jaune, violet),
	Jeton.new(jaune, jaune, rouge),
	Jeton.new(jaune, vert, jaune),
	Jeton.new(jaune, bleu, jaune),
	Jeton.new(jaune, violet, jaune),
	Jeton.new(jaune, rouge, jaune),
	Jeton.new(jaune, vert, bleu),
	Jeton.new(jaune, vert, violet),
	Jeton.new(jaune, vert, rouge),
	Jeton.new(jaune, bleu, vert),
	Jeton.new(jaune, bleu, violet),
	Jeton.new(jaune, bleu, rouge),
	Jeton.new(jaune, violet, vert),
	Jeton.new(jaune, violet, bleu),
	Jeton.new(jaune, violet, rouge),
	Jeton.new(jaune, rouge, vert),
	Jeton.new(jaune, rouge, bleu),
	Jeton.new(jaune, rouge, violet),

	Jeton.new(vert, vert, vert),
	Jeton.new(vert, vert, jaune),
	Jeton.new(vert, vert, bleu),
	Jeton.new(vert, vert, violet),
	Jeton.new(vert, vert, rouge),

	Jeton.new(vert, jaune, vert),
	Jeton.new(vert, bleu, vert),
	Jeton.new(vert, violet, vert),
	Jeton.new(vert, rouge, vert),
	Jeton.new(vert, jaune, bleu),
	Jeton.new(vert, jaune, violet),
	Jeton.new(vert, jaune, rouge),
	Jeton.new(vert, bleu, violet),
	Jeton.new(vert, bleu, rouge),
	Jeton.new(vert, violet, bleu),
	Jeton.new(vert, violet, rouge),
	Jeton.new(vert, rouge, bleu),
	Jeton.new(vert, rouge, violet),

	Jeton.new(bleu, bleu, bleu),
	Jeton.new(bleu, bleu, jaune),
	Jeton.new(bleu, bleu, vert),
	Jeton.new(bleu, bleu, violet),
	Jeton.new(bleu, bleu, rouge),
	Jeton.new(bleu, jaune, bleu),
	Jeton.new(bleu, vert, bleu),
	Jeton.new(bleu, violet, bleu),
	Jeton.new(bleu, rouge, bleu),
	Jeton.new(bleu, jaune, violet),
	Jeton.new(bleu, jaune, rouge),
	Jeton.new(bleu, vert, violet),
	Jeton.new(bleu, vert, rouge),
	Jeton.new(bleu, violet, rouge),
	Jeton.new(bleu, rouge, violet),

	Jeton.new(violet, violet, violet),
	Jeton.new(violet, violet, jaune),
	Jeton.new(violet, violet, vert),
	Jeton.new(violet, violet, bleu),
	Jeton.new(violet, violet, rouge),
	Jeton.new(violet, jaune, violet),
	Jeton.new(violet, vert, violet),
	Jeton.new(violet, bleu, violet),
	Jeton.new(violet, rouge, violet),
	Jeton.new(violet, jaune, rouge),
	Jeton.new(violet, vert, rouge),
	Jeton.new(violet, bleu, rouge),

	Jeton.new(rouge, rouge, rouge),
	Jeton.new(rouge, rouge, jaune),
	Jeton.new(rouge, rouge, vert),
	Jeton.new(rouge, rouge, bleu),
	Jeton.new(rouge, rouge, violet),
	Jeton.new(rouge, jaune, rouge),
	Jeton.new(rouge, vert, rouge),
	Jeton.new(rouge, bleu, rouge),
	Jeton.new(rouge, violet, rouge),

	Jeton.new(jaune, joker, jaune),
	Jeton.new(vert, joker, vert),
	Jeton.new(bleu, joker, bleu),
	Jeton.new(violet, joker, violet),
	Jeton.new(rouge, joker, rouge)
]



var random = RandomNumberGenerator.new()
var hazard

func _ready():

	random.randomize()
	pos_plateau()
	pioche_jetons()
	var jeton_hazard:Jeton = list_couleurs_jetons[hazard]
	modifie_plateau(163, jeton_hazard.color0)
	modifie_plateau(182, jeton_hazard.color1)
	modifie_plateau(201, jeton_hazard.color2)
	
	var child_jeton = get_child(363)
	#print("Enfant à l'index ", " : ", child_jeton.name)
	child_jeton.visible = false
	
	Globals.list_affiche_position_porte_jetons.clear()
	affiche_nb_jetons_restant()
	#var test_acceuil = scene_acceuil.instance()
	#add_child(test_acceuil)
	
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
	var jeton_hazard:Jeton = list_couleurs_jetons[hazard]
	while jeton_hazard.is_disponible == false:
		hazard = random.randi_range(0, 79)
	jeton_hazard.is_disponible = false
	var instance_jeton = scene_jeton.instance()
	
	instance_jeton.get_node("Area2D/jetons/Spritemilieu/Spritehaut").texture = jeton_hazard.color0
	instance_jeton.get_node("Area2D/jetons/Spritemilieu").texture = jeton_hazard.color1
	instance_jeton.get_node("Area2D/jetons/Spritemilieu/Spritebas").texture = jeton_hazard.color2
	
	var rech = instance_jeton.get_child(0)
	jeton_child = rech.get_instance_id()
	add_child(instance_jeton)
	#print("id jeton " + str(jeton_child))
	
	
	#print(instance_jeton.name)
	Globals.affiche_jetons_piocher()

	

func affiche_nb_jetons_restant():
	
	var count = 0
	for jeton in list_couleurs_jetons:
		var jtn:Jeton = jeton
		if jtn.jeton_id != null and jtn.is_disponible:
			count += 1
			
	$Area2D/TextureRect2/Button_pioche/RichTextLabel.text = "PIOCHE = %d" % count
	var countjetonsjoueur1 = int(len(Globals.list_affiche_position_porte_jetons))
	$Area2D/TextureRect2/Button_pioche/textejoueur1.text = "Joueur 1 = %d" % countjetonsjoueur1
	$Area2D/TextureRect2/Button_pioche/textejoueurIA.text = "Joueur IA = "
	
func child_pioche_jetons():
	for d in nb_jetons_pioche:
		pioche_jetons()
		var jeton_hazard:Jeton = list_couleurs_jetons[hazard]
		jeton_hazard.jeton_id = jeton_child
		
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
			if Globals.taille < 1.7 :
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
	affiche_nb_jetons_restant()
	
func _on_Button_gauche_button_down():

	if len(Globals.list_affiche_position_porte_jetons) == 0:
		print("pioche d'abore")
		
	elif len(Globals.list_affiche_position_porte_jetons) >= 0:
	
		var prem_element = Globals.list_affiche_position_porte_jetons.pop_front()
		Globals.list_affiche_position_porte_jetons.append(prem_element)
		Globals.affiche_jetons_piocher()
	affiche_nb_jetons_restant()
	
func _on_Button_tourne_button_down():
	
	if len(Globals.list_affiche_position_porte_jetons) == 0:
		print("pioche d'abord")
	
	elif len(Globals.list_affiche_position_porte_jetons) >= 0:
		
		var target_id = Globals.list_affiche_position_porte_jetons[0].jeton_id  # Remplace par ton ID de nœud
		var node = find_node_by_instance_id(get_tree().root, target_id)
		#print("target" + str(target_id))
		if node:
			
			node.rotation_degrees += 90
			#child_jeton.get_node("Area2D").rotation_degrees += 90
			
			var actuel =  sens.find(Globals.list_affiche_position_porte_jetons[0].sens)
			
			if actuel < 3:
				nouveau = actuel + 1
			else:
				nouveau = 0
			Globals.list_affiche_position_porte_jetons[0].sens = sens[nouveau]
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



