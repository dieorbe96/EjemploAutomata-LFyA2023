class_name Enemy
extends CharacterBody2D

@onready var fsm = $FiniteStateMachine as FiniteStateMachine
@onready var enemy_wander_state = $FiniteStateMachine/EnemyWanderState as EnemyWanderState
@onready var enemy_chase_state = $FiniteStateMachine/EnemyChaseState as EnemyChaseState
@onready var enemy_collect_state = $FiniteStateMachine/EnemyCollectState as EnemyCollectState
@onready var navigation_agent_2d = $NavigationAgent2D

@export var max_speed = 40
@export var acceleration = 50
@export var rotation_speed = 90
@onready var mouse_cast = $MouseCast

var target: Coin


func _ready():
	# Seteo de Nav_agent
	navigation_agent_2d.path_desired_distance = 4.0
	navigation_agent_2d.target_desired_distance = 4.0
	
	enemy_wander_state.found_player.connect(fsm.change_state.bind(enemy_chase_state))
	enemy_wander_state.found_coin.connect(fsm.change_state.bind(enemy_collect_state))
	enemy_chase_state.lost_player.connect(fsm.change_state.bind(enemy_wander_state))
	enemy_collect_state.collected_coin.connect(fsm.change_state.bind(enemy_wander_state))
	enemy_collect_state.found_player.connect(fsm.change_state.bind(enemy_chase_state))


func _physics_process(delta):
	mouse_cast.target_position = get_local_mouse_position()
	

