extends Node


func _process(delta):
	if Input.is_action_just_released("menu"):
		get_parent().move_child(self, 0)
		get_tree().paused = !get_tree().paused
		$CanvasLayer/TaggingMenu.visible = !$CanvasLayer/TaggingMenu.visible
		$CanvasLayer/TaggingMenu._ready()
		
		if Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
