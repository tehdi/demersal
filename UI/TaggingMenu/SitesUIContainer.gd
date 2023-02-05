extends HBoxContainer

export (PackedScene) var site_ui_prefab
export (NodePath) var mural_container_node_path
export (NodePath) var tag_container_node_path

var mural_container
var tag_container

func _ready():
	mural_container = get_node(mural_container_node_path)
	tag_container = get_node(tag_container_node_path)


func setup_sites_ui():
	# Remove all existing 
	for child in get_children():
		child.queue_free()
	
	# Find all the sites from $Global
	for site_key in SiteTagging.sites_unlocked:
		var site = SiteTagging.sites_unlocked[site_key]
		
		add_site_ui(site_key, site)
		


func add_site_ui(site_id, site):
	var site_instance = site_ui_prefab.instance()
	
	site_instance.setup_ui(site_id, site.display_name, site.icon)
	
	site_instance.connect("selected", self, "on_site_selected")
	
	add_child(site_instance)

func on_site_selected(site_id):
	print("Selected: " + site_id)
	tag_container.setup_ui(site_id)
