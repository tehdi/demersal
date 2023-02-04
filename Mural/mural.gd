extends Node

func _on_Area_body_entered(body):
	if body.is_in_group("player"):
		$"/root/MuralInteraction".approach_mural(self.get_parent().name)


func _on_Area_body_exited(body):
	if body.is_in_group("player"):
		$"/root/MuralInteraction".leave_mural(self.get_parent().name)
