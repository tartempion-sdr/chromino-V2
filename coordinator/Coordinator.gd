class_name Coordinator extends Node



func nouvelle_partie(ecran_actuel:Node):
	# Ferme l'instance de la scène principale
	ecran_actuel.queue_free()  
	print("lancement nouvelle partie ")
	
	Globals.taille = 1
	Globals.list_affiche_position_porte_jetons = []
	Globals.list_affiche_position_porte_jetons_ia = []
	Globals.list_couleur_bouge_jeton = []
	Globals.au_joueur1_de_jouer = true
	Globals.id_child_node2d_jeton
	Globals.nb_jetons_pioche = 7
	Globals.position_de_chaque_carre_du_plateau = []
	Globals.nouveau
	Globals.jeton_ia_place_trouver = false

	Globals.dedut_de_partie_nb_jetons_j1 = true
	Globals.dedut_de_partie_nb_jetons_jia = true
	Globals.victoir_pioche_nb_jeton_j1 = false
	Globals.victoir_pioche_nb_jeton_jia = false
	Globals.normal_pioche_nb_jetons_j1 = false
	Globals.normal_pioche_nb_jetons_jia = false

	Globals.nb_victoir_j1 = 0
	Globals.nb_victoir_jia = 0
	Globals.alternance_pos_carre_blanc_plateau
	Globals.liste_colision_autour = []
	Globals.path_blanc = 0
	Globals.list_economie_is_horizontal_test_position_plateau = []
	Globals.list_economie_is_vertical_test_position_plateau = []
	Globals.index_pioche_ia = 0
	Globals.jeton_blanc_3 = false
	ecran_actuel.get_tree().change_scene(Ecran.jeu) 

func revenir_partie_existant(ecran_actuel:Node):
	ecran_actuel.queue_free()
	
func quitter_la_partie(ecran_actuel:Node):
	# Ferme l'instance de la scène principale
	ecran_actuel.queue_free()
	print("quitter partie ")
	ecran_actuel.get_tree().change_scene(Ecran.acceuil) 

func ouvrir_l_aide(ecran_actuel:Node):
	var aide_scene = load(Ecran.aide)
	var aide_instance = aide_scene.instance()
	ecran_actuel.get_tree().current_scene.add_child(aide_instance)



