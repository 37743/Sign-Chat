extends Control

var transitionfin = 0
var transitionfin2 = 0
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
	if back_button == 0:
		  get_tree().set_quit_on_go_back(false)
	pass
	for button in $CenterContainer/HBoxContainer/VBoxContainer.get_children():
		button.connect("pressed", self, "_on_EnglishToASL_pressed", [button.scene_to_load])
		pass

func _notification(yes):
    if (yes == MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST):
        get_tree().change_scene("res://MainUI/Mainscreen.tscn")
	
func _on_Button_pressed():
	var player = AudioStreamPlayer.new()
	self.add_child(player)
	player.stream = load("res://SFX_/persona2button.wav")
	transitionfin = 1
	player.play()
	if player.playing == false:
		pass
	$Fade.show()
	$Fade.fade_in()
	
func _on_EnglishToASL_pressed(scene_to_load):
	scene_path_to_load = scene_to_load
	transitionfin2 = 1
	$Fade.show()
	$Fade.fade_in()
	load("res://Screens/White_fix.tscn")

func _on_Fade_fade_finished():
	if transitionfin == 1:
		get_tree().change_scene("res://MainUI/Mainscreen.tscn")
	pass
	if transitionfin2 == 1:
		get_tree().change_scene(scene_path_to_load)
	pass

func _on_Fade2_fade_finished():
	$Fade2.hide()
	pass