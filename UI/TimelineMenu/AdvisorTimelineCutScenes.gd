extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$AdvisorStartMessage.send_message()

func nodes_re_ordered(nodes):
	pass
