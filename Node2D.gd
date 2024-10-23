extends Node2D

var randomNumberGenerator: RandomGenerator = RandomGenerator()
var jetonUseCases: JetonUseCases       = JetonUseCases()
var zoomUseCase: ZoomUseCase = ZoomUseCase()

var zoomRatio: int     = 1
var scene: PackedScene = preload("res://Plateau.tscn")
var x: int      = 0
var y: int           = 0
var num: int             = 2
var jeton_child: int     = 83

var list_couleurs_jetons: Array[Jeton] = jetonUseCases.list_couleurs_jetons
var list_position_pioche_jetons: Array[Vector2] = jetonUseCases.list_position_pioche_jetons



var randomInt

func _ready():
	pos_plateau()
	pioche_jetons()
	modifie_plateau(33, list_couleurs_jetons[randomInt].color1)
	modifie_plateau(42, list_couleurs_jetons[randomInt].color2)
	modifie_plateau(51, list_couleurs_jetons[randomInt].color3)
	print(Globals.list_affiche_position_porte_jetons)
	print(len(Globals.list_affiche_position_porte_jetons))
	var child_jeton: Node = get_child(Globals.list_affiche_position_porte_jetons[0][5])
	print(child_jeton.name)
	print(list_couleurs_jetons[randomInt])
	child_jeton.visible = false
	Globals.list_affiche_position_porte_jetons.remove_at(0)
	print(Globals.list_affiche_position_porte_jetons)
	affiche_nb_jetons_restant()

func modifie_plateau(numero, couleur):
	var child: Node = get_child(numero)
	if child is Area2D && child.get_child(0) is Sprite2D:
		child.get_child(0).texture = couleur

func plateau(pos):
	var instance_plateau: Node = scene.instantiate()
	instance_plateau.position = pos
	instance_plateau.visible = true
	add_child(instance_plateau)

func pos_plateau():

	var a: int      = 0
	var retour: int = 0

	for i in range(0, 9):
		for n in range(0, 9):

			plateau(Vector2(x, y))
			a = 20
			x += 20
			retour = retour + a
		x -= retour
		retour = 0
		y += 20
	x = 0
	y = 0

func pioche_jetons():
	randomInt = randomNumberGenerator.newInt()
	while !list_couleurs_jetons[randomInt].isChanged:
		randomInt = randomNumberGenerator.newInt()
	list_couleurs_jetons[randomInt].isChanged = false
	var instance_jeton: Node = jetonUseCases.scene_jeton.instantiate()

	instance_jeton.get_node("Area2D/jetons/Spritemilieu/Spritehaut").texture = list_couleurs_jetons[randomInt].color1
	instance_jeton.get_node("Area2D/jetons/Spritemilieu").texture = list_couleurs_jetons[randomInt].color2
	instance_jeton.get_node("Area2D/jetons/Spritemilieu/Spritebas").texture = list_couleurs_jetons[randomInt].color3
	print(list_couleurs_jetons[randomInt][0].get_path())

	list_couleurs_jetons[randomInt].jetonChild = jeton_child
	Globals.list_affiche_position_porte_jetons.insert(0, list_couleurs_jetons[randomInt])
	add_child(instance_jeton)

	print("jeton_child "+ str(jeton_child))
	jeton_child += 1

	print(instance_jeton.name)
	affiche_jetons_piocher()


func affiche_jetons_piocher():

	for f in len(Globals.list_affiche_position_porte_jetons):
		var child_jeton: Node = get_child(Globals.list_affiche_position_porte_jetons[f][5])
		if child_jeton is Node2D:

			if f < 8:
				child_jeton.visible = true
				child_jeton.position = list_position_pioche_jetons[f]

			else:
				child_jeton.visible = false
				child_jeton.position = list_position_pioche_jetons[7]
			child_jeton.scale.x = zoomRatio
			child_jeton.scale.y = zoomRatio

func affiche_nb_jetons_restant():

	var count: int = 0
	for jeton in list_couleurs_jetons:
		if jeton.jetonChild != null and jeton.isChanged == true:
			count += 1
	$TextureRect2/Button_pioche/RichTextLabel.text = "JETONS = %d" % count

func child_pioche_jetons():
	for d in jetonUseCases.nb_jetons_pioche:
		pioche_jetons()


		affiche_jetons_piocher()
		affiche_nb_jetons_restant()

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed :
		pass

	if zoomUseCase.changeOnMouseEvent(event):
		affiche_jetons_piocher()

	zoomUseCase.changeCoordonate(Input)


func _on_Button_pioche_button_down():

	child_pioche_jetons()


func _on_Button_droite_button_down():

	if len(Globals.list_affiche_position_porte_jetons) == 0:
		print("pioche dabore")
	elif len(Globals.list_affiche_position_porte_jetons) >= 0:
		print("droite")
		var last_element = Globals.list_affiche_position_porte_jetons.pop_back()
		Globals.list_affiche_position_porte_jetons.insert(0, last_element)
		affiche_jetons_piocher()

func _on_Button_gauche_button_down():

	if len(Globals.list_affiche_position_porte_jetons) == 0:
		print("pioche dabore")

	elif len(Globals.list_affiche_position_porte_jetons) >= 0:

		var prem_element = Globals.list_affiche_position_porte_jetons.pop_front()
		Globals.list_affiche_position_porte_jetons.append(prem_element)
		affiche_jetons_piocher()

func _on_Button_tourne_button_down():

	if len(Globals.list_affiche_position_porte_jetons) == 0:
		print("pioche dabore")

	elif len(Globals.list_affiche_position_porte_jetons) >= 0:
		var child_jeton: Node = get_child(Globals.list_affiche_position_porte_jetons[0].jetonChild)
		if child_jeton is Node2D:

			child_jeton.get_node("Area2D").rotation_degrees += 90

			var actuel: int     = Globals.list_affiche_position_porte_jetons[0].sens
			var nouveau: Sens.Values = Sens.getNext(actuel)

			Globals.list_affiche_position_porte_jetons[0].sens = nouveau
			print(Globals.list_affiche_position_porte_jetons[0].sens)
			print("tourn_n_child" + str(Globals.list_affiche_position_porte_jetons[0].jetonChild))
			print("list " + str(Globals.list_affiche_position_porte_jetons))
