extends HBoxContainer

export (PackedScene) var mural_ui_prefab

func _ready():
	# Just select nothing
	setup_murals_ui("")

func setup_murals_ui(site_id):
	# Remove all existing mural UI components
	for child in get_children():
		child.queue_free()
	
	# Add mural components for this site
	if not site_id in SiteTagging.sites_unlocked:
		return
	
	for mural_id in SiteTagging.sites_unlocked[site_id].murals:
		add_mural_ui(mural_id, SiteTagging.sites_unlocked[site_id].murals[mural_id])

func add_mural_ui(mural_id, mural):
	var mural_instance = mural_ui_prefab.instance()
	
	mural_instance.setup_ui(mural_id, mural.display_name, mural.icon)
	
	mural_instance.connect("selected", self, "_on_mural_selected")
	
	add_child(mural_instance)

func _on_mural_selected(mural):
	print(mural + " selected, but we don't do anything")
