extends Node2D

var screen_limits = Rect2(Vector2(0, 0), Vector2(1280, 720))  # Ajuste ces valeurs selon la taille de ta scène
var move_child = false
var jeton_blanc_3 = false
var list_pos_plateau_remplace_blanc = []
var liste_colision_autour = []
var stream_list_couleur_bouge_jeton = []
var path_similaire = 0
var collision_count = 0
var collision_autour_count = 0
var area_autour
var suite = false
var similaire = false
var jeton_ia_place_trouver:bool = false
var sens = ["verticale-h", "horizontale-d", "verticale-b", "horizontale-g"] 

var joker = "res://assets/colors/joker.jpg"
var jaune = "res://assets/colors/jaune.jpg"
var vert = "res://assets/colors/vert.jpg"
var bleu = "res://assets/colors/bleu.jpg"
var violet = "res://assets/colors/violet.jpg"
var rouge = "res://assets/colors/rouge.jpg"
var blanc = "res://assets/colors/carre-blanc.png"
var carre_blanc = preload("res://assets/colors/carre-blanc.png")
var etoile = preload("res://etoile.tscn")
var pioche = preload("res://assets/pioche.png")
var croix = preload("res://assets/icon/croix.png")


func _ready():
	pass

func _physics_process(delta):
	if move_child:
		bouge_pion()

func _on_TextureButton_button_down():
	move_child = true

func _on_TextureButton_button_up():
	move_child = false

func _on_jetons_area_entered(area):
	
	if area.is_in_group("plateau"):
		var node2d_plateau = area  # Le `Node2D` du plateau
		
		var child_node2d_jeton = self.get_child(0)
		Globals.id_child_node2d_jeton =  child_node2d_jeton .get_instance_id()
		
		var child_node2d_plateau = node2d_plateau.get_child(0)
		
		list_pos_plateau_remplace_blanc.insert(0,child_node2d_plateau)
		list_pos_plateau_remplace_blanc.sort()
		if  child_node2d_plateau.texture == carre_blanc :
			collision_count += 1
			if collision_count == 3:
				if Globals.au_joueur1_de_jouer: 
					for jtn in Globals.list_affiche_position_porte_jetons:
						var jeton:Jeton = jtn
						if Globals.id_child_node2d_jeton == jeton.jeton_id:
							
							if jeton.is_haut_or_gauche():
								Globals.list_couleur_bouge_jeton.clear()
								Globals.list_couleur_bouge_jeton.append(
									self.get_node("Area2D/jetons/Spritemilieu/Spritehaut").texture.get_path()
								)
								Globals.list_couleur_bouge_jeton.append(
									self.get_node("Area2D/jetons/Spritemilieu").texture.get_path()
								)
								Globals.list_couleur_bouge_jeton.append(
									self.get_node("Area2D/jetons/Spritemilieu/Spritebas").texture.get_path()
								)
							
							if jeton.is_bas_or_droite():
								Globals.list_couleur_bouge_jeton.clear()
								Globals.list_couleur_bouge_jeton.append(
									self.get_node("Area2D/jetons/Spritemilieu/Spritebas").texture.get_path()
								)
								Globals.list_couleur_bouge_jeton.append(
									self.get_node("Area2D/jetons/Spritemilieu").texture.get_path()
								)
								Globals.list_couleur_bouge_jeton.append(
									self.get_node("Area2D/jetons/Spritemilieu/Spritehaut").texture.get_path()
								)
							
					#print(Globals.list_couleur_bouge_jeton)
					collision_count = 0
					jeton_blanc_3 = true
				
				else: 
					for jtn in Globals.list_affiche_position_porte_jetons_ia:
						var jeton:Jeton = jtn
						if Globals.id_child_node2d_jeton == jeton.jeton_id:
							
							if jeton.is_haut_or_gauche():
								Globals.list_couleur_bouge_jeton.clear()
								Globals.list_couleur_bouge_jeton.append(
									self.get_node("Area2D/jetons/Spritemilieu/Spritehaut").texture.get_path()
								)
								Globals.list_couleur_bouge_jeton.append(
									self.get_node("Area2D/jetons/Spritemilieu").texture.get_path()
								)
								Globals.list_couleur_bouge_jeton.append(
									self.get_node("Area2D/jetons/Spritemilieu/Spritebas").texture.get_path()
								)
							
							if jeton.is_bas_or_droite():
								Globals.list_couleur_bouge_jeton.clear()
								Globals.list_couleur_bouge_jeton.append(
									self.get_node("Area2D/jetons/Spritemilieu/Spritebas").texture.get_path()
								)
								Globals.list_couleur_bouge_jeton.append(
									self.get_node("Area2D/jetons/Spritemilieu").texture.get_path()
								)
								Globals.list_couleur_bouge_jeton.append(
									self.get_node("Area2D/jetons/Spritemilieu/Spritehaut").texture.get_path()
								)
							
					#print(Globals.list_couleur_bouge_jeton)
					collision_count = 0
					jeton_blanc_3 = true

