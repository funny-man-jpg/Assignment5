extends Area2D

signal build
@export var houseType = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.set_frame(0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_entered(area):
	build.emit()
	$AnimatedSprite2D.set_frame(1)

