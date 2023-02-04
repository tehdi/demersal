extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$textMessage.visible_characters = 0

func _on_Timer_timeout():
	$textMessage.visible_characters += 1
