extends Node

export(String) var mural_id
export(String) var site_id

func _on_Area_body_entered(body):
	if body.is_in_group("player"):
		MuralInteraction.approach_mural(site_id, mural_id)

func _on_Area_body_exited(body):
	if body.is_in_group("player"):
		MuralInteraction.leave_mural(site_id, mural_id)
