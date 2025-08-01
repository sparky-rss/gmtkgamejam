extends Node2D

var bumble : float = 5
var bumble_up = true
var wing_bumble : float = 0
var wing_bumble_up = true
var previous_position : Vector2 = Vector2(-1,-1)
var signals_connected : bool = false
var hunt_aggression : float = 0.00
var disperse : bool = false
var disperse_direction : Vector2

func _process(_delta: float) -> void:
	
	get_node("AnimatedSprite2D/Sprite2D").position += Vector2(-wing_bumble * .1,-wing_bumble * .2)
	if wing_bumble_up:
		wing_bumble -= .25
		if wing_bumble <= -3:
			wing_bumble_up = false
	else:
		wing_bumble += .25
		if wing_bumble >= 3:
			wing_bumble_up = true
	
	if Globals.player != null and Globals.global_timer != null:
		if !signals_connected:
			Globals.player.teleport_left_to_right.connect(_left_to_right)
			Globals.player.teleport_right_to_left.connect(_right_to_left)
			signals_connected = true
		if disperse and hunt_aggression == 0:
			position += disperse_direction
		else:
			if !Globals.game_over and !Globals.you_win:
				position.x = (position.x * (.999 - hunt_aggression)) + (Globals.player.position.x * (.001 + hunt_aggression))
				position.y = (position.y * .999 - hunt_aggression) + (Globals.player.position.y * .001 + hunt_aggression) + bumble
			else:
				position.y = (position.y  + bumble)
		if bumble_up:
			bumble -= .05
			if bumble <= -2:
				bumble_up = false
		else:
			bumble += .05
			if bumble >= 2:
				bumble_up = true
	if previous_position.x < position.x and abs(previous_position.x - position.x) < 100:
		play_hornet_animation("flipLtoR", get_node("AnimatedSprite2D"))
		turn_wing(get_node("AnimatedSprite2D/Sprite2D"), "turning_right")
	elif previous_position.x > position.x and abs(previous_position.x - position.x) < 100:
		play_hornet_animation("flipRtoL", get_node("AnimatedSprite2D"))
		turn_wing(get_node("AnimatedSprite2D/Sprite2D"), "turning_left")
	previous_position = position

func play_hornet_animation(animation_to_play : String, hornet : Node) -> void:
		if hornet.animation == animation_to_play:
			pass
		else:
			hornet.animation = animation_to_play
			hornet.get_sprite_frames().set_animation_loop(animation_to_play, false)
			hornet.play()

func _left_to_right() -> void:
	self.position.x += 6000
	
func _right_to_left() -> void:
	self.position.x -= 6000
	
func _on_hunt_zone_body_entered(body: Node2D) -> void:
	if body == Globals.player:
		hunt_aggression = 0.007

func _on_hunt_zone_body_exited(body: Node2D) -> void:
	if body == Globals.player:
		hunt_aggression = 0.00

func _on_sting_zone_body_entered(body: Node2D) -> void:
	if body == Globals.player and !Globals.you_win and !Globals.game_over:
		Globals.player.play_sound("Aggro")
		Globals.game_over = true
		var HUD_node = get_parent().get_node("HUD")
		HUD_node.you_lose("stung")
		Globals.player.get_node("Sprite2D").flip_v = true
		Globals.player.play_player_animation("dead", Globals.player.get_node("Sprite2D"))


func _on_sting_zone_area_entered(area: Area2D) -> void:
	if area.is_in_group("hornet"):
		disperse = true
		var x_direct = randi_range(-10,10)
		var y_direct = randi_range(-10,10)
		self.disperse_direction = Vector2(x_direct, y_direct)

func _on_hunt_zone_area_exited(area: Area2D) -> void:
	if area.is_in_group("hornet"):
		disperse = false

func turn_wing(wing : Node, hornet_state : String) -> void:
	var end_position
	if hornet_state == "turning_right":
		end_position = -3.0
	else:
		end_position = 3.0
	for i in 10:
		wing.position.x = lerp(wing.position.x, end_position, 0.25)
		await get_tree().create_timer(0.2).timeout
