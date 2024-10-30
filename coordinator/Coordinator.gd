class_name Coordinator extends Node



func nouvelle_partie(ecran_actuel:Node):
	# Ferme l'instance de la scène principale
	ecran_actuel.queue_free()  
	print("lancement nouvelle partie ")
	ecran_actuel.get_tree().change_scene(Ecran.jeu) 

func revenir_partie_existant(ecran_actuel:Node):
	# Ferme l'instance de la scène principale
	ecran_actuel.get_tree().change_scene(Ecran.jeu) 
	print("revenir a la partie ")
	
func quitter_la_partie(ecran_actuel:Node):
	# Ferme l'instance de la scène principale
	ecran_actuel.queue_free()
	print("quitter partie ")
	ecran_actuel.get_tree().change_scene(Ecran.acceuil) 

func ouvrir_l_aide(ecran_actuel:Node):
	var aide_scene = load(Ecran.aide)
	var aide_instance = aide_scene.instance()
	ecran_actuel.get_tree().current_scene.add_child(aide_instance)

func fermer_l_aide(ecran_actuel:Node):
	ecran_actuel.queue_free()

func rend_invisible_la_scene(ecran_actuel:Node):
	ecran_actuel.get_tree().current_scene.visible = false
	
func rend_visible_la_scene(ecran_actuel:Node):
	ecran_actuel.get_tree().current_scene.visible = true
	
