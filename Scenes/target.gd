extends Area2D

var targeted_flower : Node
var scoring_flower : Node

func _on_area_entered(area: Area2D) -> void:
	if area.scoreable:
		get_node("AnimatedSprite2D").animation = "targeted"
		targeted_flower = area

func _on_area_exited(_area: Area2D) -> void:
	get_node("AnimatedSprite2D").animation = "untargeted"
	targeted_flower = null

func check_flower_eligibility() -> bool:
	return targeted_flower.scoreable

func animate_flower() -> void:
	scoring_flower = targeted_flower
	var target_sprite = targeted_flower.get_node("AnimatedSprite2D")
	target_sprite.animation = "score"
	target_sprite.get_sprite_frames().set_animation_loop("score", false)
	target_sprite.play()
	
func score_flower() -> void:
	var target_sprite = scoring_flower.get_node("AnimatedSprite2D")
	target_sprite.animation = "score"
	target_sprite.get_sprite_frames().set_animation_loop("score", false)
	target_sprite.play()
	scoring_flower.get_node("Particles").emitting = true
	scoring_flower.scoreable = false
