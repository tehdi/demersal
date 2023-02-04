extends Node

func approach_mural(site_id: String, mural_id: String):
	print("player is approaching mural {mural_id} at site {site_id}".format(
		{"mural_id": mural_id, "site_id": site_id}))

func leave_mural(site_id: String, mural_id: String):
	print("player is leaving the area of mural {mural_id} at site {site_id}".format(
		{"mural_id": mural_id, "site_id": site_id}))
