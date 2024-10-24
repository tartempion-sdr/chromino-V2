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

var joker = preload("res://assets/colors/joker.jpg")
var jaune = preload("res://assets/colors/jaune.jpg")
var vert = preload("res://assets/colors/vert.jpg")
var bleu = preload("res://assets/colors/bleu.jpg")
var violet = preload("res://assets/colors/violet.jpg")
var rouge = preload("res://assets/colors/rouge.jpg")
var blanc = preload("res://assets/colors/carre-blanc.png")

func _ready():
	
	connect("area_entered", self, "_on_jetons_area_entered")
	connect("area_exited", self, "_on_jetons_area_exited")
	connect("area_entered", self, "_on_verifieautour_area_entered")
	connect("area_exited", self, "_on_verifieautour_area_exited")
	
func _physics_process(delta):
	if move_child:
		bouge_pion()

func bouge_pion():
	var mouse_pos = get_viewport().get_mouse_position()
	var child_node = get_child(0)
	if child_node is Node2D:

		child_node.visible = true
		child_node.global_position = mouse_pos

func _on_TextureButton_button_down():
	move_child = true 
	
func _on_TextureButton_button_up():
	move_child = false

func _on_jetons_area_entered(area):

	if area.is_in_group("plateau"):

		var node2d_jeton = self  # Le `Node2D` du jeton
		var node2d_plateau = area  # Le `Node2D` du plateau
		print(node2d_plateau.name)
		
		var node_jeton_part = node2d_jeton.name
		var node_plateau_part = node2d_plateau.name

		var node_plateau_part2 = node_plateau_part.split("@")[-1]
		Globals.node_jeton_part2 = node_jeton_part.split("@")[-1]

		list_pos_plateau_remplace_blanc.insert(0,node_plateau_part2)
		list_pos_plateau_remplace_blanc.sort()
		if  node2d_plateau.get_child(0).texture == blanc :
			
			collision_count += 1
			if collision_count == 3:
				
				
				print(list_pos_plateau_remplace_blanc)
				
				print("collision blanc " + str(collision_count))
				for a in Globals.list_affiche_position_porte_jetons:
			
					var jeton_number = node2d_jeton.name.split("@")[-1]
					var add_jeton = int(jeton_number) + 1
					if int(add_jeton) == a[5]:
						print("signal " + str(a[4]))
						print("n_child_list " + str(a[5]))
						print("jeton " + str(add_jeton))
						if str(a[4]) == "verticale-h" or str(a[4]) ==  "horizontale-g":
							Globals.list_couleur_bouge_jeton.clear()
							stream_list_couleur_bouge_jeton.clear()
							Globals.list_couleur_bouge_jeton.append(node2d_jeton.get_node("Area2D/jetons/Spritemilieu/Spritehaut").texture.get_path())
							stream_list_couleur_bouge_jeton.append(node2d_jeton.get_node("Area2D/jetons/Spritemilieu/Spritehaut").texture)
							Globals.list_couleur_bouge_jeton.append(node2d_jeton.get_node("Area2D/jetons/Spritemilieu").texture.get_path())
							stream_list_couleur_bouge_jeton.append(node2d_jeton.get_node("Area2D/jetons/Spritemilieu").texture)
							Globals.list_couleur_bouge_jeton.append(node2d_jeton.get_node("Area2D/jetons/Spritemilieu/Spritebas").texture.get_path())
							stream_list_couleur_bouge_jeton.append(node2d_jeton.get_node("Area2D/jetons/Spritemilieu/Spritebas").texture)
							
						if str(a[4]) == "verticale-b" or str(a[4]) ==  "horizontale-d":
							Globals.list_couleur_bouge_jeton.clear()
							stream_list_couleur_bouge_jeton.clear()
							Globals.list_couleur_bouge_jeton.append(node2d_jeton.get_node("Area2D/jetons/Spritemilieu/Spritebas").texture.get_path())
							stream_list_couleur_bouge_jeton.append(node2d_jeton.get_node("Area2D/jetons/Spritemilieu/Spritebas").texture)
							Globals.list_couleur_bouge_jeton.append(node2d_jeton.get_node("Area2D/jetons/Spritemilieu").texture.get_path())
							stream_list_couleur_bouge_jeton.append(node2d_jeton.get_node("Area2D/jetons/Spritemilieu").texture)
							Globals.list_couleur_bouge_jeton.append(node2d_jeton.get_node("Area2D/jetons/Spritemilieu/Spritehaut").texture.get_path())
							stream_list_couleur_bouge_jeton.append(node2d_jeton.get_node("Area2D/jetons/Spritemilieu/Spritehaut").texture)
							
				print(Globals.list_couleur_bouge_jeton)
				#print(Globals.list_affiche_position_porte_jetons)
				collision_count = 0
				jeton_blanc_3 = true


