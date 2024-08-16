extends TextureRect


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var layout = self.size
	pivot_offset.x =  layout[0] / 2
	pivot_offset.y =  layout[1] / 2 + 35
	
	print(pivot_offset)
