extends CharacterBody3D

@onready var airplane: Node3D  = $Airplane
@onready var tween: Tween = null
# Vitesse de déplacement automatique
@export var forward_speed : float = 5.0

# Vitesse de déplacement vertical (axe Y)
@export var vertical_speed : float = 2.0

# Colonnes prédéfinies sur l'axe X
@export var columns : Array = [-5.0, 0.0, 5.0]  # Exemple de colonnes X

# Vitesse de changement de colonne
@export var column_change_speed : float = 5.0

# Index de la colonne actuelle
var current_column_index : int = 0

func update_velocity() -> void:
	# Remettre à zéro la vélocité sur l'axe X
	velocity.z = 0
	
	# Vérifier les entrées utilisateur pour les mouvements gauche/droite
	if Input.is_action_pressed("ui_left"):
		velocity.z -= 1
	if Input.is_action_pressed("ui_right"):
		velocity.z += 1
	#
	# Normaliser le vecteur pour s'assurer d'une vitesse constante
	velocity = velocity.normalized()
	
	
func _ready():
	tween = create_tween()
	# Initialiser la colonne actuelle en fonction de la position initiale
	current_column_index = get_closest_column_index(global_transform.origin.z)
	snap_to_column()

func _physics_process(delta):
	if Input.is_action_just_pressed("ui_right"):
		move_column(1)
	elif Input.is_action_just_pressed("ui_left"):
		move_column(-1)
	#move_and_slide()
	
	# Déplacement vers la colonne cible
	if global_transform.origin.z != columns[current_column_index]:
		var target_position = columns[current_column_index]
		global_transform.origin.z = lerp(global_transform.origin.z, target_position, column_change_speed * delta)

func move_column(direction: int):
	# Calculer le nouvel index de colonne
	current_column_index = clamp(current_column_index + direction, 0, columns.size() - 1)
	snap_to_column()

var vel: Vector3 = Vector3.ZERO
func snap_to_column():
	tween.tween_property(airplane, "position:z", columns[current_column_index], 2)

	
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
