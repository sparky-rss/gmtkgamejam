extends Area2D

var flowers_to_grow : int
var flowers_grown : int = 0

func _ready() -> void:
	flowers_to_grow = Globals.level * 20
	while flowers_grown < flowers_to_grow:
		var query := PhysicsPointQueryParameters2D.new()
		query.collide_with_areas = true
		var vector_y = randi_range(-800, 250)
		var vector_x = randi_range(-2500, 2750)
		query.position = Vector2(vector_x, vector_y)
		var result := get_world_2d().direct_space_state.intersect_point(query)
		if result != []:
			if result[0]["collider"].is_in_group("flowerzone"):
				var overlap = false
				for i in result:
					if i["collider"].is_in_group("overlap"):
						overlap = true
				if !overlap:	
					flowers_grown += 1
					var new_flower : Node = Globals.flower_scene.instantiate()
					add_child(new_flower)
					new_flower.global_position = query.position
					new_flower.dupe_self()
	Globals.unscored_flowers = flowers_grown
	
