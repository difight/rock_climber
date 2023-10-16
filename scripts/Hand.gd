class_name Hand extends RigidBody2D

@export var connectPin:PinJoint2D
var connectedPosition:Vector2
var rockTake:Node2D = null

func add_connect_to_pin(pin: PinJoint2D):
	self.connectPin = pin

func take_rock(rock: Node2D):
	self.rockTake = rock

func get_free_hand() -> bool:
	if self.rockTake == null:
		return true
	else:
		return false

func free_hand():
	self.rockTake = null

func del_connect_to_pin():
	self.connectPin = null

func _integrate_forces(state):
	if state.get_contact_count() > 0 and state.get_contact_collider_object(0).is_in_group('rocks'):
		connectedPosition = state.get_contact_collider_position(0)
