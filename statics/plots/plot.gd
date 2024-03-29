extends Area2D

signal build(houseType)
@export var houseType = 0
var isBuildable = false
var built = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.set_frame(0)
	add_to_group("Plots")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_buildable(setBool):
	isBuildable = setBool

func _on_body_entered(area):
	if isBuildable == true and built == false:
		$AnimatedSprite2D.set_frame(1)
		build.emit(houseType)
		$AudioStreamPlayer2D.play()
		built = true
