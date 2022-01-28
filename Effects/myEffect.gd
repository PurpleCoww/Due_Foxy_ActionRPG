extends AnimatedSprite

func _ready():
	# Connect the signal in code - persistent
	# Parameters: signal-to-connect-to, node-that–have-the-function, function-that-we-are-connecting-to
	connect("animation_finished", self, "_on_animation_finished")
	# frame = 0 # stop the sprite and start from 0
	play("Animate")

func _on_animation_finished():
	queue_free()
