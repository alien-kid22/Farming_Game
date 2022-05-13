extends TileMap

onready var player = $Player
var tile_pos_infront_of_player
onready var _tilemap = "res://Farm/Farm.tres"
const SlotClass = preload("res://Inventory/Slot.gd")
const ItemClass = preload("res://Item/Item.gd")
var ItemDropPath = "res://ItemDrop/ItemDrop.tscn"
var PlantPath = load("res://Crops/Plant.tscn")
var crop_data = {"pk": 1,
				"object_name": "Potato",
				"phase_days": [1,2,2,2,INF],
				"current_phase": 0,
				"day_of_current_phase": 0,
				"crop_age": 0}

var inventory = {
	0: ["Potato", 5],
	1: ["Potato Seeds", 5],
	2: ["Potato Seeds", 2],
}

func _ready():
	Time.connect("refresh_tiles", self, "refresh_tiles")
	SignalManager.connect("harvest_plant", self, "_on_Plant_harvest_plant")
	pass # Replace with function body.
	
func _physics_process(delta):
	if player:
		var player_pos = player.global_position
		var tile_pos_player_is_on = world_to_map(player_pos)
		tile_pos_infront_of_player = tile_pos_player_is_on + player.face_direction
		
func refresh_tiles():
	var watered_dirts = get_used_cells_by_id(33)
	for tile_pos in watered_dirts:
		set_cellv(tile_pos, get_tileset().find_tile_by_name("scratched_dirt"))

func _input(event):
	var new_seed_pos = world_to_map(get_global_mouse_position())
	var tileset_id = get_cellv(new_seed_pos)
	# ^ these are throwaway vars, don't use them again.
	if event.is_action_pressed("Plant") and tileset_id == 31:
		var mouse_pos = get_viewport().get_mouse_position()
		print(mouse_pos)
		var crop_id = get_instance_id()
		print(crop_id)
		var cell_pos = world_to_map(get_global_mouse_position())
		var crop_path = "res://Crops/Potato.tscn"
		var crop = load(crop_path).instance()
		crop.initialize(crop_data)
		crop.global_position = get_global_mouse_position()
		add_child(crop)
<<<<<<< Updated upstream
=======
		#get_instance_id()         #instance id = 1372
>>>>>>> Stashed changes
			
	elif event.is_action_pressed("Hoe"):
		if event is InputEventMouseButton:
			if event.button_index == BUTTON_LEFT and event.pressed:
				var mouse_pos = get_viewport().get_mouse_position()
				print(mouse_pos)
				var cell_pos = world_to_map(get_global_mouse_position())
				var tile_id = get_cellv(cell_pos)
				print("tile id:", tile_id)
				var tile_name = self.get_cellv(cell_pos)
					
				if tile_id == 31:
					self.set_cellv(cell_pos, self.get_tileset().find_tile_by_name("scratched_dirt"))
		
	elif event.is_action_pressed("Water"):
		var cell_pos = world_to_map(get_global_mouse_position())
		var tile_id = get_cellv(cell_pos)
		print(tile_id)
		var tile_name = self.get_cellv(cell_pos)
		if tile_id == 32:
			self.set_cellv(cell_pos, self.get_tileset().find_tile_by_name("watered_dirt"))

	elif event.is_action_pressed("Sickle"):
		var cell_pos = world_to_map(get_global_mouse_position())
		var mouse_pos = get_viewport().get_mouse_position()
		print("cell_pos:", cell_pos)
		print("mouse pos:", mouse_pos)
		
		var crop_path = "res://Crops/Potato.tscn"
		var crop = load(crop_path).instance()
		var current_phase = crop_data.get("current_phase")
		crop.initialize(crop_data)
		
		print(mouse_pos)
		print("plant current_phase:", current_phase)
		
		if crop.current_phase == 1:
			var item_drop = load(ItemDropPath).instance()
			item_drop.global_position = get_global_mouse_position()
			add_child(item_drop) 
			
#NEEDED TO CHANGE SCENES FOR THE PLANT PROBLEM. HERE IS CODE THAT
#WILL FIX IT.

func _on_Plant_harvest_plant():
	print("plant is able to be harvested")
