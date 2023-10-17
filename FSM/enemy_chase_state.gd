class_name EnemyChaseState
extends State

@export var actor: Enemy
@export var animator: AnimatedSprite2D
@export var vision_cast: RayCast2D
@export var coin_vision_area: Area2D

signal lost_player

func _ready():
	set_physics_process(false)
	

func _enter_state() -> void:
	set_physics_process(true)
	coin_vision_area.monitoring = false
	actor.target = null
	animator.play("move")
	
	

func _exit_state() -> void:
	set_physics_process(false)

func _physics_process(delta):
	animator.scale.x = -sign(actor.velocity.x)
	if animator.scale.x == 0.0:	animator.scale.x = 1.0
	var direction = Vector2.ZERO.direction_to(actor.get_local_mouse_position())
	actor.velocity = actor.velocity.move_toward(direction * actor.max_speed, actor.acceleration)
	actor.move_and_slide()
	if vision_cast.is_colliding():
		lost_player.emit()
