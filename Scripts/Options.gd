extends Control

var transitionfin = 0
var back_button = 0
var fades = 0
func _ready():
	$Menu/HBoxContainer/VBoxContainer/Master.value = AudioServer.get_bus_volume_db(
		AudioServer.get_bus_index("Master")
	)
	$Menu/HBoxContainer/VBoxContainer/Music.value = AudioServer.get_bus_volume_db(
		AudioServer.get_bus_index("Music")
	)
	set_focus_mode(0)
	if fades == 0:
		$Fade2.show()
		$Fade2.fade_out()
		fades == 1
	else:
		pass
	if back_button == 0:
		  get_tree().set_quit_on_go_back(false)

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
	load("res://Screens/White_fix.tscn")

func _on_Fade_fade_finished():
	if transitionfin == 1:
		get_tree().change_scene("res://MainUI/Mainscreen.tscn")
	pass

func _on_Fade2_fade_finished():
	$Fade2.hide()
	pass

func _on_Music_value_changed(value):
	AudioServer.set_bus_volume_db(1, lerp(AudioServer.get_bus_volume_db(1), value, 0.5))
	if value == -24:
		AudioServer.set_bus_mute(1, true)
	else:
		AudioServer.set_bus_mute(1, false)
	pass

func _on_Master_value_changed(value):
	AudioServer.set_bus_volume_db(0, lerp(AudioServer.get_bus_volume_db(0), value, 0.5))
	if value == -24:
		AudioServer.set_bus_mute(0, true)
	else:
		AudioServer.set_bus_mute(0, false)
	pass
