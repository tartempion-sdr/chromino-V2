extends Node2D

var screen_limits = Rect2(Vector2(0, 0), Vector2(1280, 720))  # Ajuste ces valeurs selon la taille de ta scène




func _ready():
	pass
	
	

func _on_TextureButton_pressed():
	var mouse_pos = get_viewport().get_mouse_position()
	var child_node = get_child(0)
	print("L'ID de l'enfant est : ", child_node)
	if child_node is Node2D:


		child_node.visible = true
		child_node.global_position = mouse_pos
		print(child_node.position)
		print(mouse_pos)
