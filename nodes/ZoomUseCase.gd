class_name ZoomUseCase extends Node

var zoomRatio: int = 1
var num: int       = 2

var x1: int            = 0
var y1: int            = 0

func calculeZoom():
	var retourx: int = 0
	var retoury: int = 0
	num = 2

	for n in range(9):

		for i in range(9):

			# Utiliser un index pour accéder à chaque enfant individuellement
			var child: Node = get_child(num)
			if child is Area2D:

				child.scale.x = zoomRatio
				child.scale.y = zoomRatio
				child.position = Vector2(x1, y1)
				x1 = x1  + (20 * zoomRatio)
				num += 1
				retourx = retourx + (20 * zoomRatio)
		x1 -= retourx
		retourx = 0
		y1 = y1  + (20 * zoomRatio)
		retoury = retoury  + (20*zoomRatio)
	y1 -= retoury
	print(zoomRatio)

func changeCoordonate(input: Input):
	match input :
		Input.is_key_pressed(KEY_LEFT):
			x1 -= 10
		Input.is_key_pressed(KEY_RIGHT):
			x1 += 10
		Input.is_key_pressed(KEY_UP):
			y1 -= 10
		Input.is_key_pressed(KEY_DOWN):
			y1 += 10
	calculeZoom()

func changeOnMouseEvent(event) -> bool:
	if !(event is InputEventMouseButton):
	    return false

	var toReturn: bool = false
	match (event as InputEventMouseButton).button_index :
		MOUSE_BUTTON_WHEEL_UP:
			if zoomRatio > 0.7 :
				print("ZOOM -")
				zoomRatio -= 0.1
				calculeZoom()
				toReturn = true
		MOUSE_BUTTON_WHEEL_DOWN:
			if zoomRatio < 1.8 :
		# Action pour le défilement vers le bas
				print("ZOOM +")
				zoomRatio += 0.1
				calculeZoom()
				toReturn = true
	return toReturn
