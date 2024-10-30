extends TextureButton

func _ready():
	pass # Replace with function body.




func _on_aide_pressed():
	#Coordinator.new().rend_invisible_la_scene(self)
	Coordinator.new().ouvrir_l_aide(self)
