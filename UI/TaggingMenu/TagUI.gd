extends Control

var site_id
var tag_id

func setup_tag(site_id, tag_id, tag, toggle):
	var text = "???" if tag.locked else tag.name
	$CheckBox.text = text
	$CheckBox.pressed = toggle

	self.site_id = site_id
	self.tag_id = tag_id

func _on_CheckBox_pressed():
	SiteTagging.sites_unlocked[site_id].tags[tag_id] = $CheckBox.pressed
