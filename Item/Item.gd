extends Node2D

var item_name
var item_quanity

func _ready():
	var randi_val = randi() % 2
	if randi_val == 0:
		item_name = "Potato"
	else:
		item_name = "Potato Seeds"
		
	$TextureRect.texture = load("res://Assets/" + item_name + ".png")
	var stack_size = int(JsonData.item_data[item_name]["StackSize"])
	item_quanity = randi() % stack_size + 1
	
	if stack_size == 1:
		$Label.visible = false
	else:
		$Label.visible = true
		$Label.text = String(item_quanity)
		
func set_item(nm, qt):
	item_name = nm
	item_quanity = qt
	$TextureRect.texture = load("res://Assets/" + item_name + ".png")
	
	var stack_size = int(JsonData.item_data[item_name]["StackSize"])
	if stack_size == 1:
		$Label.visible = false
	else:
		$Label.visible = true
		$Label.text = String(item_quanity)
		
func add_item_quanity(amount_to_add):
	item_quanity += amount_to_add
	$Label.text = String(item_quanity)
	
func decrease_item_quanity(amount_to_remove):
	item_quanity -= amount_to_remove
	$Label.text = String(item_quanity)
