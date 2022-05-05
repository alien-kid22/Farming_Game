extends KinematicBody2D

var velocity = Vector2()
var max_speed = 150
var face_direction = Vector2(0, 1)
var screen_size

# State Machine
enum STATES {WALK, IDLE}
var state = 1 # 1 means IDLE, index of states, default

onready var anim = $AnimatedSprite

func _ready():
	_change_state(STATES.IDLE)
	
func _change_state(new_state):
	# What you want player to do when they switch to new state
	match new_state:
		STATES.IDLE:
			velocity = Vector2()
		STATES.WALK:
			pass
	state = new_state

func get_input_direction():
	var input_direction = Vector2(
		int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left")),
		int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
		)
	return input_direction

func _physics_process(delta):
	match state:
		STATES.IDLE:
			# check if player has movement action when in IDLE
			var input_direction = get_input_direction()
			if input_direction:
				_change_state(STATES.WALK)
				return
				
			if face_direction.y == -1 and face_direction.x in [1, 0]:
				$AnimatedSprite.play("Idle Up")
			elif face_direction.y == 1 and face_direction.x in [-1, 0]:
				$AnimatedSprite.play("Idle Down")
			elif face_direction.x == 1 and face_direction.y in [0, 1]:
				$AnimatedSprite.play("Idle Right")
			elif face_direction.x == -1 and face_direction.y in [0, -1]:
				$AnimatedSprite.play("Idle Left")
			
		STATES.WALK:
			# check if player has no movement
			var input_direction = get_input_direction()
			if not input_direction:
				_change_state(STATES.IDLE)
				return
			if input_direction.y == -1 and input_direction.x in [1, 0]:
				$AnimatedSprite.animation = "Walk Up"
			elif input_direction.y == 1 and input_direction.x in [-1, 0]:
				$AnimatedSprite.animation = "Walk Down"
			elif input_direction.x == 1 and input_direction.y in [0, 1]:
				$AnimatedSprite.animation = "Walk Right"
			elif input_direction.x == -1 and input_direction.y in [0, -1]:
				$AnimatedSprite.animation = "Walk Left"
			input_direction = input_direction.normalized()
			face_direction = input_direction
			velocity = input_direction * max_speed
			
			position += velocity * delta
			position.x = clamp(position.x, -10, 750)
			position.y = clamp(position.y, -150, 400)
			
			
			move_and_slide(velocity, Vector2())
			return

func _input(event):
	if event.is_action_pressed("Pickup"):
		if $PickupZone.items_in_range.size() > 0:
			var pickup_item = $PickupZone.items_in_range.values()[0]
			pickup_item.pick_up_item(self)
			$PickupZone.items_in_range.erase(pickup_item)
