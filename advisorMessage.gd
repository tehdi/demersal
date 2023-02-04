extends Spatial

var explored = false

#Contains messages that the advisor states

export(bool) var timer_based = false
export(float) var timeAmount = 10

export(Array, String, MULTILINE) var textboxes
export(Array, String, "Neutral", "Angry", "Curious","Worried") var expressions

var remain = false

var rememberBody

func _ready():
	if timer_based:
		$Timer.wait_time = timeAmount
		$Timer.start()
		

func sendMessage(bodyGet):
	bodyGet.advisor.messageGiven = textboxes
	bodyGet.advisor.givenExpression = expressions
	bodyGet.advisor.openMessage()

func _on_Area_body_entered(body):
	if body.is_in_group("player"):
		remain = true
		if !explored and !timer_based:
			sendMessage(body)
			explored = true
		if timer_based:
			rememberBody = body


func _on_Timer_timeout():
	if !explored and timer_based:
		if remain:
			sendMessage(rememberBody)
			explored = true


func _on_Area_body_exited(body):
	remain = false
