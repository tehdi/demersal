extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var messageGiven = ["You should not be seeing this test message, what are you the game developer?"]

var speaking = false
var messageIndex = 0
onready var message = $baseUI/textMessage

var givenExpression = []

# Called when the node enters the scene tree for the first time.
func _ready():
	$Viewport.own_world = true
	resetText()
	message.text = messageGiven[messageIndex]
	
func resetText():
	message.visible_characters = 0
	
func openMessage():
	$messageBoxAnim.play("openMessage")
	messageIndex = 0
	message.text = messageGiven[messageIndex]
	$Viewport/eyebrowPlayer.play(givenExpression[messageIndex])

func startSpeaking():
	resetText()
	speaking = true
	
func _on_Timer_timeout():
	if speaking:
		if message.percent_visible <= 1:
			message.visible_characters += 1
		else:
			#When text is finished 
			if messageIndex < messageGiven.size()-1:
				#Advance to next textbox
				messageIndex += 1
				$Viewport/eyebrowPlayer.play(givenExpression[messageIndex])
				resetText()
				message.text = messageGiven[messageIndex]
			else:
				#Close if this is the last message.
				resetText()
				$messageBoxAnim.play("closeMessage")
				speaking = false
				
				
				
#			message.text = messageGiven[messageIndex]
#			speaking = false
#			$Viewport/mouthPlayer.play("idle")
