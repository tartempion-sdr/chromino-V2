extends TextureButton


func _on_jouez_pressed():
	Coordinator.new().fermer_l_aide(get_parent())
	