func _on_jetons_area_exited(area):
	list_pos_plateau_remplace_blanc.clear()
	jeton_blanc_3 = false

func _on_verifieautour_area_entered(area_autour):
	if area_autour.is_in_group("plateau"):
		var node2d_plateau = area_autour  # Le `Node2D` du plateau
		liste_colision_autour.append(node2d_plateau.get_child(0).texture.get_path())
		if liste_colision_autour.size() == 8 && jeton_blanc_3:
			compare_autour()

func _on_verifieautour_area_exited(area_autour):
	path_similaire = 0
	liste_colision_autour.clear()
	similaire = true

func bouge_pion():
	var mouse_pos = get_viewport().get_mouse_position()
	var child_node = get_child(0)
	if child_node is Node2D:
		child_node.visible = true
		child_node.global_position = mouse_pos

func compare_autour():
	#print(liste_colision_autour)
	if Globals.au_joueur1_de_jouer:
		
		for jtn in Globals.list_affiche_position_porte_jetons:
			var jeton:Jeton = jtn
			if Globals.id_child_node2d_jeton == jeton.jeton_id:
				if jeton.is_vertical():
					check_colision_vertical()
				if jeton.is_horizontal():
					check_colision_horizontal()
	else:
		for jtn in Globals.list_affiche_position_porte_jetons_ia:
				var jeton:Jeton = jtn
				if Globals.id_child_node2d_jeton == jeton.jeton_id:
					if jeton.is_vertical():
						check_colision_vertical()
					if jeton.is_horizontal():
						check_colision_horizontal()

func check_colision_vertical():
	var similaire = true
	path_similaire = 0
	
	if !check_colision_v(0, 0):
		similaire = false
	if !check_colision_v(1, 0):
		similaire = false
	if !check_colision_v(2, 0):
		similaire = false
	if !check_colision_v(3, 1):
		similaire = false
	if !check_colision_v(4, 1):
		similaire = false
	if !check_colision_v(5, 2):
		similaire = false
	if !check_colision_v(6, 2):
		similaire = false
	if !check_colision_v(7, 2):
		similaire = false

	if similaire :
		#print(str(path_similaire) + " couleurs similaire")
		pass
	else:
		print("interdit")
		
	if path_similaire > 1 :
		if similaire:
			remplace_couleurs()
			path_similaire = 0

func check_colision_horizontal():
	var similaire = true
	path_similaire = 0
	if !check_colision_h(0,0,0):
		similaire = false
	if !check_colision_h(1,1,0):
		similaire = false
	if !check_colision_h(2,2,0):
		similaire = false
	if !check_colision_h(3,0,1):
		similaire = false
	if !check_colision_h(4,2,1):
		similaire = false
	if !check_colision_h(5,0,2):
		similaire = false
	if !check_colision_h(6,1,2):
		similaire = false
	if !check_colision_h(7,2,2):
		similaire = false

	if similaire :
		print(str(path_similaire) + " couleurs similaire")
	else:
		print("interdit")
	
	if path_similaire > 1 :
		if similaire:
			remplace_couleurs()
			path_similaire = 0

func remplace_couleurs():
	print("hurra joueur1 !")
	print(list_pos_plateau_remplace_blanc)
	
	for a in range(0, 3):
		list_pos_plateau_remplace_blanc[a].texture = load(Globals.list_couleur_bouge_jeton[a])
		var instance_etoile = etoile.instance()
		print(list_pos_plateau_remplace_blanc[a].get_parent().position)
		instance_etoile.position = Vector2(list_pos_plateau_remplace_blanc[a].get_parent().position)
		var child = instance_etoile.get_child(0)
		add_child(instance_etoile)

	

	Globals.rend_jeton_invisible()
	supprime_jeton_porte_jeton()
	Globals.affiche_jetons_piocher()
	var node2d_scene = get_tree().get_root().get_node("Node2D")
	print("Noeud Node2D trouvé : ", node2d_scene)
	
	node2d_scene.affiche_nb_jetons_restant()
	if Globals.au_joueur1_de_jouer:
		if node2d_scene: # Accède au bouton pioche
			var button_pioche = node2d_scene.get_node("Area2D/TextureRect2/Button_pioche")
			button_pioche.texture_normal = pioche
			Globals.au_joueur1_de_jouer = not Globals.au_joueur1_de_jouer
			joueur_ia_cerveau()
	else:
		 
		if node2d_scene: # Accède au bouton pioche
			var button_pioche = node2d_scene.get_node("Area2D/TextureRect2/Button_pioche")
			button_pioche.texture_normal = croix
			jeton_ia_place_trouver = true

		
