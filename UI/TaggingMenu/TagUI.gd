extends Control

var site_id
var tag_id

func setup_tag(site_id, tag_id, tag_display, toggle):
	$CheckBox.text = tag_display
	$CheckBox.pressed = toggle
	
	self.site_id = site_id
	self.tag_id = tag_id


func _on_CheckBox_pressed():
	SiteTagging.sites_unlocked[site_id].tags[tag_id] = $CheckBox.pressed
