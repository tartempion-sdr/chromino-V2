extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var scene = load("res://Area2D.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
		test()
# warning-ignore:unused_variable
func test():
	for n in range(0, 19):
		
		
		var instance_plateau = scene.instance()
		add_child(instance_plateau)

	 # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

		
