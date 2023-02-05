extends Node

var tag_class = load("res://TagClass.gd")
var mural_class = load("res://MuralClass.gd")

var sites_unlocked = {}

var UNLOCKED_BY_DEFAULT = false
var tags_unlocked = {}
var tags_all = {
	"tag_music": tag_class.new("Music", UNLOCKED_BY_DEFAULT),
	"tag_agriculture": tag_class.new("Agriculture", UNLOCKED_BY_DEFAULT),
	"tag_flight": tag_class.new("Flight", UNLOCKED_BY_DEFAULT),
	"tag_laws": tag_class.new("Laws", UNLOCKED_BY_DEFAULT),
	"tag_cheese": tag_class.new("Cheese", UNLOCKED_BY_DEFAULT),
	"tag_astronomy": tag_class.new("Astronomy", UNLOCKED_BY_DEFAULT),
	"tag_literacy": tag_class.new("Literacy", UNLOCKED_BY_DEFAULT),
	"tag_textiles": tag_class.new("Textiles", UNLOCKED_BY_DEFAULT),
	"tag_trade": tag_class.new("Trade Routes", UNLOCKED_BY_DEFAULT),
	"tag_games": tag_class.new("Games", UNLOCKED_BY_DEFAULT),
	"tag_industry": tag_class.new("Industry", UNLOCKED_BY_DEFAULT),
	"tag_holidays": tag_class.new("Public Holidays", UNLOCKED_BY_DEFAULT),
	"tag_pets": tag_class.new("Pets", UNLOCKED_BY_DEFAULT),
	"tag_arrowheads": tag_class.new("Arrowheads"),
	"tag_wild_animals": tag_class.new("Wild Animals"),
	"tag_skeletons": tag_class.new("Humanoid Skeletons"),
	"tag_paganism": tag_class.new("Paganism"),
	"tag_huts": tag_class.new("Huts"),
	"tag_ziggurats": tag_class.new("Ziggurats"),
	"tag_pottery": tag_class.new("Pottery"),
	"tag_towers": tag_class.new("Towers"),
	"tag_statues": tag_class.new("Statues"),
	"tag_glyphs": tag_class.new("Glyphs"),
	"tag_farm_animals": tag_class.new("Farm Animals"),
	"tag_theistic": tag_class.new("Theistic"),
	"tag_walls": tag_class.new("Walls"),
	"tag_mining": tag_class.new("Mining Equipment"),
	"tag_bronze": tag_class.new("Bronze"),
	"tag_wheels": tag_class.new("Wheels"),
	"tag_king": tag_class.new("??? King"),
	"tag_military": tag_class.new("Military"),
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
	# "id": name, icon, wanted tags, unlockable tags
	"mural_1_id": mural_class.new("Mural 1", null,
		["tag_arrowheads", "tag_wild_animals"], # wants
		["tag_military", "tag_farm_animals"]) # unlocks
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

func _on_site_site_discovered(site_id):
	print("Discovering site {site_id}".format({"site_id": site_id}))
	# TODO: "discover site" logic
