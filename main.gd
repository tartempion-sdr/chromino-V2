extends Node

func _ready():
	var acceuil_scene = preload("res://acceuil.tscn")
	var acceuil_instance = acceuil_scene.instance()
	add_child(acceuil_instance)
	print("Scène d'accueil initialisée")
	

# Assurons-nous que le bouton 'jouez' est correctement trouvé
	if acceuil_instance.has_node("jouez"):
		var button = acceuil_instance.get_node("jouez")
		print("Bouton trouvé : ", button.name)
		button.connect("pressed", self, "_on_button_pressed")
	else:
		print("Le bouton 'jouez' n'a pas été trouvé dans 'acceuil'. Assure-toi que le nom est correct et qu'il est un enfant direct de 'acceuil'.")




