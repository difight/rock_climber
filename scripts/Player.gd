extends Node2D

onready var Right_Hand:RigidBody2D = get_node("Right_Hand")
onready var Left_Hand:RigidBody2D = get_node("Left_Hand")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
func _init():
	Busevents.connect("go_to_rock", self, "_on_Go_To_Rock")

# Called when the node enters the scene tree for the first time.
func _process(delta):
	#Right_Hand.linear_velocity = Vector2.RIGHT * 500
	pass # Replace with function body.

func _on_Go_To_Rock(current):
	var positionTarget = current.get_position()
	if positionTarget:
		var target_vector = Vector2(current.get_position().x, current.get_position().y)
		var current_hand = find_nearest_hand(positionTarget)
		Right_Hand.set_axis_velocity(target_vector)
# Called every frame. 'delta' is the elapsed time since the previous frame.

func find_nearest_hand(position:Vector2) -> RigidBody2D :
	var raz = Right_Hand.get_position() - position
	#print(raz)
	return Right_Hand
#func _process(delta):
#	pass
