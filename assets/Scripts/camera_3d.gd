extends Camera3D

var plane 
var lateralTween: Tween
func _ready() -> void:
	plane = self.get_parent().find_children("Plane")


func _process(delta: float) -> void:
	var tween = create_tween()
	tween.tween_property(self, 'position:z', plane[0].position.z, 0.1)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _input(event: InputEvent) -> void:
	var tween = create_tween()
	if Input.is_action_pressed("ui_up"):
		tween.tween_property(self, 'position:y', 6, 0.5)
	if Input.is_action_pressed("ui_down"):
		tween.tween_property(self, 'position:y', 3, 0.5)
		
