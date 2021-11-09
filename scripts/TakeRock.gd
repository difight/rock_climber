extends Node2D

onready var TakeRock:Area2D = get_node("Area2D")
onready var Images:Sprite = get_node("pngegg")

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
	var pinjoin = Joint2D.new()
	print(TakeRock.get_path().get_as_property_path())
	var path_body = body.get_path()
	
	TakeRock.add_child(pinjoin)
	pinjoin.node_a = path_body
	
	pass # Replace with function body.
