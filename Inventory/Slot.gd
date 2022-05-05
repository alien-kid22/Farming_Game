extends Panel

var default_tex = preload("res://Assets/default_tex.png")
var empty_tex = preload("res://Assets/empty_tex.png")

var default_style: StyleBoxTexture = null
var empty_style: StyleBoxTexture = null

var ItemClass = preload("res://Item/Item.tscn")
var item = null
var slot_index

func _ready():
	default_style = StyleBoxTexture.new()
	empty_style = StyleBoxTexture.new()
	default_style.texture = default_tex
	empty_style.texture = empty_tex
	
	#if randi() % 2 == 0:
		#item = ItemClass.instance()
		#add_child(item)
	refresh_style()
	
func refresh_style():
	if item == null:
		set('custom_styles/panel', empty_style)
	else:
		set('custom_styles/panel', default_style)

func pickFromSlot():
	remove_child(item)
	var InventoryNode = find_parent("Inventory")
	InventoryNode.add_child(item)
	item = null
	refresh_style()
	
func clearSlot():
	item = null
	remove_child(item)
	refresh_style()
	print("slot has been cleared")
	return
	
func putIntoSlot(new_item):
	item = new_item
	item.position = Vector2(0, 0)
	var InventoryNode = find_parent("Inventory")
	InventoryNode.remove_child(item)
	add_child(item)
	refresh_style()

func initialize_item(item_name, item_quanity):
	if item == null:
		item = ItemClass.instance()
		add_child(item)
		item.set_item(item_name, item_quanity)
	else:
		item.set_item(item_name, item_quanity)
	refresh_style()

func check():
	print("slot check works")
