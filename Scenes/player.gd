extends RigidBody2D

var scoring : bool
var max_horiz_speed : int = 1000
var max_vert_speed : int = 500
var state : String
var player_sprite : Node

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
	player_sprite = get_node("Sprite2D")
	player_sprite.animation = "flipRtoL"
	player_sprite.frame = 4
	state = "going_left"
	
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
				exit_velocity = max(250, incoming_velocity)
			else:
				state = "going_left"
				exit_velocity = min(-250, incoming_velocity)
			self.linear_velocity = Vector2(exit_velocity, -(abs(exit_velocity)))
		return
			
func _process(_delta):
	if Input.is_action_just_pressed("Loop") and state != "loop":
		var state_to_return_to : String
		if player_sprite.animation == "flipLtoR":
			state_to_return_to = "going_right"
		else:
			state_to_return_to = "going_left"
		state = "loop"
		execute_loop(state_to_return_to, self.linear_velocity.x)
	if Input.is_action_just_pressed("Flutter") and state != "loop":
		self.apply_central_force(Vector2(0,-350))
	if Input.is_action_pressed("GoLeft") and state != "loop":
		self.apply_central_force(Vector2(-10,0))
		if state == "going_right":
			state = "turning_left"
			play_player_animation("flipRtoL", player_sprite)
			
	if Input.is_action_pressed("GoRight") and state != "loop":
		self.apply_central_force(Vector2(10,0))
		if state == "going_left":
			state = "turning_right"
			play_player_animation("flipLtoR", player_sprite)
	
	if self.position.x > 3000:
		self.position.x = -3000
	if self.position.x < -3000:
		self.position.x = 3000
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
