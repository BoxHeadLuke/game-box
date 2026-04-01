extends GBLevel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Globals.progress_trackers = {
	"switch_enabled" : false,
	"summon_enabled" : false,
	"home" : 0,
	"signo_warning" : false,
	"fat_cat_passed" : false,
	"fat_cat_fed" : false,
	"fat_cat_abandon_foods" : 0,
	"froggo_met" : false,
	"alien_spotted" : false,
	"alien_exited" : false,
	"doorway_unlocked" : false,
	"band_search" : false,
	"sewer_open" : false,
	"sewer_flushed" : false,
	"alien_girl_quest" : false,
	
	"ricky_rats_complete" : false,
	"cowboy_joe_complete" : false,
	"alien_girl_complete" :  false,
	"fat_cat_complete" : false,
	"ricky_rats_instrument" : "None",
	"cowboy_joe_instrument" : "None",
	"alien_girl_instrument" : "None",
	"fat_cat_instrument" : "None",
	
	"band_complete" : false,
	"concert_active" : false,
	
	
	}
	Globals.in_game = true
	
	
	await get_tree().create_timer(3)
	$DialogueTrigger.start()
	await DialogueManager.dialogue_ended
	Globals.throw_figure = true
