extends AnimatedSprite

var frame_to_stop_at = 10

func _ready():
	
	self.play()
	
func _process(delta):
	if self.frame == frame_to_stop_at:
		self.stop()
		self.visible = false
		self.queue_free()
