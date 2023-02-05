var name: String
var icon: Texture
var unlockable_tag_ids: Array  # strings

func _init(name: String, icon: Texture, unlockable_tag_ids: Array):
	self.name = name
	self.icon = icon
	self.unlockable_tag_ids = unlockable_tag_ids
