extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var scene = load("res://Area2D.tscn")
var y = 40
var x = 40

# Called when the node enters the scene tree for the first time.
func _ready():
		test(x, y)
# warning-ignore:unused_variable
func test(x, y):
	
	for i in range(0, 79):
		for n in range(0, 79):

			x = x + 20
			var instance_plateau = scene.instance()
			instance_plateau.position = Vector2(x , y)
			add_child(instance_plateau)
		x = 20
		y = y + 20
	 # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

		
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_WHEEL_UP:
			# Action pour le défilement vers le haut
			print("Défilement vers le haut")
		elif event.button_index == BUTTON_WHEEL_DOWN:
			# Action pour le défilement vers le bas
			print("Défilement vers le bas")
