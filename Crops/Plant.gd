extends StaticBody2D

var farm_map

export (int) var pk = 1
export (String) var object_name = ""
export (int) var current_phase = 0 # Seed Phase
export (int) var day_of_current_phase = 0
export (int) var crop_age = 0 
export (bool) var dead = false

func _ready():
	farm_map = get_parent()

func initialize(data):
	farm_map = get_parent()
	pk = data.get("pk")
	object_name = data.get("object_name")
	current_phase = data.get("current_phase")
	day_of_current_phase = data.get("day_of_current_phase")
	crop_age = data.get("crop_age")
	
	return data
	
func check_dirt_status():
	var dirt_pos = farm_map.world_to_map(position)
	var dirt_id = farm_map.get_cellv(dirt_pos)
	print("dirt_id:", dirt_id)
	# Crop get cluttered
	if dirt_id == 33:
		crop_age += 1
		day_of_current_phase += 1
	else:
		pass # leave more space for extension.
		
#	var planting_id = 1331
#	var cell_pos = farm_map.world_to_map(get_global_mouse_position())
#	var tile_id = farm_map.get_cellv(cell_pos)
#	var tile_name = farm_map.get_tileset().find_tile_by_name()
#	if tile_id == 31 or 32 or 33:
#		print("Seeds have been planted")
#	else:
#		print("This is not dirt!")

func check_plant_status(phase_days):
	var required_days = phase_days[current_phase]
	if day_of_current_phase == required_days:
		current_phase += 1
		day_of_current_phase = 0
	
	var anim = str(current_phase)
	if current_phase == 0:
		$Shape.disabled = true
	else:
		$Shape.disabled = true
		
	$Anim.play(anim)
	
	if current_phase == 4:
		print("current phase = 4" , global_position)
		var plant_pos = global_position
		print("plant_pos", plant_pos)
		SignalManager.emit_signal("harvest_plant")
		return(plant_pos)
		#this code works
		
#func check_if_planted():
#	var dirt_pos = farm_map.world_to_map(position)
#	var dirt_id = farm_map.get_cellv(dirt_pos)
#	var planting_id = 1331
#	if dirt_id == 31 or 32 or 33 and planting_id == 1331:
#		print("Seeds have been planted")
#	else:
#		pass
