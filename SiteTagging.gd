extends Node

var sites_unlocked = {}
var murals_unlocked = {}
var tags_unlocked = {}
var tags_all = {
	1: "tag_1", 2: "tag_2"
}
var murals_all = {
	"mural_1": { display_name = "Mural 1", icon = null, tags = { 1: tags_all[1], 2: tags_all[2] } }
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

func add_site(site_id, site_name, icon):
	sites_unlocked[site_id] = { display_name = site_name, icon = icon, murals = {}, tags = {} }

func add_mural(to_site_id, mural_id, mural_name, mural_icon):
	var mural = { display_name = mural_name, icon = mural_icon, tags = {} }
	murals_unlocked[mural_id] = mural
	sites_unlocked[to_site_id].murals[mural_id] = mural

func ui_add_tag(tag_id, to_site_id):
	sites_unlocked[to_site_id].tags[tag_id] = true

func ui_remove_tag(tag_id, from_mural_id):
	murals_unlocked[from_mural_id].erase(tag_id)

func unlock_tag(tag_id):
	tags_unlocked[tag_id] = tags_all[tag_id]

func _on_mural_mural_discovered(mural_id):
	print("Discovering mural {mural_id}".format({"mural_id": mural_id}))
	var mural = murals_all[mural_id]
	murals_unlocked[mural_id] = mural
	for tag_id in mural.tags:
		unlock_tag(tag_id)
