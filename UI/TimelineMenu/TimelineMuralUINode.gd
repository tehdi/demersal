extends GraphNode

signal on_node_moved(node)

export (String) var site_id
export (String) var site_name

func setup_ui(site_id, site_name, icon):
	self.site_id = site_id
	self.site_name = site_name
	$TextureRect.texture = icon
	title = site_name


func _on_GraphNode_dragged(from, to):
	print("Moved1")
	emit_signal("on_node_moved", self)
