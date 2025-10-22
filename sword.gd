extends Node2D
class_name weapon
@onready var player: Player = %Player
var showing: bool = false
func _physics_process(delta: float) -> void:
	position = player.position 
	if Global.facing_right:
		rotation_degrees = 0
		pass
	if Global.facing_left:
		rotation_degrees = 180
		pass
	if showing == true:
		show()
	else:
		hide()
