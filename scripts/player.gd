extends CharacterBody2D
class_name Player


@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var area_2d: Area2D = $Area2D
@onready var sword: Weapon = %Weapon



@export var move_speed: float = 200.0
@export var maxHealth : int = 100
@export var health : int = maxHealth
@export var coins : int = 0
var knockback: Vector2 = Vector2(0,0)
var knockbackTween
var can_hit: bool = false
var weapon_damage: int = 1
var NPC

var facing: Vector2 = Vector2.ZERO


func _ready():
	print("Player is ready!")
	# TODO: Add detailed character info display (Lesson 1)

func _physics_process(delta):
	handle_movement()

func handle_movement():
	# Get input direction from arrow keys
	var direction = Vector2.ZERO
	direction.x = Input.get_axis("ui_left", "ui_right")
	direction.y = Input.get_axis("ui_up", "ui_down")
	handle_sprite(direction)
	
	# Normalize diagonal movement to prevent speed boost
	if direction.length() > 0:
		direction = direction.normalized()
	
	# Apply movement using Godot's built-in physics
	velocity = direction * move_speed + knockback
	move_and_slide()

# BAD QUICK CODE MAYBE CHANGE
func handle_sprite(direction: Vector2) -> void:
	var prefix: String = "walk"
	if direction == Vector2.ZERO:
		prefix = "idle"
	else:
		facing = direction
	
	if facing.y > 0:
		animated_sprite.play(prefix + "_forward")
		area_2d.position = Vector2(0,30)
		area_2d.rotation_degrees = 90
	elif facing.y < 0:
		animated_sprite.play(prefix + "_backward")
		area_2d.position = Vector2(0,-30)
		area_2d.rotation_degrees = 90
	elif facing.x < 0:
		animated_sprite.play(prefix + "_side")
		animated_sprite.flip_h = true
		area_2d.position = Vector2(-30,0)
		area_2d.rotation_degrees = 0
		Global.facing_left = true
		Global.facing_right = false
	elif facing.x > 0:
		animated_sprite.play(prefix + "_side")
		animated_sprite.flip_h = false
		area_2d.position = Vector2(30,0)
		area_2d.rotation_degrees = 0
		Global.facing_left = false
		Global.facing_right = true
func collect_pickup(_type : String, _amount : int):
	if _type == "coin":
		coins += _amount
		print("Coins: " + str(coins))
	elif _type == "health_potion":
		change_health(_amount)
		

# TODO: Add character methods here (Lesson 2)

# - level_up()
# - attack()

func change_health(_amount): 
	health += _amount
	if health > maxHealth:
		health = maxHealth
		
	elif health < 1:
		die()
		
	print("Health: " + str(health))

func die():
	print("You died!")
	queue_free()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit(0)
	if event.is_action_pressed("mouse_button_pressed"):
		Player_attack(NPC)
		
func hit(damage, knockback_strength: Vector2 = Vector2(0,0), stop_time : float = 0.25):
	health -= damage
	print("player took ", damage, " damage and now has ", health, " health")
	if health <= 0:
		die()
	elif knockback_strength != Vector2(0,0):
		knockback = knockback_strength
		
		knockbackTween = get_tree().create_tween()
		knockbackTween.parallel().tween_property( self , "knockback", Vector2(0,0), stop_time)

func _on_area_2d_body_entered(body: Node2D) -> void:
	can_hit = true
	NPC = body

func _on_area_2d_body_exited(body: Node2D) -> void:
	can_hit = false

func Player_attack(_NPC):
	weapon.showing = true
	if can_hit == true:
		if not _NPC is Player:
			_NPC.hit(weapon_damage)
			print(_NPC.health, _NPC)