func _on_jetons_area_exited(area):
	
	list_pos_plateau_remplace_blanc.clear()
	jeton_blanc_3 = false

func _on_verifieautour_area_entered(area_autour):
		
	if area_autour.is_in_group("plateau"):
		var node2d_jeton_autour = self  # Le `Node2D` du jeton
		var node2d_plateau = area_autour  # Le `Node2D` du plateau
		liste_colision_autour.append(node2d_plateau.get_child(0).texture.get_path())
		if len(liste_colision_autour) == 8:
			if jeton_blanc_3 :
				
				compare_autour()
	

func _on_verifieautour_area_exited(area_autour):
	path_similaire = 0
	liste_colision_autour.clear()
	similaire = true
	
func compare_autour():
	var similaire = true
	path_similaire = 0
	print(Globals.list_couleur_bouge_jeton)
	if liste_colision_autour[0] == Globals.list_couleur_bouge_jeton[0]:
		path_similaire += 1
		print(str(liste_colision_autour[0]) + " < 1* > " +  str(Globals.list_couleur_bouge_jeton[0]))
		
	elif liste_colision_autour[0] == str(blanc):
		print(str(liste_colision_autour[0]) + " < 1* > " + str(blanc))
	
	elif  liste_colision_autour[0] == str(joker):
		path_similaire += 1
		print(str(liste_colision_autour[0]) + " < 1* > " + str(Globals.list_couleur_bouge_jeton[0]))
	
	else:
		similaire = false
		
	if liste_colision_autour[1] == Globals.list_couleur_bouge_jeton[0]:
		path_similaire += 1
		print(str(liste_colision_autour[1]) + " < 2* > " +  str(Globals.list_couleur_bouge_jeton[0]))
	
	elif liste_colision_autour[1] == str(blanc):
		print(str(liste_colision_autour[1]) + " < 2* > " + str(blanc))
	
	elif  liste_colision_autour[1] == str(joker):
		path_similaire += 1
		print(str(liste_colision_autour[1]) + " < 2* > " + str(Globals.list_couleur_bouge_jeton[0]))
	
	else:
		similaire = false
	
	if liste_colision_autour[2] == Globals.list_couleur_bouge_jeton[0]:
		path_similaire += 1
		print(str(liste_colision_autour[2]) + " < 3* > " +  str(Globals.list_couleur_bouge_jeton[0]))
	
	elif liste_colision_autour[2] == str(blanc):
		print(str(liste_colision_autour[2]) + " < 3* > " + str(blanc))

	elif  liste_colision_autour[2] == str(joker):
		path_similaire += 1
		print(str(liste_colision_autour[2]) + " < 3* > " + str(Globals.list_couleur_bouge_jeton[0]))

	else:
		similaire = false
	
	if liste_colision_autour[3] == Globals.list_couleur_bouge_jeton[1]:
		path_similaire += 1
		print(str(liste_colision_autour[3]) + " < 4* > " +  str(Globals.list_couleur_bouge_jeton[1]))
	
	elif liste_colision_autour[3] == str(blanc):
		print(str(liste_colision_autour[3]) + " < 4* > " + str(blanc))
	
	elif  liste_colision_autour[3] == str(joker):
		path_similaire += 1
		print(str(liste_colision_autour[3]) + " < 4* > " + str(Globals.list_couleur_bouge_jeton[1]))
	
	else:
		similaire = false
	
	if liste_colision_autour[4] == Globals.list_couleur_bouge_jeton[1]:
		path_similaire += 1
		print(str(liste_colision_autour[4]) + " < 5* > " +  str(Globals.list_couleur_bouge_jeton[1]))
	
	elif liste_colision_autour[4] == str(blanc):
		print(str(liste_colision_autour[4]) + " < 5* > " + str(blanc))
	
	elif  liste_colision_autour[4] == str(joker):
		path_similaire += 1
		print(str(liste_colision_autour[4]) + " < 5* > " + str(Globals.list_couleur_bouge_jeton[1]))
	
	else:
		similaire = false
	
	if liste_colision_autour[5] == Globals.list_couleur_bouge_jeton[2]:
		path_similaire += 1
		print(str(liste_colision_autour[5]) + " < 6* > " +  str(Globals.list_couleur_bouge_jeton[2]))
	
	elif liste_colision_autour[5] == str(blanc):
		print(str(liste_colision_autour[5]) + " < 6* > " + str(blanc))
	
	elif  liste_colision_autour[5] == str(joker):
		path_similaire += 1
		print(str(liste_colision_autour[5]) + " < 6* > " + str(Globals.list_couleur_bouge_jeton[2]))
	
	else:
		similaire = false
	
	if liste_colision_autour[6] == Globals.list_couleur_bouge_jeton[2]:
		path_similaire += 1
		print(str(liste_colision_autour[6]) + " < 7* > " +  str(Globals.list_couleur_bouge_jeton[2]))
	
	elif liste_colision_autour[6] == str(blanc):
		print(str(liste_colision_autour[6]) + " < 7* > " + str(blanc))
	
	elif  liste_colision_autour[6] == str(joker):
		path_similaire += 1
		print(str(liste_colision_autour[6]) + " < 7* > " + str(Globals.list_couleur_bouge_jeton[2]))
	
	else:
		similaire = false
	
	if liste_colision_autour[7] == Globals.list_couleur_bouge_jeton[2]:
		path_similaire += 1
		print(str(liste_colision_autour[7]) + " < 8* > " + str(Globals.list_couleur_bouge_jeton[2]))
	
	elif liste_colision_autour[7] == str(blanc):
		print(str(liste_colision_autour[7]) + " < 8* > " + str(blanc))
		
	elif  liste_colision_autour[7] == str(joker):
		path_similaire += 1
		print(str(liste_colision_autour[7]) + " < 8* > " + str(Globals.list_couleur_bouge_jeton[2]))
	
	else:
		similaire = false
	
	if similaire :
			print(str(path_similaire) + " couleurs similaire")
			
	else:
		print("interdit")
	
	if path_similaire > 1 :
	
		remplace_couleurs()
		path_similaire = 0
		
		
		
