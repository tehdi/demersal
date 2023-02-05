extends Control

func _ready():
	update_sites()

func _enter_tree():
	update_sites()
	
func update_sites():
	# Tell the SitesContainer to update
	$PanelContainer/VBoxContainer/SitesContainer.setup_sites_ui()

func sites_correctly_tagged():
	$"Tagging Advisor Cut Scenes".play_advisor_correct_tags()
