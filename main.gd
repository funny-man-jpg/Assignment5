extends Node

var money = 0
var houseCount = 0
var woodCount = 0
var stoneCount = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	money += 1 * houseCount
	print(money)


func _on_plot_build():
	houseCount += 1
