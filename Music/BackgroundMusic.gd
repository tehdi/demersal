extends Node


func play(track_index):
	for track in get_children():
		track.stop()
		
	var track_to_play = get_child(track_index)
	track_to_play.volume_db = 0
	track_to_play.play()
	
func crossfade(track_index):
	for i in range(get_child_count()):
		var audio_streamer = get_child(i)
		var tween = audio_streamer.get_node("Tween")
		if i == track_index:
			tween.interpolate_property(audio_streamer, "volume_db", audio_streamer.volume_db, 0, 0.5)
			tween.start()
			audio_streamer.play()
		else:
			tween.interpolate_property(audio_streamer, "volume_db", audio_streamer.volume_db, -80, 0.5)
			tween.start()
