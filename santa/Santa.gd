extends CharacterBody2D
#
#class_name santa
#@export var speed = 400
#@onready var animated_sprite = $AnimatedSprite2D
#@onready var SantaCollision = $SantaCollision
#@onready var TouchGiftCollision = $TouchGiftCollision
#
#var giftpoints = 0
#
#func get_input():
#	# get input vector based on two axes: left-right and up-down	
#	var input_direction = Input.get_vector("left", "right", "up", "down")
#	# increase the vector’s length by speed
#	velocity = input_direction * speed
#
#func _physics_process(delta):
#	get_input()
#	# move player based on the velocity that we set above
#	move_and_slide()
#
#func _process(_delta):
#	SantaCollision.disabled = false
#	TouchGiftCollision.disabled = true
#	if Input.is_action_pressed("right"):
#		SantaCollision.disabled = false
#		TouchGiftCollision.disabled = true
#		animated_sprite.flip_h = true
#		animated_sprite.play("default")
#	elif Input.is_action_pressed("left"):
#		SantaCollision.disabled = false
#		TouchGiftCollision.disabled = true
#		# run to the left
#		animated_sprite.flip_h = false
#		animated_sprite.play("default")
#	else:
#		SantaCollision.disabled = false
#		TouchGiftCollision.disabled = true
#		animated_sprite.stop()
#	if Input.is_action_pressed("reset_gift"):
#		SantaCollision.disabled = true
#		TouchGiftCollision.disabled = false
#
#func _on_gift_a_1_body_entered(body):
#	if Input.is_action_pressed("reset_gift"):
#		print("선물 구함")
#
#func _on_gift_a_point_label_complete_gift_a():
#	giftpoints += 1
#
#func _on_gift_b_point_label_complete_gift_b():
#	giftpoints += 1
#
#func _on_gift_c_point_label_complete_gift_c():
#	giftpoints += 1
#
#func _on_finish_area_body_entered(body):
#	if body is santa && giftpoints>=1:
#		get_tree().change_scene_to_file("res://level/Level2.tscn")
