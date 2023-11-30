extends CharacterBody2D

class_name santa
@export var speed = 400
@onready var animated_sprite = $AnimatedSprite2D
@onready var SantaCollision = $SantaCollision
@onready var TouchGiftCollision = $TouchGiftCollision

var points = 0
var rudolph = 5
var point_per_rudolph = 10

func get_input():
	# get input vector based on two axes: left-right and up-down	
	var input_direction = Input.get_vector("left", "right", "up", "down")
	# increase the vector’s length by speed
	velocity = input_direction * speed

func _physics_process(delta):
	get_input()
	# move player based on the velocity that we set above
	move_and_slide()
		
func _process(_delta):
	SantaCollision.disabled = false
	TouchGiftCollision.disabled = true
	if Input.is_action_pressed("right"):
		SantaCollision.disabled = false
		TouchGiftCollision.disabled = true
		animated_sprite.flip_h = true
		animated_sprite.play("default")
	elif Input.is_action_pressed("left"):
		SantaCollision.disabled = false
		TouchGiftCollision.disabled = true
		# run to the left
		animated_sprite.flip_h = false
		animated_sprite.play("default")
	else:
		SantaCollision.disabled = false
		TouchGiftCollision.disabled = true
		animated_sprite.stop()
	if Input.is_action_pressed("reset_gift"):
		SantaCollision.disabled = true
		TouchGiftCollision.disabled = false


func _on_prison_area_entered(area):
	if Input.is_action_just_pressed("resque"):
			points += point_per_rudolph
			rudolph -= 1
			
