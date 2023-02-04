extends AudioStreamPlayer

var voiceList = [preload("res://SFX/voice1.wav"),preload("res://SFX/voice2.wav"),preload("res://SFX/voice3.wav"),preload("res://SFX/voice4.wav")]

var rng = RandomNumberGenerator.new()

func playSound():
	rng.randomize()
	var pitch = rng.randf_range(0.5, 1.3)
	pitch_scale = pitch
	var inflection = rng.randi_range(0,3)
	stream = voiceList[inflection]
	play()
	
func _ready():
	pass
