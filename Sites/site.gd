extends Node

export(String) var site_id
export(int) var track_index = 1

var discovered: bool = false

func _on_Area_body_entered(body):
	if body.is_in_group("player"):
		BackgroundMusic.crossfade(track_index)
		
		if !discovered:
			discovered = true
			SiteTagging._on_site_site_discovered(site_id)

func _on_Area_body_exited(body):
	pass
