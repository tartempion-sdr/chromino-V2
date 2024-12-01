extends Node2D

var screen_limits = Rect2(Vector2(0, 0), Vector2(1280, 720))  # Ajuste ces valeurs selon la taille de ta scène
var move_child = false

var list_pos_plateau_remplace_blanc = []

var stream_list_couleur_bouge_jeton = []
var path_similaire = 0

var collision_count = 0
var collision_autour_count = 0
var area_autour
var suite = false
var similaire = false

#var sens = ["verticale-h", "horizontale-d", "verticale-b", "horizontale-g"] 

var joker = "res://assets/colors/joker.jpg"
var jaune = "res://assets/colors/jaune.jpg"
var vert = "res://assets/colors/vert.jpg"
var bleu = "res://assets/colors/bleu.jpg"
var violet = "res://assets/colors/violet.jpg"
var rouge = "res://assets/colors/rouge.jpg"
var blanc = "res://assets/colors/carre-blanc.png"
var carre_blanc = preload("res://assets/colors/carre-blanc.png")
var etoile = preload("res://etoile.tscn")
var anim_victoire = preload("res://victoire_son_sprite.tscn")
var pioche = preload("res://assets/pioche.png")
var croix = preload("res://assets/icon/croix.png")
var motus = preload("res://assets/song/victoireia_motus.ogg")
var applaudisement = preload("res://assets/song//victoirej1_applaudi.ogg")
var win  = preload("res://assets/animesprite/win.jpg")
var lose  = preload("res://assets/animesprite/lose.jpg")

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

		if list_pos_plateau_remplace_blanc.size() == 3:
			#print("list pos plateau a verif" + str(list_pos_plateau_remplace_blanc))
			var tous_elements_sont_blancs = true
			for element in list_pos_plateau_remplace_blanc:
				#print(element.texture) 
				#print(carre_blanc)
				if element.texture != carre_blanc: 
					tous_elements_sont_blancs = false 
					break 
			if tous_elements_sont_blancs: # Code à exécuter si tous les éléments sont vrais (ont la texture carre_blanc) 
				Globals.jeton_blanc_3 = true
				#print("Tous les éléments sont blancs.") 
			else: # Code à exécuter si au moins un élément n'est pas vrai (n'a pas la texture carre_blanc) 
				Globals.jeton_blanc_3 = false
				#print("Au moins un élément n'est pas blanc.")
					#print(Globals.list_couleur_bouge_jeton)

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
		
					

func _on_jetons_area_exited(area):
	list_pos_plateau_remplace_blanc.clear()
	Globals.jeton_blanc_3 = false

func _on_verifieautour_area_entered(area_autour):
	if area_autour.is_in_group("plateau"):
		var node2d_plateau = area_autour  # Le `Node2D` du plateau
		Globals.liste_colision_autour.append(node2d_plateau.get_child(0).texture.get_path())
		if Globals.liste_colision_autour.size() == 8 && Globals.jeton_blanc_3:
			compare_autour()

func _on_verifieautour_area_exited(area_autour):
	path_similaire = 0
	Globals.path_blanc = 0
	Globals.liste_colision_autour.clear()
	similaire = true

func bouge_pion():
	var mouse_pos = get_viewport().get_mouse_position()
	var child_node = get_child(0)
	if child_node is Node2D:
		child_node.visible = true
		child_node.global_position = mouse_pos

func compare_autour():
	path_similaire = 0
	Globals.path_blanc = 0

	#print(liste_colision_autour)
	if Globals.au_joueur1_de_jouer:
		
		for jtn in Globals.list_affiche_position_porte_jetons:
			var jeton:Jeton = jtn
			if Globals.id_child_node2d_jeton == jeton.jeton_id:
				if jeton.is_vertical():
					check_colision_vertical()
					print("path_blanc = " + str(Globals.path_blanc))
				if jeton.is_horizontal():
					check_colision_horizontal()
					print("path_blanc = " + str(Globals.path_blanc))
	else:
		for jtn in Globals.list_affiche_position_porte_jetons_ia:
				var jeton:Jeton = jtn
				if Globals.id_child_node2d_jeton == jeton.jeton_id:
					if jeton.is_vertical():
						check_colision_vertical()
						print("path_blanc = " + str(Globals.path_blanc))
					if jeton.is_horizontal():
						check_colision_horizontal()
						print("path_blanc = " + str(Globals.path_blanc))

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
		#print("interdit")
		pass
		
	if path_similaire > 1 :
		if similaire:
			remplace_couleurs()
			
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
		#print(str(path_similaire) + " couleurs similaire")
		pass
	else:
		#print("interdit")
		pass
		
	if path_similaire > 1 :
		if similaire:
			remplace_couleurs()
			

