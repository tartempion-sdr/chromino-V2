extends TextureButton


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_acceuil_pressed():
	print("Fermeture de la scène Node2D jeu")
	self.queue_free()  # Ferme l'instance de la scène principale
	# Option 1 : Charger une autre scène
	get_tree().change_scene("res://acceuil.tscn")
