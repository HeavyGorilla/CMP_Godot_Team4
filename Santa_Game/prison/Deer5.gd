extends Sprite2D
signal complete_animate1

func _on_player_1_resque_prison_5():
	var happyRudolph = load("res://image/rudolph_happy.png")
	self.texture = happyRudolph
	animate1()

func animate1():
	var tween = create_tween()
	tween.tween_property(self, "rotation_degrees", 360, 1).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	emit_signal("complete_animate1")

func _on_complete_animate_1():
	var tween = create_tween()
	var smoke = load("res://image/smoke.png")
	tween.tween_property(self, "texture", smoke, 0.5)
	tween.tween_property(self, "scale", Vector2(), 1)
#	tween.tween_property(self, "scale", Vector2(1,1), 1)
#	self.queue_free()
