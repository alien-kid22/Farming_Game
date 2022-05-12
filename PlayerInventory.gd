extends Node

const NUM_INVENTORY_SLOTS = 9
const SlotClass = preload("res://Inventory/Slot.gd")
const ItemClass = preload("res://Item/Item.gd")

var inventory = {
	0: ["Potato", 5],
	1: ["Potato Seeds", 5],
	2: ["Potato Seeds", 2],
}

signal no_more_items

func add_item(item_name, item_quanity):
	for item in inventory:
		if inventory[item][0] == item_name:
			var stack_size = int(JsonData.item_data[item_name]["StackSize"])
			var able_to_add = stack_size - inventory[item][1]
			if able_to_add:
				inventory[item][1] += item_quanity
				update_slot_visual(item, inventory[item][0], inventory[item][1])
				return
			else:
				inventory[item][1] += able_to_add
				update_slot_visual(item, inventory[item][0], inventory[item][1])
				item_quanity - item_quanity - able_to_add
			
	for i in range(NUM_INVENTORY_SLOTS):
		if inventory.has(i) == false:
			inventory[i] = [item_name, item_quanity]
			update_slot_visual(i, inventory[i][0], inventory[i][1])
			return

func update_slot_visual(slot_index, item_name, new_quanity):
	var slot = get_tree().root.get_node("/root/Farm/CanvasLayer/Inventory/GridContainer/Slot" + str(slot_index + 1))
	if slot.item != null:
		slot.item.set_item(item_name, new_quanity)
	else:
		slot.initialize_item(item_name, new_quanity)

func add_item_to_empty_slot(item: ItemClass, slot: SlotClass):
	inventory[slot.slot_index] = [item.item_name, item.item_quanity]

func remove_item(slot: SlotClass):
	inventory.erase(slot.slot_index)
	
func add_item_quanity(slot: SlotClass, quanity_to_add: int):
	inventory[slot.slot_index][1] += quanity_to_add
	
#func clear_item(slot: SlotClass):
#	slot.clearSlot()
###	for item in inventory:
###		var item_quanity = inventory[item][1]
###		if item_quanity == 1:
###			slot.item = null
###			slot.item.queue_free()
###			update_slot_visual(item, inventory[item][0], inventory[item][1])

#This func will probably not work in this node. I'm putting a similar node in the main inventory node.
	
func _input(event):
	var slot = SlotClass
	if event is InputEventKey:
		if event.scancode == KEY_R and event.pressed: #and farm.tile_id == 31:
			for item in inventory:
				var item_name = inventory[item][0]
				var item_quanity = inventory[item][1]
				var quanity_to_remove = 1
				if item_name == "Potato Seeds" and item_quanity >= 1:
					var stack_size = int(JsonData.item_data[item_name]["StackSize"])
					inventory[item][1] -= quanity_to_remove
					update_slot_visual(item, inventory[item][0], inventory[item][1])
					return
				elif item_name == "Potato Seeds" and item_quanity == 0:
					emit_signal("no_more_items")
					print("item quanity = 0")
					return
#THIS CODE REMOVES SEEDS WHEN THE PLANT BUTTON IS PRESSED.
