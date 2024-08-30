extends Node

class_name TimersUtils

var scoreTimer: Timer = null
var spawnModuleTimer: Timer = null
var blinkBloodTimer: Timer = null

func ScoreTimerHandler():
	if Global.move_speed != 0 && Global.fuel > 0:
		Global.score +=  Global.fuel

func InitiateScoreTimer():
	scoreTimer = Timer.new()
	scoreTimer.wait_time = 0.1 
	scoreTimer.autostart = true 
	scoreTimer.one_shot = false 
	scoreTimer.start()
	scoreTimer.timeout.connect(ScoreTimerHandler)

func onSpawnModuleTimer():
	if gmutils.has_child_with_id(Global.firstIterationChids[14]):
		return
		
	gmutils.CountBonusApparition()
	var currentScene = get_tree().current_scene
	
	currentScene.SpawnModule(Global.spawnAt, Global.bonusCompteur == 10)	 
	currentScene.ManageCloudSpawningInsteadOfMS()

func InitiateSpawnModuleTimer():
	spawnModuleTimer = Timer.new()
	spawnModuleTimer.wait_time = Global.apparitionTimeModule 
	spawnModuleTimer.autostart = true 
	spawnModuleTimer.one_shot = false
	spawnModuleTimer.start()
	spawnModuleTimer.timeout.connect(onSpawnModuleTimer)

var count = 0

func InitiateBlinkBloodTimer(hud):
	blinkBloodTimer = Timer.new()
	blinkBloodTimer.wait_time = 0.5
	blinkBloodTimer.autostart = true 
	blinkBloodTimer.one_shot = false 
	blinkBloodTimer.start()
	blinkBloodTimer.timeout.connect(ScoreTimerHandler.bind(hud))
	
# Fonction appelée lorsque le Timer atteint le timeout
func BlinkBloodTimerHandler(hud):
	count += 1
	if count < 3:
		$Timer.start()
	else:
		$Timer.stop()	
