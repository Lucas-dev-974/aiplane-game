extends Camera3D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var tween = create_tween()
	if Input.is_action_pressed("ui_up"):
		tween.tween_property(self, 'position:y', 6, 0.5)
	if Input.is_action_pressed("ui_down"):
		tween.tween_property(self, 'position:y', 3, 0.5)