func remplace_couleurs():
	print("hurra joueur1 !")

	

	if list_pos_plateau_remplace_blanc.size() >= 3 and Globals.list_couleur_bouge_jeton.size() >= 3:
		for a in range(0, 3):
			list_pos_plateau_remplace_blanc[a].texture = load(Globals.list_couleur_bouge_jeton[a])
			print(list_pos_plateau_remplace_blanc[a].get_parent().position)
			
			var instance_etoile = etoile.instance()
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
			if Globals.dedut_de_partie_nb_jetons_j1 == false and Globals.list_affiche_position_porte_jetons.size() == 0:
				Globals.victoir_pioche_nb_jeton_j1 = true
				Globals.nb_victoir_j1 += 1
				var instance_victoire = anim_victoire.instance()
				var child = instance_victoire.get_child(0)
				child.stream = applaudisement
				var child_sprit = child.get_child(0)
				child_sprit.texture = win
				add_child(instance_victoire)
				node2d_scene.child_pioche_jetons()
			else:
				Globals.victoir_pioche_nb_jeton_j1 = false
				
			Globals.au_joueur1_de_jouer = not Globals.au_joueur1_de_jouer
			var button_pioche = node2d_scene.get_node("Area2D/TextureRect2/Button_pioche")
			button_pioche.disabled = true
			Globals.affiche_jetons_piocher()
			node2d_scene.affiche_nb_jetons_restant()
			joueur_ia_cerveau()

	else:
		 

				
			var button_pioche = node2d_scene.get_node("Area2D/TextureRect2/Button_pioche")
			node2d_scene.affiche_nb_jetons_restant()
			button_pioche.disabled = false
			Globals.jeton_ia_place_trouver = true
			print("jeton_ia_place_trouver = " + str(Globals.jeton_ia_place_trouver))
			var jetons_ia = Globals.list_affiche_position_porte_jetons_ia 
			if jetons_ia.size() > 0: 
				jetons_ia = jetons_ia.slice(1, jetons_ia.size() - 1) 
				Globals.list_affiche_position_porte_jetons_ia = jetons_ia 
				print("Premier élément supprimé, nouvelle liste :", jetons_ia) 
			else: 
				print("L'Array est vide")
				

				
func joueur_ia_cerveau():
	#print("joueurIa")
	#test eco
	
	Globals.list_economie_is_horizontal_test_position_plateau.clear()
	Globals.list_economie_is_vertical_test_position_plateau.clear()
	var tour_deux_pour_liste_eco:int = 0
	
	var node2d_scene = get_tree().get_root().get_node("Node2D")
	if Globals.list_affiche_position_porte_jetons_ia.size() == 0:
		node2d_scene.child_pioche_jetons()
		
	if Globals.list_affiche_position_porte_jetons_ia.size() > 0 and Globals.jeton_ia_place_trouver == false:
		for element in Globals.list_affiche_position_porte_jetons_ia.size():
			Globals.index_pioche_ia = int(element + 1)
			node2d_scene.affiche_nb_jetons_restant()
			if len(Globals.list_affiche_position_porte_jetons_ia) > 1:
				var dernier_element = Globals.list_affiche_position_porte_jetons_ia.pop_back() # Supprime et retourne le dernier élément 
				Globals.list_affiche_position_porte_jetons_ia.insert(0, dernier_element) # Insère l'élément à la position 0 
			else: 
				print("La liste ne contient qu'un seul élément ou est vide.")
			for tourne in range(0, 4):
				var script_node2D = get_tree().root.get_node("Node2D")
				if script_node2D != null: 
					var result = script_node2D.call("tourne_jeton") 
					print("Resultat de tourne_jeton : " + str(result)) 
					tour_deux_pour_liste_eco += 1
					print("tour_deux_pour_liste_eco = " + str(tour_deux_pour_liste_eco))
					if tour_deux_pour_liste_eco < 3:
						Globals.alternance_pos_carre_blanc_plateau = Globals.position_de_chaque_carre_du_plateau
					else:
						if Globals.list_affiche_position_porte_jetons_ia.size() > 0:
							var jeton:Jeton = Globals.list_affiche_position_porte_jetons_ia[0]
							if jeton.is_vertical():
								Globals.alternance_pos_carre_blanc_plateau = Globals.list_economie_is_vertical_test_position_plateau
							if jeton.is_horizontal():
								Globals.alternance_pos_carre_blanc_plateau = Globals.list_economie_is_horizontal_test_position_plateau
				else: 
					print("Erreur : script_node2D est null")
					var tourne_ia = script_node2D.call("tourne_jeton") 
					tourne_ia
					
				#test_eco
				print("nb de cases = " + str(Globals.alternance_pos_carre_blanc_plateau.size()))
				
					
				for index in range(Globals.alternance_pos_carre_blanc_plateau.size()):
					if Globals.list_affiche_position_porte_jetons_ia.size() > 0:
						
						var visi_node_ia = Globals.list_affiche_position_porte_jetons_ia[0]
						var target_id = visi_node_ia.jeton_id  # Remplace par ton ID de nœud
						var node = Globals.find_node_by_instance_id(get_tree().root, target_id)
						
						if not Globals.jeton_ia_place_trouver:
							
							
							node.position = Vector2(Globals.alternance_pos_carre_blanc_plateau[index])
							var child_scale = node.get_child(0)
							child_scale.scale.x = Globals.taille
							child_scale.scale.y = Globals.taille
							node.visible = true
							yield(get_tree().create_timer(0.05), "timeout") # Attendre 1 seconde entre chaque position
								
							
							#test_eco
						
							if tour_deux_pour_liste_eco < 3 and Globals.jeton_blanc_3 and Globals.liste_colision_autour.size() == 8 and Globals.path_blanc < 8 :
							#and not Globals.alternance_pos_carre_blanc_plateau.has(node.position):
								print("path_blanc = " + str(Globals.path_blanc))  
								print("La variable n'est pas dans la liste.") 
								if Globals.list_affiche_position_porte_jetons_ia.size() > 0:
									var jeton:Jeton = Globals.list_affiche_position_porte_jetons_ia[0]
									if jeton.is_vertical():
										Globals.list_economie_is_vertical_test_position_plateau.append(Globals.position_de_chaque_carre_du_plateau[index])
									if jeton.is_horizontal():
										Globals.list_economie_is_horizontal_test_position_plateau.append(Globals.position_de_chaque_carre_du_plateau[index])
				
									print("eco list = " + str(Globals.list_economie_is_vertical_test_position_plateau.size()))
									print("eco list = " + str(Globals.list_economie_is_horizontal_test_position_plateau.size()))


							else:
								pass
								#print("tour_deux_pour_liste_eco > 2")
							

						else:
							Globals.index_pioche_ia = 0
							node2d_scene.affiche_nb_jetons_restant()
							node.visible = false
							print("case blanc dessous = " + str(Globals.jeton_blanc_3))
							break
						node.visible = false
			
				
		if Globals.jeton_ia_place_trouver == false:
			Globals.index_pioche_ia = 0
			node2d_scene.affiche_nb_jetons_restant()
			print("ia jeton non poser , jeton piocher")
			var button_pioche = node2d_scene.get_node("Area2D/TextureRect2/Button_pioche")
			button_pioche.disabled = false
			node2d_scene.child_pioche_jetons()
		else:
			if Globals.dedut_de_partie_nb_jetons_jia == false and Globals.list_affiche_position_porte_jetons_ia.size() == 0:
				Globals.victoir_pioche_nb_jeton_jia = true
				Globals.nb_victoir_jia += 1
				var instance_victoire = anim_victoire.instance()
				var child = instance_victoire.get_child(0)
				child.stream = motus
				var child_sprit = child.get_child(0)
				child_sprit.texture = lose
				add_child(instance_victoire)
				node2d_scene.child_pioche_jetons()
			else:
				Globals.victoir_pioche_nb_jeton_jia = false
			
		Globals.au_joueur1_de_jouer = not Globals.au_joueur1_de_jouer
		Globals.jeton_ia_place_trouver = false
		node2d_scene.affiche_nb_jetons_restant()
		
	
