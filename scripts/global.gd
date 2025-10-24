extends Node

var facing_right = false
var facing_left = false
var facing_up = false
var facing_down = false

var game_world: GameWorld = null



func _ready() -> void:
	game_world = get_tree().current_scene
