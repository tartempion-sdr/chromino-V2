extends Node

var taille = 1
var list_affiche_position_porte_jetons = []
var list_affiche_position_porte_jetons_ia = []
var list_couleur_bouge_jeton = []
var au_joueur1_de_jouer:bool = true
var id_child_node2d_jeton
var nb_jetons_pioche = 7
var position_de_chaque_carre_du_plateau = []

var list_position_pioche_jetons = [(Vector2(280, 543)),
(Vector2(391, 543)),
(Vector2(502, 543)),
(Vector2(613, 543)),
(Vector2(724, 543)),
(Vector2(835, 543)),
(Vector2(946, 543)),
(Vector2(1060, 543))]

func affiche_jetons_piocher():

	for element in list_affiche_position_porte_jetons_ia:
		var target_id = element.jeton_id  # Remplace par ton ID de nœud
		var node = find_node_by_instance_id(get_tree().root, target_id)
		
		if node:
			
			var index = list_affiche_position_porte_jetons_ia.find(element)
			node.visible = false
				
	for element in list_affiche_position_porte_jetons:
		var target_id = element.jeton_id  # Remplace par ton ID de nœud
		var node = find_node_by_instance_id(get_tree().root, target_id)
		
		if node:

			var index = list_affiche_position_porte_jetons.find(element)
			if index != -1 and index < 7:
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
	var node = find_node_by_instance_id(get_tree().root, id_child_node2d_jeton)
	#var child_jeton = main_scene.get_child(int(node_jeton_part2))
	#if child_jeton is Node2D:
		#print(child_jeton.name)
	node.visible = false
		#print(child_jeton.visible)
	
