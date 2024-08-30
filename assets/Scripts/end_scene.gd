extends Control

var uKnow = [
	"Le saviez-vous : La flotte de French Bee est composée exclusivement d'Airbus A350.",
	"L'air dans les cabines des avions modernes est généralement renouvelé toutes les 3 minutes  grâce à des systèmes de filtration HEPA.",
	"Les moteurs Rolls-Royce Trent XWB permettent une réduction des émissions de CO2 d'environ 25%.",
	"Le projet Fello'Fly s'inspire de la formation de vol des oiseaux migrateurs pour réduire la consommation de carburant.",
	"French Bee propose un service Coupe-file en réservation pour gagner du temps à l'aéroport.",
	"French Bee dispose d'un accès wifi dans ses avions, permettant aux passagers de rester connectés durant le vol.",
	"French Bee est la première compagnie française low-cost long-courrier.",
	"L'Airbus A350 de French Bee est l'un des avions les plus silencieux de sa catégorie, réduisant la pollution sonore pour les passagers et les communautés environnantes.",
	"Le premier vol des frères Wright a eu lieu le 17 décembre 1903 à Kitty Hawk, en Caroline du Nord.",
	"Les ailes des avions sont conçues pour produire de la portance en utilisant le principe de Bernoulli, qui dit que l'air se déplaçant plus rapidement sur le dessus de l'aile crée une pression plus basse.",
	"Les avions de ligne volent généralement à une altitude de croisière de 30 000 à 40 000 pieds (environ 9 000 à 12 000 mètres).",
	"Les A350 de French Bee sont configurés pour transporter environ 411 passagers dans une configuration bi-classe.",
	"French Bee offre des réductions dans le cadre de la continuité territoriale, pouvant aller jusqu'à 150€.",
	"Les avions modernes sont conçus pour pouvoir voler avec un seul moteur en cas de panne de l'autre.",
	"L'avion le plus rapide jamais construit est le SR-71 Blackbird, atteignant des vitesses de Mach 3.3 (plus de 3 500 km/h).",
	"Le ciel aérien le plus fréquenté au monde se situe au-dessus de l'Atlantique Nord, avec des centaines de vols traversant chaque jour entre l'Amérique du Nord et l'Europe.",
	"La boîte noire d'un avion, en réalité orange pour une meilleure visibilité, enregistre les données de vol et les conversations du cockpit.",
	"French Bee propose des sièges extra-confort avec plus d'espace pour les jambes en classe Premium.",
	"La compagnie a été la première à introduire un concept de tarification 'à la carte' sur les vols long-courriers.",
	"Les avions de French Bee sont équipés de systèmes de pointe pour minimiser les turbulences et offrir un vol plus doux.",
	"French Bee propose des vols directs de Paris à San Francisco et Los Angeles.",
	"Les avions de French Bee sont équipés de prises USB et de prises électriques à chaque siège pour recharger les appareils électroniques.",
	"French Bee permet de choisir son siège à l'avance et propose des sièges avec vue sur l'aile ou plus près des sorties pour un embarquement/débarquement plus rapide.",
	"La compagnie offre un programme de fidélité permettant aux passagers réguliers d'accumuler des points et de bénéficier de divers avantages.",
	"Les passagers de French Bee peuvent précommander des articles duty-free en ligne et les récupérer à bord.",
	"Les vols French Bee offrent des options de repas pour les régimes spéciaux, y compris végétaliens, sans gluten et casher, sur demande.",
	"L'Airbus A350 est équipé de systèmes d'éclairage LED qui peuvent simuler les cycles naturels de la lumière pour aider les passagers à s'adapter aux changements de fuseau horaire.",
]

var rng = RandomNumberGenerator.new()
var destination = ["New York", "Miami", "San Francisco", "Los Angeles", "Saint-Denis", "Papeete"]
var destination_dist = [1000, 1500, 2000, 3000, 4000, 6000, 7000]
var reunion_texture = load("res://assets/mockup/destination/reunion.jpg")


func GenerateRandomNumber(min, max):
	rng.randomize()
	return rng.randi_range(min, max)
	
func _ready() -> void:
	var random = GenerateRandomNumber(0, uKnow.size() - 1)
	$BoxContainer3/LabelTrueStory.text = uKnow[random]
	$BoxContainer/HBoxContainer/ScoreEnd.text = str(Global.score) + " KM"
	if Global.score >= destination_dist[0] && Global.score < destination_dist[1]:
		$BoxContainer/HBoxContainer2/Destination.text = destination[0]
		$DestinationBackground.texture = load("res://assets/mockup/destination/newyork.jpg")
	elif Global.score >= destination_dist[1] && Global.score < destination_dist[2]:
		$BoxContainer/HBoxContainer2/Destination.text = destination[1]
		$DestinationBackground.texture = load("res://assets/mockup/destination/miami.jpg")
	elif Global.score >= destination_dist[2] && Global.score < destination_dist[3]:
		$BoxContainer/HBoxContainer2/Destination.text = destination[2]
		$DestinationBackground.texture = load("res://assets/mockup/destination/sanfrancisco.jpg")
	elif Global.score >= destination_dist[3] && Global.score < destination_dist[4]:
		$BoxContainer/HBoxContainer2/Destination.text = destination[3]
		$DestinationBackground.texture = load("res://assets/mockup/destination/losangeles.jpg")
	elif Global.score >= destination_dist[4] && Global.score < destination_dist[5]:
		$BoxContainer/HBoxContainer2/Destination.text = destination[4]
		$DestinationBackground.texture = load("res://assets/mockup/destination/reunion.jpg")
	elif Global.score >= destination_dist[5] && Global.score < destination_dist[6]:
		$BoxContainer/HBoxContainer2/Destination.text = destination[5]
		$DestinationBackground.texture = load("res://assets/mockup/destination/tahiti.jpg")
		
	else:
		$BoxContainer/HBoxContainer2/Destination.text = "aucune destination."
		$DestinationBackground.texture = reunion_texture
		
	
func _on_btn_restart_pressed() -> void:
	get_tree().change_scene_to_file("res://assets/scene/scene.tscn")
	
func _on_btn_credit_pressed() -> void:
	get_tree().change_scene_to_file("res://assets/interface/crédits.tscn")

func _on_btn_exit_pressed() -> void:
	get_tree().quit()
