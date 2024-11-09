extends Node2D 

var pioche = PiocheUseCase.new()
var ecart = 20
var scene = preload("res://Plateau.tscn")
var etoile = preload("res://etoile.tscn")
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
var scene_jeton = preload("res://jetons.tscn")
#var scene_acceuil = preload("res://acceuil.tscn")


var random = RandomNumberGenerator.new()
var hazard

func _ready():
	pos_plateau()
	var premier_jeton:Jeton = pioche.pioche_jeton()
	modifie_plateau(163, premier_jeton.color0)
	modifie_plateau(182, premier_jeton.color1)
	modifie_plateau(201, premier_jeton.color2)
	Globals.list_affiche_position_porte_jetons.clear()
	affiche_nb_jetons_restant()
	
	
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
			Globals.position_de_chaque_carre_du_plateau.insert(0 ,Vector2(x, y))
			a = 20
			x += 20 
			retour = retour + a
		x -= retour
		retour = 0
		y += 20
	x = 0
	y = 0   

func souris_pos_plateau():
	Globals.position_de_chaque_carre_du_plateau.clear()
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
				Globals.position_de_chaque_carre_du_plateau.insert(0 ,Vector2(x1, y1))
				x1 = x1  + (20 * Globals.taille) 
				num += 1
				retourx = retourx + (20*Globals.taille)
		x1 -= retourx
		retourx = 0
		y1 = y1  + (20 * Globals.taille) 
		retoury = retoury  + (20*Globals.taille)
	y1 -= retoury

func pioche_jetons():
	
	var jeton_hazard:Jeton = pioche.pioche_jeton()
	var instance_jeton = scene_jeton.instance()
	
	instance_jeton.get_node("Area2D/jetons/Spritemilieu/Spritehaut").texture = jeton_hazard.color0
	instance_jeton.get_node("Area2D/jetons/Spritemilieu").texture = jeton_hazard.color1
	instance_jeton.get_node("Area2D/jetons/Spritemilieu/Spritebas").texture = jeton_hazard.color2
	
	var rech = instance_jeton.get_child(0)
	jeton_hazard.jeton_id = rech.get_instance_id()
	add_child(instance_jeton)
	Globals.affiche_jetons_piocher()
	


func affiche_nb_jetons_restant():
	
	if Globals.au_joueur1_de_jouer:
		$Area2D/AnimatedSpriteaujoueur1.position =  Vector2(85,495)
	else:
		$Area2D/AnimatedSpriteaujoueur1.position =  Vector2(85,545)
	var count = pioche.nb_jetons_restant()
	$Area2D/TextureRect2/Button_pioche/RichTextLabel.text = "PIOCHE = %d" % count
	var countjetonsjoueur1 = int(len(Globals.list_affiche_position_porte_jetons))
	var countjetonsjoueuria = int(len(Globals.list_affiche_position_porte_jetons_ia))
	$Area2D/TextureRect2/Button_pioche/textejoueur1.text = " Joueur 1 \n jetons = %d \n victoire =" % countjetonsjoueur1
	$Area2D/TextureRect2/Button_pioche/textejoueurIA.text = " Joueur IA \n jetons =  %d \n victoire =" % countjetonsjoueuria

func child_pioche_jetons():
	for d in Globals.nb_jetons_pioche:
	
		var jeton_hazard: Jeton = pioche.pioche_jeton()
		var instance_jeton = scene_jeton.instance()
	
		instance_jeton.get_node("Area2D/jetons/Spritemilieu/Spritehaut").texture = jeton_hazard.color0
		instance_jeton.get_node("Area2D/jetons/Spritemilieu").texture = jeton_hazard.color1
		instance_jeton.get_node("Area2D/jetons/Spritemilieu/Spritebas").texture = jeton_hazard.color2
		var rech = instance_jeton.get_child(0)
		jeton_hazard.jeton_id = rech.get_instance_id()
		add_child(instance_jeton)
		if Globals.au_joueur1_de_jouer:
			Globals.list_affiche_position_porte_jetons.insert(0, jeton_hazard)
		else:
			#rendinvisible les jeton piocher par ia
			Globals.list_affiche_position_porte_jetons_ia.insert(0, jeton_hazard)
			
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
	tourne_jeton()
	
func tourne_jeton():
	if Globals.au_joueur1_de_jouer:
		if len(Globals.list_affiche_position_porte_jetons) == 0:
			print("pioche d'abord joueur 1")
	else:
		if len(Globals.list_affiche_position_porte_jetons_ia) == 0:
			print("pioche d'abord joueur IA")
		
	if len(Globals.list_affiche_position_porte_jetons) >= 0:
		
		var target_id = Globals.list_affiche_position_porte_jetons[0].jeton_id  # Remplace par ton ID de nœud
		var node = find_node_by_instance_id(get_tree().root, target_id)
		if node:
			node.rotation_degrees += 90
			var actuel =  sens.find(Globals.list_affiche_position_porte_jetons[0].sens)
			if actuel < 3:
				nouveau = actuel + 1
			else:
				nouveau = 0
			Globals.list_affiche_position_porte_jetons[0].sens = sens[nouveau]
			#print(Globals.list_affiche_position_porte_jetons[0].sens)
			#print("tourn_n_child" + str(Globals.list_affiche_position_porte_jetons[0].jeton_id))
			#print("list " + str(Globals.list_affiche_position_porte_jetons))

func find_node_by_instance_id(node, target_id):
	if node.get_instance_id() == target_id:
		return node
		
	for child in node.get_children():
		var result = find_node_by_instance_id(child, target_id)
		if result:
			return result



