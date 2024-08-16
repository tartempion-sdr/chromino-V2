extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var scene = load("res://Area2D.tscn")
var y = 30
var x = 30

# Called when the node enters the scene tree for the first time.
func _ready():
		test()
# warning-ignore:unused_variable
func test():
	
	for i in range(0, 19):
		for n in range(0, 19):

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

		
