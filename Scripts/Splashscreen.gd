extends Node

var scene_path_to_load
var fades = 0

func _ready():
	if fades == 0:
		$Fade2.show()
		$Fade2.fade_out()
		fades == 1
	else:
		pass
func _on_Splashbutton1_pressed():
	var player = AudioStreamPlayer.new()
	self.add_child(player)
	player.stream = load("res://SFX_/persona2button.wav")
	player.play()
	if player.playing == false:
		pass
	$Fade.show()
	$Fade.fade_in()
	load("res://Screens/White_fix.tscn")
	pass

func _on_Fade_fade_finished():
		get_tree().change_scene("res://MainUI/Mainscreen.tscn")

func _on_Fade2_fade_finished():
	$Fade2.hide()
	pass
