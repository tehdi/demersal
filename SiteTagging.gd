extends Node

var tag_class = load("res://TagClass.gd")
var mural_class = load("res://MuralClass.gd")
var site_class = load("res://SiteClass.gd")

var sites_unlocked = {
	"site_a": site_class.new("Site A", null,
		["tag_pillars", "tag_walls", "tag_houses", "tag_towers", "tag_swords", "tag_pottery"]),
	"site_b": site_class.new("Site B", null,
		["tag_huts", "tag_ziggurats", "tag_spears"]),
	"site_c": site_class.new("Site C", null,
		["tag_buildings", "tag_asphalt", "tag_roads", "tag_lamps", "tag_electricity"])
}

var LOCKED_BY_DEFAULT = true
var tags_all = {
	"tag_hero": tag_class.new("Hero", LOCKED_BY_DEFAULT),
	"tag_monarch": tag_class.new("Monarch", LOCKED_BY_DEFAULT),
	"tag_deity": tag_class.new("Deity", LOCKED_BY_DEFAULT),
	"tag_agriculture": tag_class.new("Agriculture"),
	"tag_laws": tag_class.new("Laws"),
	"tag_cheese": tag_class.new("Cheese"),
	"tag_astronomy": tag_class.new("Astronomy"),
	"tag_literacy": tag_class.new("Literacy"),
	"tag_pillars": tag_class.new("Pillars"),
	"tag_textiles": tag_class.new("Textiles"),
	"tag_trade": tag_class.new("Trade Routes"),
	"tag_games": tag_class.new("Games"),
	"tag_industry": tag_class.new("Industry"),
	"tag_spears": tag_class.new("Spears"),
	"tag_holidays": tag_class.new("Public Holidays"),
	"tag_pets": tag_class.new("Pets"),
	"tag_arrowheads": tag_class.new("Arrowheads"),
	"tag_wild_animals": tag_class.new("Wild Animals"),
	"tag_skeletons": tag_class.new("Humanoid Skeletons"),
	"tag_paganism": tag_class.new("Paganism"),
	"tag_huts": tag_class.new("Huts"),
	"tag_houses": tag_class.new("Houses"),
	"tag_ziggurats": tag_class.new("Ziggurats"),
	"tag_pottery": tag_class.new("Pottery"),
	"tag_towers": tag_class.new("Towers"),
	"tag_statues": tag_class.new("Statues"),
	"tag_buildings": tag_class.new("Buildings"),
	"tag_glyphs": tag_class.new("Glyphs"),
	"tag_farm_animals": tag_class.new("Farm Animals"),
	"tag_theistic": tag_class.new("Theistic"),
	"tag_walls": tag_class.new("Walls"),
	"tag_mining": tag_class.new("Mining Equipment"),
	"tag_bronze": tag_class.new("Bronze"),
	"tag_wheels": tag_class.new("Wheels"),
	"tag_military": tag_class.new("Military"),
	"tag_swords": tag_class.new("Swords"),
	"tag_horses": tag_class.new("Horses"),
	"tag_iron": tag_class.new("Iron"),
	"tag_shipbuilding": tag_class.new("Shipbuilding"),
	"tag_steel": tag_class.new("Steel"),
	"tag_temples": tag_class.new("Temples"),
	"tag_currency": tag_class.new("Currency"),
	"tag_books": tag_class.new("Books"),
	"tag_schools": tag_class.new("Schools"),
	"tag_engineering": tag_class.new("Engineering")
}

var murals_unlocked = {}
var murals_all = {
	# "id": name, icon, unlockable tags
	"mural_hero": mural_class.new("Hero", null,
		["tag_monarch"]), # unlocks
	"mural_monarch": mural_class.new("Monarch", null,
		["tag_deity"]), # unlocks
	"mural_deity": mural_class.new("Deity", null,
		["tag_hero"]) # unlocks
}

func _ready():
	add_test_unlocks()

func get_tags():
	return tags_all

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

func ui_remove_tag(tag_id, from_site_id):
	sites_unlocked[from_site_id].erase(tag_id)

func unlock_tag(tag_id):
	tags_all[tag_id].locked = false

func _on_mural_mural_discovered(mural_id):
	print("Discovering mural {mural_id}".format({"mural_id": mural_id}))
	var mural = murals_all[mural_id]
	murals_unlocked[mural_id] = mural
	for tag_id in mural.unlockable_tag_ids:
		unlock_tag(tag_id)

func _on_site_site_discovered(site_id):
	print("Discovering site {site_id}".format({"site_id": site_id}))
	# TODO: "discover site" logic
