extends npc
class_name merchant

@export var shop_open: bool = false
@export var buying: bool = false
@export var moving: bool = false
@export var buying_increase: int = 0.5
@export var resell_increase: int = 1.5
var menu_open: bool = false


func _ready() -> void:
	can_damage = false
	pass
	saD
func _physics_process(delta: float) -> void:
	if moving == true:
		super._physics_process(delta)

func _on_detection_radius_body_entered( Node2D) -> void:
	if body is Player:
		shop_open = true
	
func _on_detection_radius_body_exited(body: Node2D) -> void:
	if body is Player:
		shop_open = false
		if menu_open == true:
			menu_open = false

func _input(event: ) -> void:
	if event.is_action_pressed("Keyboard_E") and shop_open == true:
		shop()

func shop():
	menu_open = true	print(inventory)
	pass
