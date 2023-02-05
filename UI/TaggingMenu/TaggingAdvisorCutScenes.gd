extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	#$AdvisorStartMessage.send_message()

func play_advisor_correct_tags():
	$AdvisorStartMessage.send_message()
