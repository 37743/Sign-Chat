extends Control

func _ready():
	if get_node("/root/Global").playing == false:
		$MusicButton.set_pressed(false)

func _on_MusicButton_pressed():
	if $MusicButton.is_pressed():
		get_node("/root/Global").playing = true
		$MusicButton.set_pressed(true)
	else:
		get_node("/root/Global").playing = false
		$MusicButton.set_pressed(false)
