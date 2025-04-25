extends Area2D

@onready var background: ParallaxBackground = $"../Background"
@onready var sprite: Sprite2D = $Sprite2D
@onready var sprite_2d_2: Sprite2D = $Sprite2D2
@onready var collision_polygon_2d: CollisionPolygon2D = $CollisionPolygon2D
@onready var collision_polygon_2d_2: CollisionPolygon2D = $CollisionPolygon2D2

@export var SPEED: = 300.0
@onready var spawner: Node = $"../Spawner"

var game_over : bool = false
var width = 0

func _ready() -> void:
	width = 800.0*2

func _process(delta: float) -> void:
	if game_over:
		return
	for item in [sprite, sprite_2d_2, collision_polygon_2d, collision_polygon_2d_2]:
		item.position.x -= SPEED * delta
		if item.position.x <= -width:
			item.position.x = width
			
			
func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		game_over = true
		body.stop()
		background.stop()
		spawner.stop()
		
func stop():
	game_over = true
