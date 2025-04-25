extends Node

@onready var timer: Timer = $Timer
@onready var mountains_group: Node = $"../MountainsGroup"
@onready var background: ParallaxBackground = $"../Background"
@onready var ground: Area2D = $"../Ground"
@onready var score: Label = $"../UI/Control/score"

@export var SPEED: = 300.0
const MOUNTAIN = preload("res://Scenes/mountain.tscn")
var is_game_over : = false

var score_text:= 0:
	set(val):
		score_text = val
		score.text = str(score_text)
		

	
func _on_timer_timeout() -> void:
	timer.wait_time = randf_range(1,1.752);
	spawn_mountain()

func _process(delta: float) -> void:
	if is_game_over: return
	for child in mountains_group.get_children():
		child.position.x -= SPEED * delta
	
func spawn_mountain():
	var mountain = MOUNTAIN.instantiate()
	mountain.position  = Vector2(833.0, randf_range(520, 600))
	mountain.connect("hit", stop)
	mountain.connect("score_up", score_up)
	mountains_group.add_child(mountain)

func stop():
	is_game_over = true
	background.stop()
	ground.stop()
	timer.stop()

func score_up():
	score_text+=1
