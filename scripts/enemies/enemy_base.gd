extends npc
class_name enemy

@onready var sprite: Sprite2D = $Sprite2D


@export var move_speed: float = 5




func _ready() -> void:
	#player = Global.game_world.player
	pass


func _process(delta: float) -> void:
	pass
	# MOVE TWOARD PLAYER
func _on_detection_radius_body_entered(body: Node2D) -> void:
	if body is Player:
		is_hostile=true
	
func _on_detection_radius_body_exited(body: Node2D) -> void:
	if body is Player:
		is_hostile=false
