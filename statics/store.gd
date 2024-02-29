extends Area2D
@export var storeType = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.set_frame(storeType)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func buy():
	$AudioStreamPlayer2D.play()

