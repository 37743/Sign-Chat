extends Control

var scene_path_to_load
var back_button = 0
var fades = 0

func _ready():
	if fades == 0:
		$Fade2.show()
		$Fade2.fade_out()
		fades == 1
	else:
		pass
	for button in $Menu/HorizontalButtons/Buttons.get_children():
		button.connect("pressed", self, "_on_Button_pressed", [button.scene_to_load])
	if back_button == 0:
		  get_tree().set_quit_on_go_back(false)
    pass

func _on_Button_pressed(scene_to_load):
	var player = AudioStreamPlayer.new()
	self.add_child(player)
	player.stream = load("res://SFX_/persona2button.wav")
	player.play()
	if player.playing == false:
		pass
	scene_path_to_load = scene_to_load
	$Fade.show()
	$Fade.fade_in()
	load("res://Screens/White_fix.tscn")

func _on_Fade_fade_finished():
	get_tree().change_scene(scene_path_to_load)

func _on_Fade2_fade_finished():
	$Fade2.hide()
	pass
