extends Control

signal selected(mural_data)

export (String) var mural_id
export var mural_name = "[MURAL NAME]"
export (Texture) var icon

func setup_ui(mural_id, mural_name, icon):
	self.mural_id = mural_id
	self.mural_name = mural_name
	self.icon = icon
	
	$Button.text = mural_name
	$Button.icon = icon


func _on_Button_pressed():
	emit_signal("selected", mural_id)
