extends Node2D

onready var Right_Hand:RigidBody2D = get_node("Right_Hand")

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
	if current.position:
		print(current.global_position)
		var target_vector = Vector2(current.global_position)
		Right_Hand.linear_velocity = target_vector
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
