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
		
		var child_node2d_jeton = node2d_jeton.get_child(0)
		Globals.id_child_node2d_jeton =  child_node2d_jeton .get_instance_id()
		
		var child_node2d_plateau = node2d_plateau.get_child(0)
		
		list_pos_plateau_remplace_blanc.insert(0,child_node2d_plateau)
		list_pos_plateau_remplace_blanc.sort()
		if  child_node2d_plateau.texture == blanc :
			
			collision_count += 1
			if collision_count == 3:
					
					
				print("dessousjeton " + str(list_pos_plateau_remplace_blanc))
					
					#print("collision blanc " + str(collision_count))
				for a in Globals.list_affiche_position_porte_jetons:
					
					if Globals.id_child_node2d_jeton == a[5]:
						
						if str(a[4]) == "verticale-h" or str(a[4]) ==  "horizontale-g":
							Globals.list_couleur_bouge_jeton.clear()
							Globals.list_couleur_bouge_jeton.append(node2d_jeton.get_node("Area2D/jetons/Spritemilieu/Spritehaut").texture.get_path())
							Globals.list_couleur_bouge_jeton.append(node2d_jeton.get_node("Area2D/jetons/Spritemilieu").texture.get_path())
							Globals.list_couleur_bouge_jeton.append(node2d_jeton.get_node("Area2D/jetons/Spritemilieu/Spritebas").texture.get_path())
							
						if str(a[4]) == "verticale-b" or str(a[4]) ==  "horizontale-d":
							Globals.list_couleur_bouge_jeton.clear()
							Globals.list_couleur_bouge_jeton.append(node2d_jeton.get_node("Area2D/jetons/Spritemilieu/Spritebas").texture.get_path())
							Globals.list_couleur_bouge_jeton.append(node2d_jeton.get_node("Area2D/jetons/Spritemilieu").texture.get_path())
							Globals.list_couleur_bouge_jeton.append(node2d_jeton.get_node("Area2D/jetons/Spritemilieu/Spritehaut").texture.get_path())

							
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
		
		#print(node2d_plateau.get_child(0).texture.get_path())
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
	#print(Globals.list_couleur_bouge_jeton)
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
	#print(list_pos_plateau_remplace_blanc)
	
	
	for a in range(0, 3):
		print(a)
		print(list_pos_plateau_remplace_blanc[a].texture)
		list_pos_plateau_remplace_blanc[a].texture = load(Globals.list_couleur_bouge_jeton[a])
				
	Globals.au_joueur1_de_jouer = false

	Globals.rend_jeton_invisible()
	supprime_jeton_porte_jeton()
	Globals.affiche_jetons_piocher()
	
	
func supprime_jeton_porte_jeton():
	print("jeton selectioner " + str(Globals.id_child_node2d_jeton))
	print("longeur list " + str(len(Globals.list_affiche_position_porte_jetons)))
	#print(Globals.list_affiche_position_porte_jetons)

	
	for a in Globals.list_affiche_position_porte_jetons:
		if int(Globals.id_child_node2d_jeton) == a[5]:
			
			Globals.list_affiche_position_porte_jetons.erase(a)
			print("longeur list apres suppr " + str(len(Globals.list_affiche_position_porte_jetons)))
			#print(Globals.list_affiche_position_porte_jetons)

