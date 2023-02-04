extends Node


var tag_class = load("res://TagClass.gd")
var mural_class = load("res://MuralClass.gd")

var sites_unlocked = {}

var UNLOCKED_BY_DEFAULT = false
var tags_unlocked = {}
var tags_all = {
	"tag_1_id": tag_class.new("tag_1_name", UNLOCKED_BY_DEFAULT),
	"tag_2_id": tag_class.new("tag_2_name", UNLOCKED_BY_DEFAULT),
	"tag_3_id": tag_class.new("tag_3_name", UNLOCKED_BY_DEFAULT),
	"tag_4_id": tag_class.new("tag_4_name"),
	"tag_5_id": tag_class.new("tag_5_name"),
}

var murals_unlocked = {}
var murals_all = {
	# "id": name, icon, wanted tags, unlockable tags
	"mural_1_id": mural_class.new("Mural 1", null, ["tag_1_id", "tag_2_id"], ["tag_3_id", "tag_4_id"])
}

func _ready():
	add_test_unlocks()

func get_unlocked_tags():
	return tags_unlocked

func add_test_unlocks():
	for site_node in $DefaultSites.get_children():
		add_site(site_node.site_id, site_node.display_name, site_node.texture)
		for mural_node in site_node.get_children():
			add_mural(site_node.site_id, mural_node.mural_id, mural_node.display_name, mural_node.texture)
	for tag_key in tags_all:
		var tag = tags_all[tag_key]
		if not tag.locked:
			tags_unlocked[tag_key] = tag

func add_site(site_id, site_name, icon):
	sites_unlocked[site_id] = { display_name = site_name, icon = icon, murals = {}, tags = {} }

func add_mural(to_site_id, mural_id, mural_name, mural_icon):
	var mural = { display_name = mural_name, icon = mural_icon, tags = {} }
	murals_unlocked[mural_id] = mural
	sites_unlocked[to_site_id].murals[mural_id] = mural

func ui_add_tag(tag_id, to_site_id):
	sites_unlocked[to_site_id].tags[tag_id] = true

func ui_remove_tag(tag_id, from_site_id):
	sites_unlocked[from_site_id].erase(tag_id)

func unlock_tag(tag_id):
	tags_unlocked[tag_id] = tags_all[tag_id]

func _on_mural_mural_discovered(mural_id):
	print("Discovering mural {mural_id}".format({"mural_id": mural_id}))
	var mural = murals_all[mural_id]
	murals_unlocked[mural_id] = mural
	for tag_id in mural.unlockable_tag_ids:
		unlock_tag(tag_id)
