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
	var was_correctly_tagged = SiteTagging.has_enough_correct_tags()
	
	var selected_tag_ids = SiteTagging.sites_unlocked[site_id].selected_tag_ids
	if $CheckBox.pressed and not tag_id in selected_tag_ids:
		selected_tag_ids.append(tag_id)
	elif not $CheckBox.pressed and tag_id in selected_tag_ids:
		selected_tag_ids.erase(tag_id)
	var sites_correctly_tagged = SiteTagging.has_enough_correct_tags()
	
	if !was_correctly_tagged && sites_correctly_tagged:
		var tree = get_tree()
		var root = tree.get_root()
		var tagginMenu = get_parent().get_parent().get_parent().get_parent().get_parent()
		tagginMenu.sites_correctly_tagged()
		var doorPlayer = get_node("/root/baseScene/doorPlayer")
		doorPlayer.play("doorOpen")
