class_name Rocks extends Node2D

@onready var character:Node2D = get_parent().get_node("./Character")

@onready var windowSize = get_window().size

const STEP_WIDTH = 100
const STEP_HIEGHT = 70

func _ready():
	while self.get_count_rock() < 10:
		var rocksClass = TakeRocksGenerator.new()
		var rock = rocksClass.get_rock()
		rock.global_position = self.find_position(rock)
		Variables.keyTakeFree.remove_at(Variables.keyTakeFree.find(rock.keyCode))
		Variables.keyTakeNoFree.push_back(rock.keyCode)
		add_child(rock)

func get_count_rock():
	return len(get_tree().get_nodes_in_group('rock_take'))

func find_position(rock:TakeRock):
	var returnPosition:Vector2
	if self.get_count_rock() == 0:
		returnPosition.x = character.global_position.x - 50
		returnPosition.y = character.global_position.y - 50
	else:
		for oneRock in get_tree().get_nodes_in_group('rock_take'):
			var lastRockPositon:Vector2 = get_tree().get_nodes_in_group('rock_take')[self.get_count_rock()-1].global_position
			var currenPosition:bool = false
			while(!currenPosition):
				randomize()
				var randX = randi_range(lastRockPositon.x - self.STEP_WIDTH, lastRockPositon.x + self.STEP_WIDTH)
				var randY = randi_range(lastRockPositon.y - rock.get_rock_size().y, lastRockPositon.y - rock.get_rock_size().y - self.STEP_HIEGHT)
				returnPosition.x = randX
				returnPosition.y = randY
				currenPosition = true
			print_debug(windowSize)
			print_debug(rock.get_rock_size())
	return returnPosition
