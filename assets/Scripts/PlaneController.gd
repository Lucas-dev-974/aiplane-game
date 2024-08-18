extends CharacterBody3D

@onready var airplane: Node3D  = $Airplane
#@onready var tween: Tween
# Vitesse de déplacement automatique
@export var forward_speed : float = 5.0

# Vitesse de déplacement vertical (axe Y)
@export var vertical_speed : float = 2.0

# Colonnes prédéfinies sur l'axe X
@export var columns : Array = [-5.0, 0.0, 5.0]  # Exemple de colonnes X
@export var rows: Array = [0, 3]
# Vitesse de changement de colonne
@export var column_change_speed : float = 5.0

# Index de la colonne actuelle
var current_column_index : int = 0
var current_row_index: int = 0

func _ready():
	# Initialiser la colonne actuelle en fonction de la position initiale
	current_column_index = get_closest_column_index(global_transform.origin.z)
	current_row_index = get_closest_row_index(global_transform.origin.y)

@export var target_rotation_left : Vector3
@export var target_rotation_left_end : Vector3

@export var target_rotation_right : Vector3
@export var target_rotation_right_end : Vector3

@export var target_rotation_top : Vector3
@export var target_rotation_top_end : Vector3

@export var target_rotation_bottom : Vector3
@export var target_rotation_bottom_end : Vector3

var time_pressed = 0
@export var duration: float = 0.2

signal show_end_interface 


func _physics_process(delta):
	if self.get_parent().fuel == 0:
		pass
		
	var tween = create_tween()
	if Input.is_action_just_pressed("ui_right"):
		$WooshPlayer.play()
		tween.tween_property(airplane, "rotation_degrees", target_rotation_left, duration)
		tween.tween_property(airplane, "rotation_degrees", target_rotation_left_end, duration)
		move_column(1)
	elif Input.is_action_just_pressed("ui_left"):
		$WooshPlayer.play()
		tween.tween_property(airplane, "rotation_degrees", target_rotation_right, duration)
		tween.tween_property(airplane, "rotation_degrees", target_rotation_right_end, duration)
		move_column(-1)
	elif Input.is_action_just_pressed("ui_up"):
		$WooshPlayer.play()
		tween.tween_property(airplane, "rotation_degrees", target_rotation_top, duration)
		tween.tween_property(airplane, "rotation_degrees", target_rotation_top_end, duration)
		move_vertical(1)
	elif Input.is_action_just_pressed("ui_down"):
		$WooshPlayer.play()
		tween.tween_property(airplane, "rotation_degrees", target_rotation_bottom, duration)
		tween.tween_property(airplane, "rotation_degrees", target_rotation_bottom_end, duration)
		move_vertical(-1)
	
	if Input.is_action_just_released("ui_right") || Input.is_action_just_released("ui_left"):
		time_pressed = 0
		
	# Déplacement vers la colonne cible
	if global_transform.origin.z != columns[current_column_index]:
		var target_position = columns[current_column_index]
		global_transform.origin.z = lerp(global_transform.origin.z, target_position, column_change_speed * delta)
		
	# Déplacement vers la rangée cible
	if global_transform.origin.y != rows[current_row_index]:
		var target_position = rows[current_row_index]
		global_transform.origin.y = lerp(global_transform.origin.y, float(target_position), column_change_speed * delta)

func move_column(direction: int):
	# Calculer le nouvel index de colonne
	current_column_index = clamp(current_column_index + direction, 0, columns.size() - 1)
	
func move_vertical(direction: int):
	# Calculer le nouvel index de colonne
	current_row_index = clamp(current_row_index + direction, 0, rows.size() - 1)


func get_closest_column_index(x: float) -> int:
	# Trouver l'indice de la colonne la plus proche
	var closest_index : int = 0
	var min_distance : float = abs(x - columns[0])
	
	for i in range(1, columns.size()):
		var distance = abs(x - columns[i])
		if distance < min_distance:
			min_distance = distance
			closest_index = i
	
	return closest_index
	
func get_closest_row_index(y: float) -> int:
	# Trouver l'indice de la rangée la plus proche
	var closest_index : int = 0
	var min_distance : float = abs(y - rows[0])
	
	for i in range(1, rows.size()):
		var distance = abs(y - rows[i])
		if distance < min_distance:
			min_distance = distance
			closest_index = i
	
	return closest_index
