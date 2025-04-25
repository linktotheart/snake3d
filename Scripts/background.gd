extends ParallaxBackground

@export var SPEED := 1000.0

var game_over := false

func _process(delta: float) -> void:
	if game_over:
		return
	scroll_base_offset.x -= SPEED * delta

func stop():
	game_over = true
