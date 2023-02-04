extends Node

export(String) var mural_id
export(String) var site_id

var discovered: bool = false

func _on_Area_body_entered(body):
	if body.is_in_group("player"):
		if !discovered:
			# prompt the player to push a button to interact with the mural
			body.approach_mural(self)

func _on_Area_body_exited(body):
	if body.is_in_group("player"):
		body.leave_mural()

func discover():
	discovered = true
	SiteTagging._on_mural_mural_discovered(mural_id)
