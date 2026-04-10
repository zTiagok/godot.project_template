extends Node2D

@onready var sprite : Sprite2D = $Sprite2D

var availableHairs : Array = []
var selectedHair : CustomizationTypes.HairTypes = CustomizationTypes.HairTypes.BowHair

func _ready() -> void:
  setAvailableHairs()
  updateSprite()


func setAvailableHairs() -> void:
  availableHairs = Global.hairCollection.keys()


func updateSprite() -> void:
  var currentHair = availableHairs[selectedHair]

  sprite.texture = Global.hairCollection[selectedHair]

  Global.hairSelected = currentHair