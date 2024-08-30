extends Node3D

@onready var level = $".."

signal on_percuted_cloud
var firstDrop = false


var shape = SphereShape3D.new() 
var query = PhysicsShapeQueryParameters3D.new()
var result 

func _ready() -> void:
	var myPosition = global_position
	var parentChilds = self.get_parent().get_children()
	
	var childs = []
	for child in parentChilds:
		if child.is_class("Area3D"):
			childs.append(child)
			
	for child in childs:
		if  child != self:
			if child.global_position == myPosition:
				queue_free()
				
				
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x -= Global.move_speed * delta
	if position.x < -30: 	
		#level.lastPositionX = position.x
		queue_free()
		return 
	
		
func _on_body_entered(body: Node3D) -> void:
	var soundPlayer = get_parent().find_child("CloudPercutedSong")
	soundPlayer.play()
	on_percuted_cloud.emit()
	$Cloud.visible = false
	$Partcles_cloud.emitting = true
