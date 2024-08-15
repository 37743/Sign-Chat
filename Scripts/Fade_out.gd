extends ColorRect

signal fade_finished

func fade_out():
	$AnimationPlayer.play("Fadeout")

func _on_AnimationPlayer_animation_finished(anim_name):
	emit_signal("fade_finished")
