extends Node

export(String) var site_id

var discovered: bool = false

func _on_Area_body_entered(body):
	if body.is_in_group("player"):
		if !discovered:
			discovered = true
			SiteTagging._on_site_site_discovered(site_id)

func _on_Area_body_exited(body):
	pass
