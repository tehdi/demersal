extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$AdvisorStartMessage.send_message()

func nodes_re_ordered(nodes):
	var sites_order = SiteTagging.sites_order
	var i = 0
	for node in nodes:
		if node.site_id != sites_order[i]:
			return
		i += 1 
		
	$AdvisorEndMessage.send_message()
