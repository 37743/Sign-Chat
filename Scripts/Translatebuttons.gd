extends Node2D

var scene_path_to_load
var back_button_lol = 0

func _ready():
	for button in $Translatebuttons/HBoxContainer/VBoxContainer2.get_children():
		button.connect("pressed", self, "_on_Button_pressed", [button.scene_to_load])
	if back_button_lol == 0:
		  get_tree().set_quit_on_go_back(false)
    pass

func _notification(yes):
    if (yes == MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST):
        get_tree().change_scene("res://MainUI/Mainscreen.tscn")
	
func _on_EnglishToASL_pressed(scene_to_load):
	var player = AudioStreamPlayer.new()
	self.add_child(player)
	player.stream = load("res://SFX_/persona2button.wav")
	player.play()
	scene_path_to_load = scene_to_load
	$Fade.show()
	$Fade.fade_in()

func _on_Fade_fade_finished():
	get_tree().change_scene(scene_path_to_load)
