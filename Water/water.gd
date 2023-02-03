extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_swimmable_body_entered(body):
	if body.is_in_group("player"):
		body.toggle_water()


func _on_swimmable_body_exited(body):
	if body.is_in_group("player"):
		body.toggle_water()


func _on_viewwater_body_entered(body):
	if body.is_in_group("player"):
		body.velocity.y = -5
		body.toggle_waterview()


func _on_viewwater_body_exited(body):
	if body.is_in_group("player"):
		body.velocity.y = 5
		body.toggle_waterview()