func remplace_couleurs():
	var childc
	print("hurra joueur1 !")
	print(list_pos_plateau_remplace_blanc)
	
	
	for a in range(0, 3):
		print(a)
		var found_node = find_node_by_number(get_tree().root, list_pos_plateau_remplace_blanc[a])
		if found_node and found_node.has_node("Sprite"):
			var sprite_node = found_node.get_node("Sprite")
			if sprite_node is Sprite:
				
				sprite_node.texture = load(Globals.list_couleur_bouge_jeton[a])
				
				print("Couleur du Sprite modifiée ")
			else:
				print("Le nœud 'Sprite' n'est pas un Sprite.")
		else:
			print("Nœud 'Sprite' non trouvé ou nœud avec le numéro 43 non trouvé.")
	Globals.au_joueur1_de_jouer = false
	supprime_jeton_porte_jeton()
	#affiche_jeton_pioche()
	#rend_jeton_invisible()
	Globals.au_joueur1_de_jouer = false
	
func find_node_by_number(node, target_number):
	# Vérifie si le nom du nœud contient le numéro cible
	var name_parts = node.name.split("@")
	if name_parts.size() > 1 and name_parts[-1] == target_number:
		return node
	
	for child in node.get_children():
		var result = find_node_by_number(child, target_number)
		if result != null:
			return result
	
	return null  # Retourne null si aucun nœud avec ce numéro n'est trouvé

func supprime_jeton_porte_jeton():
	print("jeton selectioner " + str(Globals.node_jeton_part2))
	print("longeur list " + str(len(Globals.list_affiche_position_porte_jetons)))
	#print(Globals.list_affiche_position_porte_jetons)

	
	for a in Globals.list_affiche_position_porte_jetons:
		if int(Globals.node_jeton_part2) == a[5]:
			Globals.list_affiche_position_porte_jetons.erase(a)
			print("longeur list apres suppr " + str(len(Globals.list_affiche_position_porte_jetons)))
			#print(Globals.list_affiche_position_porte_jetons)
