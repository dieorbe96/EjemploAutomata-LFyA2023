class_name EnemyCollectState
extends State

@export var actor: Enemy
@export var animator: AnimatedSprite2D
@export var mouse_cast: RayCast2D
@export var nav_agent: NavigationAgent2D
@export var vision_area: Area2D


signal collected_coin
signal found_player

func _ready():
	set_physics_process(false)


func _enter_state() -> void:

	nav_agent.target_position = actor.target.global_position
	set_physics_process(true)
	animator.play("move")

func _physics_process(delta):
	vision_area.monitoring = false
	#var target_pos = actor.target.global_position
	var actor_pos = actor.global_position
	var next_path_pos = nav_agent.get_next_path_position()
	var direction = (next_path_pos-actor_pos).normalized()
	
	actor.velocity = direction * actor.max_speed
	actor.move_and_slide()
	if not mouse_cast.is_colliding():
		found_player.emit()



func _exit_state() -> void:
	set_physics_process(false)


func _on_pickup_area_body_entered(body):
	body.queue_free()
	collected_coin.emit()
	vision_area.monitoring = true
	actor.target = null
	pass # Replace with function body.
