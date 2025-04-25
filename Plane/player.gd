extends CharacterBody2D
class_name Player

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var timer: Timer = $"../Spawner/Timer"

@export var SPEED : float = 10.0
@export var JUMP : float = -450.0
@export var GRAVITY : float = 900.0
@export var MAX_ROTATE : float = 0.35 
var MIN_ROTATE : float = -0.45
# variables
var is_jumping : bool = false
var max_speed : float = 400
var is_game_over : bool = false
var is_game_started: bool = false
var rotation_smoothing : float = 0.1

func _physics_process(delta: float) -> void:
	if is_game_over:
		return
	
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().quit()
	
	if Input.is_action_just_pressed("jump"):
		if not is_game_started:
			is_game_started = true
			timer.start()
		velocity.y = JUMP
	
	if not is_game_started:
		return
		
	velocity.y += GRAVITY * delta
	velocity.y = min(velocity.y, max_speed)

	var target_rotation = clamp(velocity.y / 400.0, MIN_ROTATE, MAX_ROTATE)
	rotation = lerp(rotation, target_rotation, rotation_smoothing)
	move_and_slide()
	
func stop():
	is_game_over = true
	animated_sprite_2d.play("dead")
	timer.stop()
