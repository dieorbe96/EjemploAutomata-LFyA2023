extends Node2D
@onready var world = $"."
@onready var block_tile_map = $BlockTileMap


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("SpawnCoin"):
		spawn_coin()
	pass

func spawn_coin():
	var coin_instance = preload("res://Coin.tscn").instantiate() 
	# Defino posicion random
	var viewport_size = get_viewport_rect().size
	var valid_position = false
	var random_x
	var random_y
	while not valid_position:
		
		# Generate random coordinates within the viewport
		random_x = randi() % int(viewport_size.x)
		random_y = randi() % int(viewport_size.y)
		var tilemap_position = block_tile_map.local_to_map(Vector2(random_x, random_y))
		var tile_index = block_tile_map.get_cell_source_id(0,tilemap_position)
		if tile_index == -1:
			valid_position = true
		
	coin_instance.position = Vector2(random_x, random_y)
	
	add_child(coin_instance)
