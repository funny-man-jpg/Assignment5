extends Node

@export var cars: PackedScene
var money = 10.0
var regularHouseCount = 0
var doubleHouseCount = 0
var threeHouseCount = 0
var woodCount = 0
var stoneCount = 0
var buildable = true
var idSetter = 0
var plots = []
var time = 40
var quota = 50.0
var value = 0.0
var cycles = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	plots = get_tree().get_nodes_in_group("Plots")
	for i in plots:
		i.connect("build", plot_built)
	$moneyTimer.start()
	$quotaTimer.start()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if woodCount < 3 or stoneCount < 1:
		buildable = false
	else:
		buildable = true
	for i in plots:
		i.set_buildable(buildable)
	#print(buildable)
	$Player/Camera2D/Money.text = "Money: $" + str(money)
	$Player/Camera2D/Wood.text = "Wood: " + str(woodCount)
	$Player/Camera2D/Stone.text = "Stone: " + str(stoneCount)
	$Player/Camera2D/Timer.text = "Time: " + str(time) + " s"
	$Player/Camera2D/Amount.text = "Quota: $" + str(quota)
	$Player/Camera2D/Cycles.text = "Cycle:" + str(cycles)


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


func _on_wood_store_body_entered(area):
	if money > 0:
		money -= 1
		woodCount += 2
		$woodStore.buy()


func _on_timer_timeout():
	money += 1 * regularHouseCount
	money += 4 * threeHouseCount
	money += 2 * doubleHouseCount
	print(money)
	print(woodCount)
	print(stoneCount)
	print(buildable)
	print("value"+str(value))

func _on_stone_store_body_entered(area):
	if money > 1:
		money -= 2
		stoneCount += 1
		$stoneStore.buy()

func stun():
	$Player.hitByCar()


func _on_car_timer_timeout():
	var car = cars.instantiate()
	car.connect("hit", stun)
	# taken from godot tutorial
	var car_spawn_location = $carPath/carSpawn
	car_spawn_location.progress_ratio = randf()
	car.position = car_spawn_location.position
	var direction = car_spawn_location.rotation + PI / 2
	add_child(car)

func _on_time_clock_timeout():
	if(time>0):
		time -= 1
		print(time)
	
func _on_quota_progress_timeout():
	value = (money/quota)*100/2
	$Player/Camera2D/Quota.value = value
	if(money>=quota):
		quota*=4
		cycles+=1
		time=50-(5*cycles)
	elif(time == 0):
		money = 0
		get_tree().reload_current_scene()
