extends Node2D

var screen_limits = Rect2(Vector2(0, 0), Vector2(1280, 720))  # Ajuste ces valeurs selon la taille de ta scène
var move_child = false
var boolarea = false
var list_collision_dessous_jeton = []
var liste_colision_autour = []
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
	connect("area_entered", self, "_on_verifieautour_area_entered")
	pass
	
func _physics_process(delta):
	if move_child:
		bouge_pion()


	

func bouge_pion():
	var mouse_pos = get_viewport().get_mouse_position()
	var child_node = get_child(0)
	#print("L'ID de l'enfant est : ", child_node)
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
		#print("Collision entre : ", node2d_jeton, " et ", node2d_plateau)
		list_collision_dessous_jeton.append(node2d_plateau.get_child(0).texture.get_path())
		
		if  node2d_plateau.get_child(0).texture == blanc :
			collision_count += 1

			
			if collision_count == 3:
				print("collision blanc " + str(collision_count))
				print("valide jeton " + str(list_collision_dessous_jeton))

func _on_jetons_area_exited(area):
	collision_count = 0
	print("collision blanc " + str(collision_count))
	list_collision_dessous_jeton.clear()


func _on_verifieautour_area_entered(area_autour):
		
	if area_autour.is_in_group("plateau"):
		var node2d_jeton_autour = self  # Le `Node2D` du jeton
		var node2d_plateau = area_autour  # Le `Node2D` du plateau
		print("couleurs " + str(node2d_plateau.get_child(0).texture.get_path()))
		liste_colision_autour.append(node2d_plateau.get_child(0).texture.get_path())
		
		if len(liste_colision_autour) == 8:
			print(liste_colision_autour)
			compare_autour()
			

func _on_verifieautour_area_exited(area_autour):
	collision_autour_count = 0
	#print("3collision autour " + str(collision_autour_count))
	liste_colision_autour.clear()

func compare_autour():
	print("valide jeton " + str(list_collision_dessous_jeton))
	print("compare_autour")
	#for a in liste_colision_autour:
		#if a ==
