
extends TextureButton

func _ready():
	pass # Replace with function body.


func _on_jouez_pressed():
	print("Fermeture de la aide")
	var current_scene = get_tree().current_scene
	if current_scene.name == "aide":
		current_scene.queue_free()  # Ferme l'instance de la scène principale
	
	
