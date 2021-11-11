extends Node2D

onready var TakeRock:RigidBody2D = get_node("RigidBody2D")
onready var Images:Sprite = get_node("RigidBody2D/Pngegg")
var pinjoin = PinJoint2D.new()
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _init():	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("ui_take"):
		Busevents.emit_signal("go_to_rock", self)

func _on_Area2D_body_entered(body):
	if Input.is_action_pressed("ui_take"):
		pinjoin.node_a = body.get_path()
		pinjoin.node_b = TakeRock.get_path()
		add_child(pinjoin)
		print(pinjoin.get_path())
		print(body.get_path())
		print(TakeRock.get_path())
	else:
		remove_child(pinjoin)
		print('remove')
