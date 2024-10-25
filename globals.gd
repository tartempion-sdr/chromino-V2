extends Node

var taille = 1
var list_affiche_position_porte_jetons = []
var list_couleur_bouge_jeton = []
var au_joueur1_de_jouer:bool = true
var node_jeton_part2


var list_position_pioche_jetons = [(Vector2(150, 543)),
(Vector2(280, 543)),
(Vector2(410, 543)),
(Vector2(540, 543)),
(Vector2(670, 543)),
(Vector2(800, 543)),
(Vector2(930, 543)),
(Vector2(1060, 543))]

func affiche_jetons_piocher():
	print("list_affiche " + str(len(list_affiche_position_porte_jetons)))
	
	for element in list_affiche_position_porte_jetons:
		var target_id = element[5]  # Remplace par ton ID de nœud
		var node = find_node_by_instance_id(get_tree().root, target_id)
		
		if node:
			print("Nœud assigné à la variable : ", node.name)
			var index = list_affiche_position_porte_jetons.find(element)
			if index != -1 and index < 8:
				node.visible = true
				node.position = list_position_pioche_jetons[index]
			else:
				node.visible = false
				node.position = list_position_pioche_jetons[7]
			node.scale.x = taille
			node.scale.y = taille
		else:
			print("Aucun nœud trouvé avec l'ID spécifié : ", target_id)

func find_node_by_instance_id(node, target_id):
	if node.get_instance_id() == target_id:
		return node
	
	for child in node.get_children():
		var result = find_node_by_instance_id(child, target_id)
		if result:
			return result
	
	return null  # Retourne null si aucun nœud avec cet ID n'est trouvé
func rend_jeton_invisible():
	var root = get_tree().root
	var main_scene = root.get_child(1)  # Assurez-vous que c'est bien l'index de votre scène principale
	#print(main_scene.name)
	var child_jeton = main_scene.get_child(int(node_jeton_part2))
	if child_jeton is Node2D:
		#print(child_jeton.name)
		child_jeton.visible = false
		#print(child_jeton.visible)
	
