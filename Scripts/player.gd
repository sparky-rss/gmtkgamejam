extends RigidBody2D

signal teleport_left_to_right
signal teleport_right_to_left

var hornets_to_spawn : int = 0

var scoring : bool
var max_horiz_speed : int = 1000
var max_vert_speed : int = 500
var state : String
var player_sprite : Node

var wing_bumble_up : bool = true
var wing_bumble : float = 0.0

var looping : bool = false
var loop_center : Vector2 = Vector2.ZERO
var loop_angle : float = 0.0
var loop_direction : int = 1
var loop_steps : int = 50
var loop_step : int = 0
var start_offset : Vector2 = Vector2.ZERO
var loop_duration : float = 1.0
var incoming_velocity : float = 0.0
var exit_velocity : float

func _ready() -> void:
	play_sound("BGM")
	Globals.player = self
	player_sprite = get_node("Sprite2D")
	player_sprite.animation = "flipRtoL"
	player_sprite.frame = 4
	state = "going_left"
	spawn_hornets()
	
func _physics_process(_delta: float) -> void:
	if looping:
		loop_angle -= loop_direction * (2 * PI / loop_steps)
		global_position = loop_center + start_offset.rotated(loop_angle)
		rotation = loop_angle + PI / loop_steps
		loop_step += 1
		if loop_step >= loop_steps:
			looping = false
			rotation = 0
			if scoring:
				get_node("LoopPoint/Area2D").score_flower()
				scoring = false
			if loop_direction == 1:
				state = "going_right"
				exit_velocity = max(150, incoming_velocity)
			else:
				state = "going_left"
				exit_velocity = min(-150, incoming_velocity)
			self.linear_velocity = Vector2(exit_velocity, -100)
		return
	if Globals.unscored_flowers <= 0 and !Globals.you_win and !Globals.game_over:
		Globals.you_win = true
		var HUD_node = get_parent().get_node("HUD")
		HUD_node.you_win()
			
func _process(_delta):
	
	if !Globals.game_over:
		get_node("Sprite2D/Wing").position += Vector2(-wing_bumble * .2,-wing_bumble * .2)
		if wing_bumble_up:
			wing_bumble -= .25
			if wing_bumble <= -3:
				wing_bumble_up = false
		else:
			wing_bumble += .25
			if wing_bumble >= 3:
				wing_bumble_up = true
	
	if Input.is_action_just_pressed("Loop") and state != "loop" and !Globals.game_over:
		var state_to_return_to : String
		if player_sprite.animation == "flipLtoR":
			state_to_return_to = "going_right"
		else:
			state_to_return_to = "going_left"
		state = "loop"
		execute_loop(state_to_return_to, self.linear_velocity.x)
	if Input.is_action_just_pressed("Flutter") and state != "loop" and !Globals.game_over:
		self.apply_central_force(Vector2(0,-350))
	if Input.is_action_pressed("GoLeft") and state != "loop" and !Globals.game_over:
		self.apply_central_force(Vector2(-10,0))
		if state == "going_right":
			state = "turning_left"
			play_player_animation("flipRtoL", player_sprite)
			turn_wing(get_node("Sprite2D/Wing"), state)
			
	if Input.is_action_pressed("GoRight") and state != "loop" and !Globals.game_over:
		self.apply_central_force(Vector2(10,0))
		if state == "going_left":
			state = "turning_right"
			play_player_animation("flipLtoR", player_sprite)
			turn_wing(get_node("Sprite2D/Wing"), state)
	
	if self.position.x > 3000:
		self.position.x = -3000
		teleport_right_to_left.emit()
	if self.position.x < -3000:
		self.position.x = 3000
		teleport_left_to_right.emit()
	if self.position.y > 1000:
		self.position.y = 1000
		self.apply_central_force(Vector2(0,-350))
	if self.position.y < -1000:
		self.position.y = -1000
		self.linear_velocity.y = 0
		
	if self.linear_velocity.x > max_horiz_speed:
		self.linear_velocity.x = max_horiz_speed
	if self.linear_velocity.y > max_vert_speed:
		self.linear_velocity.y = max_vert_speed
	if self.linear_velocity.x < -max_horiz_speed:
		self.linear_velocity.x = -max_horiz_speed
	if self.linear_velocity.y < -max_vert_speed:
		self.linear_velocity.y = -max_vert_speed

func play_player_animation(animation_to_play : String, player : Node) -> void:
		if player.animation == animation_to_play:
			pass
		else:
			player.animation = animation_to_play
			player.get_sprite_frames().set_animation_loop(animation_to_play, false)
			player.play()

func execute_loop(state_to_return_to: String, velocity : float) -> void:
	if get_node("LoopPoint/Area2D/AnimatedSprite2D").animation == "targeted":
		var unscored_flower : bool = get_node("LoopPoint/Area2D").check_flower_eligibility()
		if unscored_flower:
			scoring = true
			get_node("LoopPoint/Area2D").animate_flower()
	incoming_velocity = velocity
	looping = true
	loop_center = get_node("LoopPoint").global_position
	loop_angle = 0.0
	if state_to_return_to == "going_right":
		loop_direction = 1
	else:
		loop_direction = -1
	start_offset = global_position - loop_center
	loop_duration = 1 - (.4 * (abs(self.linear_velocity.x)/max_horiz_speed))
	loop_step = 0
	state = "loop"

func _on_sprite_2d_animation_finished() -> void:
	process_completed_animation()

func process_completed_animation():
	if state == "turning_left":
		state = "going_left"
	if state == "turning_right":
		state = "going_right"

func spawn_hornets() -> void:
	hornets_to_spawn = Globals.level - 1
	var hornets_spawned = 0
	while hornets_spawned < hornets_to_spawn:
		var query := PhysicsPointQueryParameters2D.new()
		query.collide_with_areas = true
		var vector_y = randi_range(500, 999)
		var vector_y_randomizer = 2 * (randi_range(0,1) - 0.5)
		var vector_x = randi_range(1000, 3000)
		var vector_x_randomizer = 2 * (randi_range(0,1) - 0.5)
		query.position = Vector2(vector_x * vector_x_randomizer, vector_y * vector_y_randomizer)
		var result := get_world_2d().direct_space_state.intersect_point(query)
		if result == []:
			hornets_spawned += 1
			var new_hornet: Node = Globals.hornet_scene.instantiate()
			get_parent().add_child.call_deferred(new_hornet)
			new_hornet.global_position = query.position

func play_sound(sound : String) -> void:
	var sound_manager : Node = get_parent().get_node("SoundManager")
	sound_manager.get_node(sound).play()
	
func stop_sound(sound : String) -> void:
	var sound_manager : Node = get_parent().get_node("SoundManager")
	sound_manager.get_node(sound).stop()

func turn_wing(wing : Node, player_state : String) -> void:
	var end_position
	if player_state == "turning_right":
		end_position = -11.0
	else:
		end_position = 11.0
	for i in 10:
		if !Globals.game_over:
			wing.position.x = lerp(wing.position.x, end_position, 0.25)
			await get_tree().create_timer(0.2).timeout
	if state == player_state and !Globals.game_over:
		wing.position.x = end_position
