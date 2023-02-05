extends HBoxContainer

export (NodePath) var grid_container_node_path
export (PackedScene) var tag_ui_prefab

var tag_id
var tag_name
var grid_container

func _ready():
	grid_container = get_node(grid_container_node_path)
	setup_ui("")

func setup_ui(site_id):
	# Remove existing tags
	for grid_child in grid_container.get_children():
		grid_child.queue_free()

	if not site_id in SiteTagging.sites_unlocked:
		return

	var all_tags = SiteTagging.get_tags()

	for tag_id in all_tags:
		var tag_instance = tag_ui_prefab.instance()
		var site = SiteTagging.sites_unlocked[site_id]
		var toggle = tag_id in site.selected_tag_ids
		tag_instance.setup_tag(site_id, tag_id, all_tags[tag_id], toggle)
		grid_container.add_child(tag_instance)
