extends Node2D

var screen_limits = Rect2(Vector2(0, 0), Vector2(1280, 720))  # Ajuste ces valeurs selon la taille de ta scène
var move_child = false
var boolarea = false

var collision_count = 0

var joker = preload("res://assets/colors/joker.jpg")
var jaune = preload("res://assets/colors/jaune.jpg")
var vert = preload("res://assets/colors/vert.jpg")
var bleu = preload("res://assets/colors/bleu.jpg")
var violet = preload("res://assets/colors/violet.jpg")
var rouge = preload("res://assets/colors/rouge.jpg")
var blanc = preload("res://assets/colors/carre-blanc.png")


func _ready():
	 connect("area_entered", self, "_on_jetons_area_entered")

	
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
		print("entrer")
		var node2d_jeton = self  # Le `Node2D` du jeton
		var node2d_plateau = area  # Le `Node2D` du plateau
		print("Collision entre : ", node2d_jeton, " et ", node2d_plateau)
		print(node2d_plateau.get_child(0))

		if  node2d_plateau.get_child(0).texture == blanc :
			collision_count += 1
			print("collision blanc " + str(collision_count))
			
			if collision_count == 3:
				print("collision blanc " + str(collision_count))
				verifie_autour()
	
func verifie_autour():
	pass



func _on_jetons_area_exited(area):
	collision_count = 0
	print("collision blanc " + str(collision_count))
		
