extends KinematicBody2D

const ACCELERATION = 600
const MAX_SPEED = 200
var velocity = Vector2()
var item_name

var player = null
var being_picked_up = false

func _ready():
	item_name = "Potato"
	$AnimationPlayer.play("Float")
	
func _physics_process(delta):
	if being_picked_up == false:
		velocity = Vector2()
	else:
		queue_free()
		
		#var direction = global_position.direction_to(player.global_position)
		#velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
		
		#var distance = global_position.distance_to(player.global_position)
		#if distance < 3:
			#queue_free()
	#velocity = move_and_slide(velocity, Vector2())
	
	#The code above could be used if you want the item to fly towards the player when being picked up.
	#Fix the code, or else you'll have flying potatoes. (Right now the item simply disappears when picked up.)

func pick_up_item(body):
	player = body
	being_picked_up = true
