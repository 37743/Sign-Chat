extends Label

var s = 0
var m = 0

func _process(delta):
	if s > 59:
		m += 1
		s = 0
	
	text = "Time: " + (str(m) + ":" + str(s))

func _on_s_timeout():
	s += 1
	pass