func supprime_jeton_porte_jeton():
	for jtn in Globals.list_affiche_position_porte_jetons:
		var jeton:Jeton = jtn
		if int(Globals.id_child_node2d_jeton) == jeton.jeton_id:
			Globals.list_affiche_position_porte_jetons.erase(jeton)

func check_colision_h(autour: int, jeton1: int, jeton2: int) -> bool:
	var similaire = true
	var info = str(Globals.liste_colision_autour[autour]) + " < " +str(autour + 1) + "* > "
	#print(Globals.list_couleur_bouge_jeton)
	if Globals.liste_colision_autour[autour] == Globals.list_couleur_bouge_jeton[jeton1] or Globals.liste_colision_autour[autour] == str(joker):
		path_similaire += 1
		###print(info +  str(Globals.list_couleur_bouge_jeton[jeton1]))
			
	elif  Globals.list_couleur_bouge_jeton[jeton1]  == str(joker) and Globals.liste_colision_autour[autour] != str(blanc):
		path_similaire += 1
		###print(info + str(Globals.list_couleur_bouge_jeton[jeton1]))

	elif Globals.liste_colision_autour[autour] == str(blanc):
		Globals.path_blanc += 1
		pass
	else:
		similaire = false
	return similaire

func check_colision_v(autour: int, jeton_index: int) -> bool:
	var similaire = true
	var info = str(Globals.liste_colision_autour[autour]) + " < " +str(autour + 1) + "* > "
	
	var is_colision_not_blanc = Globals.liste_colision_autour[autour] != str(blanc)
	var is_colision_blanc = Globals.liste_colision_autour[autour] == str(blanc)
	var is_colision_jeton_joker = Globals.liste_colision_autour[autour] == str(joker)
	var is_jeton_joker = Globals.list_couleur_bouge_jeton[jeton_index] == str(joker)
	var is_same_color_than_colision = Globals.liste_colision_autour[autour] == Globals.list_couleur_bouge_jeton[jeton_index]
	
	if (is_same_color_than_colision or is_colision_jeton_joker):
		path_similaire += 1
		###print(info +  str(Globals.list_couleur_bouge_jeton[jeton_index]))
	elif  is_jeton_joker and is_colision_not_blanc:
		path_similaire += 1
		###print(info + str(Globals.list_couleur_bouge_jeton[jeton_index]))
	elif is_colision_blanc:
		Globals.path_blanc += 1
	else:
		similaire = false
	
	return similaire
