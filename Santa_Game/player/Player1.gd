extends CharacterBody2D

class_name santa
signal resquePrison1
signal resquePrison2
signal resquePrison3
signal resquePrison4
signal resquePrison5

@onready var animated_sprite = $AnimatedSprite2D
var giftpoints = 0
var is_shooting = false

var is_interacting_with_gift = false

enum Direction { UP, DOWN, LEFT, RIGHT }
var current_direction = Direction.DOWN

var touched_rudolph = null
signal rudolph_rescued

# health
var health = 100

func _ready():
	animated_sprite.connect("animation_finished", Callable(self, "_on_AnimatedSprite2D_animation_finished"))

func _physics_process(_delta):
	velocity = Input.get_vector("left", "right", "up", "down") * 300
	position.x += randi_range(-0.1, 0.1)
	move_and_slide()

	if !is_interacting_with_gift:
		if Input.is_action_pressed("up"):
			current_direction = Direction.UP
			animated_sprite.play("up_walk")
		elif Input.is_action_pressed("down"):
			current_direction = Direction.DOWN
			animated_sprite.play("down_walk")
		elif Input.is_action_pressed("left"):
			current_direction = Direction.LEFT
			animated_sprite.flip_h = false
			animated_sprite.play("left_walk")
		elif Input.is_action_pressed("right"):
			current_direction = Direction.RIGHT
			animated_sprite.flip_h = true
			animated_sprite.play("left_walk")
		else:
			animated_sprite.stop()
		
	if is_interacting_with_gift:
		if not is_shooting:
			if Input.is_action_pressed("up"):
				current_direction = Direction.UP
				animated_sprite.play("up_box")
			elif Input.is_action_pressed("down"):
				current_direction = Direction.DOWN
				animated_sprite.play("down_walk")
			elif Input.is_action_pressed("left"):
				current_direction = Direction.LEFT
				animated_sprite.flip_h = false
				animated_sprite.play("left_box")
			elif Input.is_action_pressed("right"):
				current_direction = Direction.RIGHT
				animated_sprite.flip_h = true
				animated_sprite.play("left_box")
			else:
				animated_sprite.stop()

func _on_gift_a_point_label_complete_gift_a():
	giftpoints += 1

func _on_gift_b_point_label_complete_gift_b():
	giftpoints += 1

func _on_gift_c_point_label_complete_gift_c():
	giftpoints += 1

func _on_finish_area_body_entered(body):
	if body is santa && giftpoints>=3:
		get_tree().change_scene_to_file("res://Game/stage1clear.tscn")

func _on_area_2d_body_entered(body):
	if body.is_in_group("gift"):
		is_interacting_with_gift = true

func _on_area_2d_body_exited(body):
	if body.is_in_group("gift"):
		is_interacting_with_gift = false

func _on_area_2d_area_entered(area):
	if area.is_in_group("prison"):
		print("감옥 터치")
		if touched_rudolph == null:
			touched_rudolph = area

func _on_area_2d_area_exited(area):
	if area.is_in_group("prison"):
		if area == touched_rudolph:
			touched_rudolph = null
			
func _input(event):
	if touched_rudolph != null and event.is_action_pressed("rescue"):
		emit_signal("rudolph_rescued")
		if touched_rudolph == $"../Prison":
			emit_signal("resquePrison1")
		if touched_rudolph == $"../Prison2":
			emit_signal("resquePrison2")
		if touched_rudolph == $"../Prison3":
			emit_signal("resquePrison3")
		if touched_rudolph == $"../Prison4":
			emit_signal("resquePrison4")
		if touched_rudolph == $"../Prison5":
			emit_signal("resquePrison5")
		touched_rudolph.queue_free()
