extends TextureButton


func _on_jouez_pressed():
	Coordinator.new().revenir_partie_existant(get_parent())
	
