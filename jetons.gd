extends Node2D

var screen_limits = Rect2(Vector2(0, 0), Vector2(1280, 720))  # Ajuste ces valeurs selon la taille de ta scène
var move_child = false
var jeton_blanc_3 = false
var list_couleur_bouge_jeton = []
var liste_colision_autour = []
var path_similaire = 0
var collision_count = 0
var collision_autour_count = 0
var area_autour
var suite = false

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
		if  node2d_plateau.get_child(0).texture == blanc :
			
			collision_count += 1
			if collision_count == 3:
			
				print("collision blanc " + str(collision_count))
				for a in Globals.list_affiche_position_porte_jetons:
			
					var jeton_number = node2d_jeton.name.split("@")[-1]
					if int(jeton_number) == a[5]:
			
						print("sens " + str(a[4]))
						if str(a[4]) == "horizontal-d" or str(a[4]) == "verticale-h":
			
							list_couleur_bouge_jeton.append(node2d_jeton.get_node("Area2D/jetons/Spritemilieu/Spritehaut").texture.get_path())
							list_couleur_bouge_jeton.append(node2d_jeton.get_node("Area2D/jetons/Spritemilieu").texture.get_path())
							list_couleur_bouge_jeton.append(node2d_jeton.get_node("Area2D/jetons/Spritemilieu/Spritebas").texture.get_path())
						else:
							list_couleur_bouge_jeton.append(node2d_jeton.get_node("Area2D/jetons/Spritemilieu/Spritebas").texture.get_path())
							list_couleur_bouge_jeton.append(node2d_jeton.get_node("Area2D/jetons/Spritemilieu").texture.get_path())
							list_couleur_bouge_jeton.append(node2d_jeton.get_node("Area2D/jetons/Spritemilieu/Spritehaut").texture.get_path())
				collision_count = 0
				jeton_blanc_3 = true


func _on_jetons_area_exited(area):
	
	list_couleur_bouge_jeton.clear()
	jeton_blanc_3 = false

func _on_verifieautour_area_entered(area_autour):
		
	if area_autour.is_in_group("plateau"):
		var node2d_jeton_autour = self  # Le `Node2D` du jeton
		var node2d_plateau = area_autour  # Le `Node2D` du plateau
		#print(node2d_jeton_autour.get_node("Area2D/verifieautour/Collisionhaut"))
		#print(node2d_plateau.get_child(0).texture.get_path())
		#print(node2d_jeton_autour.name)
		var test1 = node2d_jeton_autour.get_child(0)
		#print(test1.name)
		var test2 = test1.get_child(1)
		#print(test2.name)
		var test3 = test2.get_child(0)
		#print(test3.name)
		#print(Globals.list_affiche_position_porte_jetons)
		#for a in test2.get_children():
			#print(a.name)
			#-regarde ici transforme la variable en variable globale pour pouvoir la recuperer ici
			# et utilise a la maniere de chemin test pour recuperer le numero du node print(list_affiche_position_porte_jetons[0][4])
		#if child_node is TextureRect or child_node is Sprite:
		#if area_autour == node2d_jeton_autour.get_node("Area2D/verifieautour/Collisionhaut"):
		liste_colision_autour.append(node2d_plateau.get_child(0).texture.get_path())
		print("liste 8 collision autour " + str(liste_colision_autour))
		if len(liste_colision_autour) == 8:
			if jeton_blanc_3 :
				
				print("liste 8 collision autour " + str(liste_colision_autour))
				compare_autour()
	

func _on_verifieautour_area_exited(area_autour):
	path_similaire = 0
	liste_colision_autour.clear()
	
	
func compare_autour():
	print()
	print("valide jeton " + str(list_couleur_bouge_jeton))
	print("compare_autour")
	path_similaire = 0
	

	if liste_colision_autour[0] == list_couleur_bouge_jeton[0]:
		path_similaire += 1
		print(str(liste_colision_autour[0]) + " < 1* > " +  str(list_couleur_bouge_jeton[0]))
	if liste_colision_autour[1] == list_couleur_bouge_jeton[0]:
		path_similaire += 1
		print(str(liste_colision_autour[1]) + " < 2* > " +  str(list_couleur_bouge_jeton[0]))
	if liste_colision_autour[2] == list_couleur_bouge_jeton[0]:
		path_similaire += 1
		print(str(liste_colision_autour[2]) + " < 3* > " +  str(list_couleur_bouge_jeton[0]))
	if liste_colision_autour[3] == list_couleur_bouge_jeton[1]:
		path_similaire += 1
		print(str(liste_colision_autour[3]) + " < 4* > " +  str(list_couleur_bouge_jeton[1]))
	if liste_colision_autour[4] == list_couleur_bouge_jeton[1]:
		path_similaire += 1
		print(str(liste_colision_autour[4]) + " < 5* > " +  str(list_couleur_bouge_jeton[1]))
	if liste_colision_autour[5] == list_couleur_bouge_jeton[2]:
		path_similaire += 1
		print(str(liste_colision_autour[5]) + " < 6* > " +  str(list_couleur_bouge_jeton[2]))
	if liste_colision_autour[6] == list_couleur_bouge_jeton[2]:
		path_similaire += 1
		print(str(liste_colision_autour[6]) + " < 7* > " +  str(list_couleur_bouge_jeton[2]))
	if liste_colision_autour[7] == list_couleur_bouge_jeton[2]:
		path_similaire += 1
		print(str(liste_colision_autour[7]) + " < 8* > " + str(list_couleur_bouge_jeton[2]))
	
	if path_similaire > 1 :
	
		remplace_couleurs()
			
func remplace_couleurs():
		
		print(str(path_similaire) + " couleurs similaire")
		path_similaire = 0
