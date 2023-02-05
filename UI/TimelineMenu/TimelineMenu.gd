extends Control

export (PackedScene) var graph_node_prefab

export var site_x_start = 72 * 6
export var site_x_offset = 72 * 5
export var site_y = 72 * 4

# Called when the node enters the scene tree for the first time.
func _ready():
	for site_id in SiteTagging.sites_unlocked:
		setup_site(site_id, SiteTagging.sites_unlocked[site_id])
		
	order_sites()


func _on_GraphNode_dragged(from, to):
	print(String(from) + ", " + String(to))


func _on_TimelineMenuUINode_on_node_moved(node):
	order_sites()

func setup_site(site_id, site):
	var graph_node = graph_node_prefab.instance()
	
	graph_node.setup_ui(site_id, site.display_name, site.icon)
	$GraphEdit.add_child(graph_node)
	graph_node.connect("on_node_moved", self, "_on_TimelineMenuUINode_on_node_moved")
	
func order_sites():
	var graph_nodes = []
	for child in $GraphEdit.get_children():
		if not child is GraphNode:
			continue
		
		graph_nodes.append(child)
	
	graph_nodes.sort_custom(SortNodes, "compare_graph_nodes")
	
	var x = site_x_start
	for graph_node in graph_nodes:
		var translation = graph_node.offset
		translation.x = x
		x += site_x_offset
		translation.y = site_y
		
		graph_node.offset = translation
		x = x
	
	$"Advisor Cut Scenes".nodes_re_ordered(graph_nodes)

class SortNodes:
	static func compare_graph_nodes(graph_node_a, graph_node_b):
		if graph_node_a.offset.x < graph_node_b.offset.x:
			return true
		return false
