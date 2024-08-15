extends Control

var transitionfin = 0
var back_button = 0
var fades = 0
var value1 = 0
var value2 = 0
var RATE = 10
var array1 = []
var a = 0
var placebo = 0
var keyword = 0
var startstopvar = 0

func _process(delta):
	TIMEUPDATE()
	SCOREUPDATE()

func _ready():
	RANDGTG()
	repopulateGridContainer()
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

func SCOREUPDATE():
	$GuessTheGesture/ScoreTime/Score.text = "Score:" + str(value1)
	pass
func TIMEUPDATE():
	if $GuessTheGesture/GTGtext.editable == false:
		$GuessTheGesture/ScoreTime/Time/s.start()
	$GuessTheGesture/ScoreTime/Time.text = "Time:" + str(value2) + "s"
	pass

func repopulateGridContainer():
	var GesturesPanel = get_node("GuessTheGesture/Container")
	if placebo == 0:
		match a:
			0:
				keyword = "hi"
				$GuessTheGesture/HintText.text = "Temporary hint! It's 'hi' or one of it's synonyms!"
			1:
				keyword = "goodbye"
				$GuessTheGesture/HintText.text = "Temporary hint! It's 'goodbye' or one of it's synonyms!"
			2:
				keyword = "good"
				$GuessTheGesture/HintText.text = "Temporary hint! It's 'good' or one of it's synonyms!"
			3:
				keyword = "yes"
				$GuessTheGesture/HintText.text = "Temporary hint! It's 'yes' or one of it's synonyms!"
			4:
				keyword = "no"
				$GuessTheGesture/HintText.text = "Temporary hint! It's 'no' or one of it's synonyms!"
			5:
				keyword = "thanks"
				$GuessTheGesture/HintText.text = "Temporary hint! It's 'thanks' or one of it's synonyms!"
			6:
				keyword = "help"
				$GuessTheGesture/HintText.text = "Temporary hint! It's 'help' or one of it's synonyms!"
			7:
				keyword = "please"
				$GuessTheGesture/HintText.text = "Temporary hint! It's 'please' or one of it's synonyms!"
			8:
				keyword = "sorry"
				$GuessTheGesture/HintText.text = "Temporary hint! It's 'sorry' or one of it's synonyms!"
		var gesture = TextureRect.new()
		gesture.name = keyword
		gesture.texture = autovar.texturebykeyword[keyword]
		gesture.rect_scale = Vector2(1.8,1.8)
		GesturesPanel.add_child(gesture)
		placebo = 1
	if array1.has(keyword):
		for child in GesturesPanel.get_children():
			child.queue_free()
		array1.clear()
		value1 = value1 + RATE
		placebo = 0
		SCOREUPDATE()
		RANDGTG()
		get_node("GuessTheGesture/GTGtext").clear()
func RANDGTG():
	randomize()
	a = randi()%9
	return a
	pass

func _on_GTGtext_text_changed(new_text):
	new_text = new_text.to_lower()
	for word in new_text.split(" ", false):
		var hisynonyms = ["hello","hey","salute","hallo","bonjour"]
		var byesynonyms = ["bye","farewell","adios","tschus"]
		var goodsynonyms = ["fine","decent","adequate","acceptable"]
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
			array1.append(word)
	repopulateGridContainer()
func _on_Fade_fade_finished():
	if transitionfin == 1:
		get_tree().change_scene("res://MainUI/Mainscreen.tscn")
	pass

func _on_Fade2_fade_finished():
	$Fade2.hide()
	pass

func _on_Reset__pressed():
	value1 = 0
	$GuessTheGesture/ScoreTime/Time.s = 0
	$GuessTheGesture/ScoreTime/Time.m = 0
	SCOREUPDATE()
	$GuessTheGesture/GTGtext.clear()

func _on_StartStop__pressed():
	if $GuessTheGesture/GTGtext.editable == true:
		$GuessTheGesture/GTGtext.clear()
		$GuessTheGesture/GTGtext.set_focus_mode(0)
		$GuessTheGesture/GTGtext.editable = false
		$GuessTheGesture/GTGtext.placeholder_text = "Press on Start."
		$GuessTheGesture/Timerbuttons/StartStop_/Label.text = "Start"
	else:
		$GuessTheGesture/GTGtext.set_focus_mode(1)
		$GuessTheGesture/GTGtext.grab_focus()
		$GuessTheGesture/GTGtext.editable = true
		$GuessTheGesture/GTGtext.placeholder_text = "Enter text."
		$GuessTheGesture/Timerbuttons/StartStop_/Label.text = "Stop"

