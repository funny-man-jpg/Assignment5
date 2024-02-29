extends Node

var money = 10
var regularHouseCount = 0
var doubleHouseCount = 0
var threeHouseCount = 0
var woodCount = 0
var stoneCount = 0
var buildable = true
var idSetter = 0
var plots = []

# Called when the node enters the scene tree for the first time.
func _ready():
	plots = get_tree().get_nodes_in_group("Plots")
	for i in plots:
		i.connect("build", plot_built)
	$Timer.start()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if woodCount < 3 and stoneCount < 1:
		buildable = false
	else:
		buildable = true
	for i in plots:
		i.set_buildable(buildable)
	#print(buildable)


func plot_built(houseType):
	woodCount -= 3
	stoneCount -= 1
	if houseType == 1:
		regularHouseCount += 1
	elif houseType == 2:
		threeHouseCount += 1
	elif houseType == 3:
		doubleHouseCount += 1
	else:
		#placeholder for mountains
		regularHouseCount += 1
	print(regularHouseCount)


func _on_wood_store_area_entered(area):
	if money > 0:
		money -= 1
		woodCount += 2


func _on_timer_timeout():
	money += 1 * regularHouseCount
	money += 4 * threeHouseCount
	money += 2 * doubleHouseCount
	print(money)
	print(woodCount)
	print(stoneCount)
	print(buildable)


func _on_stone_store_area_entered(area):
	if money > 0:
		money -= 2
		stoneCount += 1
