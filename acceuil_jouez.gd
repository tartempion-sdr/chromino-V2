extends TextureButton

func _ready():
	pass # Replace with function body.


func _on_jouez_pressed():
	print("Fermeture de la scène acceuil")
	Coordinator.new().nouvelle_partie(self)
