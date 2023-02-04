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
	
	var all_tags = SiteTagging.get_unlocked_tags()
	
	for tag in all_tags:
		var tag_instance = tag_ui_prefab.instance()
		var toggle = false
		if tag in SiteTagging.sites_unlocked[site_id].tags:
			toggle = SiteTagging.sites_unlocked[site_id].tags[tag]
			
		tag_instance.setup_tag(site_id, tag, all_tags[tag].name, toggle)
		grid_container.add_child(tag_instance)
		
