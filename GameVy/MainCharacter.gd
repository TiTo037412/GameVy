extends CharacterBody2D

const max_speed = 150
const accel = 400
const friction = 3000
const face_dir = ""

var input = Vector2.ZERO
var curr_state = "Walk_Down"

func _physics_process(delta):
	player_movement(delta)
	update_facing()
	$AnimatedSprite2D.play(curr_state)
	
func get_input():
	input.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	input.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	return input.normalized()

func update_facing():
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
 
	velocity = velocity.normalized() * max_speed
 
	if(velocity.x > 0 && velocity.y == 0):
		curr_state = "Walk_Right_Walking"
 
	if(velocity.x < 0 && velocity.y == 0):
		curr_state = "Walk_Left_Walking"
 
	if(velocity.y > 0):
		if(velocity.x == 0):
			curr_state = "Walk_Down_Walking"
		elif (velocity.x > 0):
			curr_state = "Walk_Right_Diag"
		else:
			curr_state = "Walk_Left_Walking"

	if(velocity.y < 0):
		if(velocity.x == 0):
			curr_state = "Walk_Up"
		elif (velocity.x > 0):
			curr_state = "Walk_Right_Diag"
		else:
			curr_state = "Walk_Left_Diag"
	
	if velocity == Vector2.ZERO:
		if curr_state == "Walk_Right_Walking":
			curr_state = "Walk_Right"
		if curr_state == "Walk_Left_Walking":
			curr_state = "Walk_Left"
		if curr_state == "Walk_Down_Walking":
			curr_state = "Walk_Down"
	
	#print (curr_state)
func player_movement(delta):
	input = get_input()
	
	if input == Vector2.ZERO:
		if velocity.length() > (friction * delta):
			velocity -= velocity.normalized() * (friction * delta)
		else:
			velocity = Vector2.ZERO
	else:
		velocity += (input * accel * delta)
		velocity = velocity.limit_length(max_speed)
	
	move_and_slide()