func joueur_ia_cerveau():
	print("joueurIa")
	var node2d_scene = get_tree().get_root().get_node("Node2D")
	node2d_scene.child_pioche_jetons()
	
	if Globals.list_affiche_position_porte_jetons_ia.size() > 0:
		
		for element in Globals.list_affiche_position_porte_jetons_ia.size():
			for index in Globals.position_de_chaque_carre_du_plateau.size():
				#yield(get_tree().create_timer(0.1), "timeout") # Attendre 1 seconde entre chaque position
				var visi_node_ia = Globals.list_affiche_position_porte_jetons_ia[element]
				var target_id = visi_node_ia.jeton_id  # Remplace par ton ID de nœud
				var node = Globals.find_node_by_instance_id(get_tree().root, target_id)
				if node:
					node.position = Vector2(Globals.position_de_chaque_carre_du_plateau[index])

					node.visible = true
					for tourne in range(0, 4):
						if jeton_ia_place_trouver:
							jeton_ia_place_trouver = false
							node.visible = false
							Globals.au_joueur1_de_jouer = not Globals.au_joueur1_de_jouer
							break
						else:
							tourn_ia()
							yield(get_tree().create_timer(0.005), "timeout") # Attendre 1 seconde entre chaque position
					

				node.visible = false
		Globals.au_joueur1_de_jouer = not Globals.au_joueur1_de_jouer
			
func tourn_ia():
	if Globals.list_affiche_position_porte_jetons_ia.size() >= 0:
		for element in Globals.list_affiche_position_porte_jetons_ia.size():
			var nouveau
			var target_id = Globals.list_affiche_position_porte_jetons_ia[element].jeton_id  # Remplace par ton ID de nœud
			var node = Globals.find_node_by_instance_id(get_tree().root, target_id)
			if node:
				node.rotation_degrees += 90
				var actuel =  sens.find(Globals.list_affiche_position_porte_jetons_ia[element].sens)
				if actuel < 3:
					nouveau = actuel + 1
				else:
					nouveau = 0
				Globals.list_affiche_position_porte_jetons_ia[element].sens = sens[0]
				#print(Globals.list_affiche_position_porte_jetons[0].sens)
				#print("tourn_n_child" + str(Globals.list_affiche_position_porte_jetons[0].jeton_id))
				#print("list " + str(Globals.list_affiche_position_porte_jetons))
			
	
	
func supprime_jeton_porte_jeton():
	for jtn in Globals.list_affiche_position_porte_jetons:
		var jeton:Jeton = jtn
		if int(Globals.id_child_node2d_jeton) == jeton.jeton_id:
			Globals.list_affiche_position_porte_jetons.erase(jeton)

func check_colision_h(autour: int, jeton1: int, jeton2: int) -> bool:
	var similaire = true
	var info = str(liste_colision_autour[autour]) + " < " +str(autour + 1) + "* > "
	#print(Globals.list_couleur_bouge_jeton)
	if liste_colision_autour[autour] == Globals.list_couleur_bouge_jeton[jeton1] or liste_colision_autour[autour] == str(joker):
		path_similaire += 1
		###print(info +  str(Globals.list_couleur_bouge_jeton[jeton1]))
			
	elif  Globals.list_couleur_bouge_jeton[jeton1]  == str(joker) and liste_colision_autour[autour] != str(blanc):
		path_similaire += 1
		###print(info + str(Globals.list_couleur_bouge_jeton[jeton1]))

	elif liste_colision_autour[autour] == str(blanc):
		#print(info + str(blanc))
		pass
	else:
		similaire = false
	return similaire

func check_colision_v(autour: int, jeton_index: int) -> bool:
	var similaire = true
	var info = str(liste_colision_autour[autour]) + " < " +str(autour + 1) + "* > "
	
	var is_colision_not_blanc = liste_colision_autour[autour] != str(blanc)
	var is_colision_blanc = liste_colision_autour[autour] == str(blanc)
	var is_colision_jeton_joker = liste_colision_autour[autour] == str(joker)
	var is_jeton_joker = Globals.list_couleur_bouge_jeton[jeton_index] == str(joker)
	var is_same_color_than_colision = liste_colision_autour[autour] == Globals.list_couleur_bouge_jeton[jeton_index]
	
	if (is_same_color_than_colision or is_colision_jeton_joker):
		path_similaire += 1
		###print(info +  str(Globals.list_couleur_bouge_jeton[jeton_index]))
	elif  is_jeton_joker and is_colision_not_blanc:
		path_similaire += 1
		###print(info + str(Globals.list_couleur_bouge_jeton[jeton_index]))
	elif is_colision_blanc:
		#print(info + str(blanc))
		pass
	else:
		similaire = false
	
	return similaire
