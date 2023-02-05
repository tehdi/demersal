var name: String
var icon: Texture
var wanted_tag_ids: Array  # strings

func _init(name: String, icon: Texture, wanted_tag_ids: Array):
	self.name = name
	self.icon = icon
	self.wanted_tag_ids = wanted_tag_ids
