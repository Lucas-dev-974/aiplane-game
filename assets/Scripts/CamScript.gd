extends Camera3D  # Assure-toi que le script est attaché à une Camera3D

@export var character : Plane  # Chemin vers le personnage
var character_node : Node3D = null
var camera_offset : Vector3 = Vector3(0, 5, -10)  # Offset de la caméra par rapport au personnage

func _ready():
	# Récupérer le nœud du personnage à partir du chemin spécifié
	character_node = get_node(character) as Node3D

func _process(delta):
	if character_node:
		# Mettre à jour la position de la caméra en fonction de la position du personnage
		var character_transform = character_node.global_transform
		global_transform.origin = character_transform.origin + camera_offset
		
		# Optionnel : Réinitialiser la rotation de la caméra
		global_transform.basis = Basis()
