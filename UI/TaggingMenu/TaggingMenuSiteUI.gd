extends Control

signal selected(site_id)

export (String) var site_id
export (String) var site_name

func setup_ui(site_id, site_name, icon):
	self.site_id = site_id
	self.site_name = site_name
	
	$VBoxContainer/SiteName.text = site_name
	$VBoxContainer/SiteButton.icon = icon


func _on_SiteButton_pressed():
	emit_signal("selected", site_id)
