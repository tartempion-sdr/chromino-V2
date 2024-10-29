extends TextureButton

func _ready():
	pass # Replace with function body.




func _on_aide_pressed():
	var node = get_tree().current_scene
	node.visible = true
	print("Ouverture de la scène 'aide' par-dessus")
	var aide_scene = preload("res://aide.tscn")
	var aide_instance = aide_scene.instance()
	add_child(aide_instance)
	
