extends Node2D
class_name weapon
@onready var player: Player = %Player
@export var weapon_label: String
func _ready() -> void:
	player.config_weapon(weapon_label)
	pass

func _physics_process(delta: float) -> void:
	position = player.position
	if Global.facing_right:
		rotation_degrees = 0
	if Global.facing_left:
		rotation_degrees = 180
	if Global.facing_up:
		rotation_degrees = 90
	if Global.facing_down:
		rotation_degrees = 270
	if player.show_weapon == true:
		show()
	elif player.show_weapon == false:
		hide()
