var name: String
var icon: Texture
var tag_count_threshold: int
var special_tag_id: String
var wanted_tag_ids: Array  # strings
var selected_tag_ids: Array  # strings

func _init(name: String, icon: Texture,
		tag_count_threshold: int, special_tag_id: String,
		wanted_tag_ids: Array):
	self.name = name
	self.icon = icon
	self.special_tag_id = special_tag_id
	self.wanted_tag_ids = wanted_tag_ids
	self.selected_tag_ids = []
	# disable this to make the game easier (only have to select special tag)
	self.tag_count_threshold = tag_count_threshold

func has_only_correct_special_tag(all_special_tags: Array) -> bool:
	for tag_id in selected_tag_ids:
		if tag_id in all_special_tags and tag_id != special_tag_id:
			return false
	return special_tag_id in selected_tag_ids

func has_enough_other_tags() -> bool:
	var max_allowed = wanted_tag_ids.size() + tag_count_threshold + 1
	var too_many_unwanted = selected_tag_ids.size() > max_allowed
	if too_many_unwanted:
		return false

	var wanted_tags_selected = 0
	for wanted_tag_id in wanted_tag_ids:
		if wanted_tag_id in selected_tag_ids:
			wanted_tags_selected += 1
	return wanted_tags_selected >= tag_count_threshold
