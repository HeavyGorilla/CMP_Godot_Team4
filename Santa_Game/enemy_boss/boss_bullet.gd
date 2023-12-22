'''
For 'boss_bullet' scene.
This script manages the movement of bullets, handles collisions, and deals damage to the player when a collision occurs.
Bullet Movement and Collision Handling:
	The script controls the movement of a bullet at a specified speed, following a set direction when it's initially fired.
	When the bullet collides with another object, if that object belongs to the "player" group, it inflicts damage on the player and removes the bullet.
'''

extends Area2D

@export var damage = 20
@export var speed = 500  # Bullet Speed
var direction = Vector2.ZERO  # Set direction of the bullet 
var is_direction_set = false # To ensure that the direction remains unchanged during straight-line firing

func _ready():
	pass

func set_direction(new_direction: Vector2):
	if not is_direction_set:
		direction = new_direction.normalized()
		rotation = direction.angle()
		is_direction_set = true

func _process(delta):
	if is_direction_set:
		position += direction * speed * delta

func _on_body_entered(body):
	if body.is_in_group("player"):
		# Collision with 'player'
		# Damage player logic
		print(body.name)
		body.take_damage(damage)
		queue_free()
	else:
		queue_free()
