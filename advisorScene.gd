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
	$Viewport/mouthPlayer.play("speaking")
	
func _on_Timer_timeout():
	if speaking:
		if message.percent_visible <= 1:
			var letters = "aAbBcCdDeEfFGgHhiIjJkKlLmMnNoOpPqQrRsStTuUvVwWxXyYZ"
			if message.visible_characters < message.text.length() and message.text[message.visible_characters] in letters:
				$voiceSound.playSound()
			message.visible_characters += 1
#			print(message.text[message.visible_characters])
		else:
			#When text is finished 
			if messageIndex < messageGiven.size()-1:
				$nextPage.start()
				speaking = false
				$Viewport/mouthPlayer.play("idle")
			else:
				#Close if this is the last message.
				$close.start()
				$Viewport/mouthPlayer.play("idle")
				speaking = false
				
				
				
#			message.text = messageGiven[messageIndex]
#			speaking = false
#			$Viewport/mouthPlayer.play("idle")


func _on_nextPage_timeout():
	#Advance to next textbox
	messageIndex += 1
	$Viewport/eyebrowPlayer.play(givenExpression[messageIndex])
	resetText()
	message.text = messageGiven[messageIndex]
	speaking = true
	$Viewport/mouthPlayer.play("speaking")


func _on_close_timeout():
	resetText()
	$messageBoxAnim.play("closeMessage")
