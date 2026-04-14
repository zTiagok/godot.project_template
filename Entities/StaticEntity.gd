@icon("res://Assets/Icons/2d/die-1-blue.png")
class_name StaticEntity extends StaticBody2D


@onready var hurtbox : HurtboxComponent = $HurtboxComponent
@onready var collision : CollisionShape2D = $CollisionShape2D
@onready var stats : StatsComponent = $StatsComponent

@export var dropList : Array[CollectableResource]
@export var neededTool : DataTypes.ToolTypes = DataTypes.ToolTypes.None

func _ready() -> void:
  collision_layer = LayerTypes.WORLD
  collision_mask = LayerTypes.PLAYER | LayerTypes.ENEMY | LayerTypes.COLLECTABLES | LayerTypes.INTERACTABLES


func onDestroyed() -> void:
  # Desativa a hurtbox para evitar problemas e limpa a entidade do fluxo.
  hurtbox.collision.set_deferred("disabled", true)

  for drop in dropList:
    spawnLoot(drop)

  queue_free()


func spawnLoot(drop: CollectableResource) -> void:
  var quantity = randi_range(drop.minQuantity, drop.maxQuantity)
  var canSpawn = randf() <= drop.probability

  print(randf())

  if canSpawn:
    for item in quantity:
      var instance = drop.scene.instantiate() as Node2D
      instance.global_position = self.global_position
      get_tree().current_scene.add_child.call_deferred(instance)