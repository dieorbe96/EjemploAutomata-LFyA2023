class_name EnemyWanderState
extends State

@export var actor: Enemy
@export var animator: AnimatedSprite2D
@export var vision_cast: RayCast2D
@export var coin_vision_area: Area2D

signal found_player
signal found_coin

func _ready():
	set_physics_process(false)


func _enter_state() -> void:
	set_physics_process(true)
	coin_vision_area.monitoring = true
	animator.play("move")
	if actor.velocity == Vector2.ZERO:
		actor.velocity = Vector2.RIGHT.rotated(randf_range(0,TAU)) * actor.max_speed


func _exit_state() -> void:
	set_physics_process(false)

func _physics_process(delta):
	animator.scale.x = -sign(actor.velocity.x)
	if animator.scale.x == 0.0:	animator.scale.x = 1.0
	var collision = actor.move_and_collide(actor.velocity * delta)
	if collision:
		var bounce_velocity = actor.velocity.bounce(collision.get_normal())
		actor.velocity = bounce_velocity
	
	if not vision_cast.is_colliding():
		found_player.emit()
	





func _on_vision_area_body_entered(body):
	if body is Coin:
		print("vi una moneda")
		actor.target = body
		found_coin.emit()
	pass # Replace with function body.
