extends Node2D

@onready var top_sprite_2d: Sprite2D = $top/Sprite2D
@onready var bottom_sprite_2d: Sprite2D = $bottom/Sprite2D
@onready var top: Area2D = $top
@onready var bottom: Area2D = $bottom
@onready var SPEED: float = 300.0
@onready var player: Player = %Player
@onready var score_sound: AudioStreamPlayer2D = $score_sound

const ROCK = preload("res://Mountain/rock.png")
const ROCK_DOWN = preload("res://Mountain/rockDown.png")
const ROCK_GRASS = preload("res://Mountain/rockGrass.png")
const ROCK_GRASS_DOWN = preload("res://Mountain/rockGrassDown.png")

signal hit
signal score_up

const MOUNTAIN_TEXTURES = {
	"ROCK": {
		"up": ROCK_DOWN,
		"down": ROCK
	},
	"ROCK_GRASS": {
		"up": ROCK_GRASS_DOWN,
		"down": ROCK_GRASS
	}
}
func _ready() -> void:
	var type = ['ROCK', 'ROCK_GRASS'].pick_random()
	top_sprite_2d.texture = MOUNTAIN_TEXTURES[type]["up"]
	bottom_sprite_2d.texture = MOUNTAIN_TEXTURES[type]["down"]
	top.position.y = -randf_range(360, 380)
	bottom.position.y = randf_range(280, 350)


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		body.stop()
		hit.emit()


func _on_score_hit_body_entered(body: Node2D) -> void:
	if body is Player:
		score_up.emit()
		score_sound.pitch_scale = randf_range(.75,1.25)
		score_sound.play()
