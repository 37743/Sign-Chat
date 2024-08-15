extends Control

var transitionfin = 0
var back_button = 0
var array1 = []
var fades = 0

func _ready():
	var text1 = get_node("Mainproject/TextEdit").get_text()
	if fades == 0:
		$Fade2.show()
		$Fade2.fade_out()
		fades == 1
	else:
		pass
	if back_button == 0:
		  get_tree().set_quit_on_go_back(false)
    pass

func simulate_keypress():
    var enter = InputEventKey.new()
    enter.scancode = KEY_ENTER
    enter.pressed = true
    Input.parse_input_event(enter)

func _notification(yes):
    if (yes == MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST):
        get_tree().change_scene("res://Screens/Start.tscn")

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
		get_tree().change_scene("res://Screens/Start.tscn")

func _on_Fade2_fade_finished():
	$Fade2.hide()
	pass

func _on_TextEdit_text_entered(new_text):
	var detected = []
	new_text = new_text.to_lower()
	for word in new_text.split(" ", false):
		var hisynonyms = ["hello","hey","salute","hallo","bonjour"]
		var byesynonyms = ["bye","farewell","adios","tschus"]
		var goodsynonyms = ["nice","fine","decent","adequate","acceptable"]
		var yessynonyms = ["affirmative","sure","alright","yeah","indeed"]
		var nosynonyms = ["negative","nah"]
		var sorrysynonyms = ["apologies","apology"]
		var pleasesynonyms = ["kindly"]
		var helpsynonyms = ["assist","aid","assistance","guide","support"]
		var thankssynonyms = ["appreciation","gratitude","grateful","thankful","appreciate"]
		if word in hisynonyms:
			word = "hi"
		if word in byesynonyms:
			word = "goodbye"
		if word in goodsynonyms:
			word = "good"
		if word in yessynonyms:
			word = "yes"
		if word in nosynonyms:
			word = "no"
		if word in sorrysynonyms:
			word = "sorry"
		if word in pleasesynonyms:
			word = "please"
		if word in helpsynonyms:
			word = "help"
		if word in thankssynonyms:
			word = "thanks"
		if autovar.texturebykeyword.has(word):
			detected.append(word)
	repopulateGridContainer(detected)
func repopulateGridContainer(keywords):
	var GesturesPanel = get_node("Mainproject/Gestures")
	for child in GesturesPanel.get_children():
		child.queue_free()
	for keyword in keywords:
		var gesture = TextureRect.new()
		gesture.name = keyword
		gesture.texture = autovar.texturebykeyword[keyword]
		GesturesPanel.add_child(gesture)

func _on_Jojo_translate1_pressed():
	simulate_keypress()

func _on_Jojo_reset1_pressed():
	get_node("Mainproject/TextEdit").clear()
	for i in get_node("Mainproject/Gestures").get_children():
		i.queue_free()
	pass
