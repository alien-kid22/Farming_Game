extends TileMap

onready var player = $Player
var tile_pos_infront_of_player

var crop_data = {"pk": 1,
				"object_name": "Potato",
				"phase_days": [1,2,2,2,INF],
				"current_phase": 0,
				"day_of_current_phase": 0,
				"crop_age": 0}

func _ready():
	Time.connect("refresh_tiles", self, "refresh_tiles")
	pass # Replace with function body.

func _physics_process(delta):
	if player:
		var player_pos = player.global_position
		var tile_pos_player_is_on = world_to_map(player_pos)
		tile_pos_infront_of_player = tile_pos_player_is_on + player.face_direction
		$GridHelper.global_position = tile_pos_infront_of_player * 16
		
func refresh_tiles():
	var watered_dirt = get_used_cells_by_id(CONSTANTS.WATERED_DIRT_ID)
	for tile_pos in watered_dirt:
		set_cellv(tile_pos, get_tileset().find_tile_by_name(CONSTANTS.SCRATCHED_DIRT_NAME))

func _input(event):
	if event.is_action_pressed("Plant"):
		var crop_path = "res://Crops/Potato.tscn"
		var crop = load(crop_path).instance()
		crop.initialize(crop_data)
		crop.global_position = tile_pos_infront_of_player * 16
		add_child(crop)
		
	elif event.is_action_pressed("Hoe"):
		if self.get_cellv(tile_pos_infront_of_player) == CONSTANTS.DIRT_ID:
			self.set_cellv(tile_pos_infront_of_player, self.get_tileset().find_tile_by_name(CONSTANTS.SCRATCHED_DIRT_NAME))
	
	elif event.is_action_pressed("Water"):
		if self.get_cellv(tile_pos_infront_of_player) == CONSTANTS.SCRATCHED_DIRT_ID:
			self.set_cellv(tile_pos_infront_of_player, self.get_tileset().find_tile_by_name(CONSTANTS.WATERED_DIRT_NAME))		
