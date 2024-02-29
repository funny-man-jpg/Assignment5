extends Area2D

signal hit
@export var speed = 400
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
		#apply_central_impulse(Vector2(speed * delta, 0))
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
		#apply_central_impulse(Vector2(-(speed * delta), 0))
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
		#apply_central_impulse(Vector2(0, speed * delta))
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
		#apply_central_impulse(Vector2(0, -(speed * delta)))
		
		
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, get_viewport_rect().size)
	# Old system moved your position, which let you literally clip through walls
