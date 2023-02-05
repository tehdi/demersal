extends Control

signal selected(site_id)

export (String) var site_id

func setup_ui(site_id, icon):
	self.site_id = site_id
	$VBoxContainer/SiteButton.icon = icon

func _on_SiteButton_pressed():
	emit_signal("selected", site_id)
