extends KinematicBody2D

# Константы
const GRAVITY: int = 10
const FLOOR: Vector2 = Vector2(0, -1)

# Переменные
var velocity: Vector2 = Vector2(0, 0)


func _physics_process(delta):
	
	self.velocity.y += GRAVITY * delta
	move_and_collide(self.velocity)


