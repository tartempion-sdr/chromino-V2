class_name Coordinator extends Node



func nouvelle_partie(ecran_actuel:Node):
	# Ferme l'instance de la scène principale
	ecran_actuel.queue_free()  
	print("lancement nouvelle partie ")
	ecran_actuel.get_tree().change_scene(Ecran.jeu) 

func revenir_partie_existant(ecran_actuel:Node):
	# Ferme l'instance de la scène principale
	ecran_actuel.queue_free()  
	print("revenir a la partie ")
	
func quitter_la_partie(ecran_actuel:Node):
	# Ferme l'instance de la scène principale
	ecran_actuel.queue_free()
	print("quitter partie ")
	ecran_actuel.get_tree().change_scene(Ecran.acceuil) 

	
func afficher_l_aide(ecran_actuel:Node):
	pass
