extends TextureRect


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func _on_TextureButton_pressed():
	var acceuil = find_node_recursive(get_tree().root, "acceuil")
	if acceuil:
		print("Le nœud 'acceuil' trouvé : ", acceuil.name)
		if acceuil is TextureRect:
			acceuil.visible = false

			print("Le TextureRect 'acceuil' est maintenant invisible.")
		else:
			print("Le nœud 'acceuil' trouvé n'est pas un TextureRect.")
	else:
		print("Le nœud 'acceuil' n'a pas été trouvé.")

func find_node_recursive(parent, name):
	if parent.name == name:
		return parent

	for child in parent.get_children():
		var result = find_node_recursive(child, name)
		if result != null:
			return result

	return null
