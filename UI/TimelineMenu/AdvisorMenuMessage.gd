extends Node

export (NodePath) var advisor_node_path

export(Array, String, MULTILINE) var textboxes
export(Array, String, "Neutral", "Angry", "Curious","Worried") var expressions

var advisor

func _ready():
	advisor = get_node(advisor_node_path)


func send_message():
	advisor.messageGiven = textboxes
	advisor.givenExpression = expressions
	advisor.openMessage()
