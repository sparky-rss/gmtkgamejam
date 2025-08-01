extends Area2D

var targeted_flower : Array
var scoring_flower : Array
var multiplier : int = 1

func _on_area_entered(area: Area2D) -> void:
	if area.scoreable:
		get_node("AnimatedSprite2D").animation = "targeted"
		targeted_flower.append(area)

func _on_area_exited(area: Area2D) -> void:
	if targeted_flower == []:
		get_node("AnimatedSprite2D").animation = "untargeted"
	else:
		targeted_flower.erase(area)
		if targeted_flower == []:
			get_node("AnimatedSprite2D").animation = "untargeted"
	

func check_flower_eligibility() -> bool:
	if targeted_flower == []:
		return false
	else:
		for i in targeted_flower:
			if i.scoreable:
				return true
	return false

func animate_flower() -> void:
	scoring_flower = targeted_flower.duplicate()
	for flower in targeted_flower:
		if flower.scoreable == true:
			play_flower_animation(flower.get_node("AnimatedSprite2D"))
			play_flower_animation(flower.left_flower.get_node("AnimatedSprite2D"))
			play_flower_animation(flower.right_flower.get_node("AnimatedSprite2D"))

func play_flower_animation(flower_sprite: Node) -> void:
	flower_sprite.animation = "score"
	flower_sprite.get_sprite_frames().set_animation_loop("score", false)
	flower_sprite.play()

func score_flower() -> void:
	for flower in scoring_flower:
		if flower.scoreable == true:
			play_flower_animation(flower.get_node("AnimatedSprite2D"))
			play_flower_animation(flower.left_flower.get_node("AnimatedSprite2D"))
			play_flower_animation(flower.right_flower.get_node("AnimatedSprite2D"))
			flower.get_node("Particles").emitting = true
			flower.scoreable = false
			Globals.score += flower.points * multiplier
			flower.display_score(multiplier)
			multiplier += 1
			Globals.unscored_flowers -= 1
			if !Globals.game_over:
				Globals.player.play_sound("Collect")
	multiplier = 1
