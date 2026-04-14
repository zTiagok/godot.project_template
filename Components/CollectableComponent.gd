class_name CollectableComponent extends Area2D

@export var collectionTimer : float = 3.0
@onready var followCollision : CollisionShape2D = $CollisionShape2D
@onready var collectionRadius : Area2D = $CollectionRadius
@onready var collectionCollision : CollisionShape2D = $CollectionRadius/CollisionShape2D

var enableCollection : bool = false
var parent : Collectable

signal signalCanBeCollected(body: Player)
signal signalOnCollected


func _ready() -> void:
  parent = get_parent()

  # Desativa a colisão, reativando depois de alguns segundos.
  followCollision.disabled = true
  collectionCollision.disabled = true
  await get_tree().create_timer(collectionTimer).timeout
  followCollision.disabled = false
  collectionCollision.disabled = false


func _on_body_entered(body: Node2D) -> void:
  # Quando a área de perseguição entrar em contato, irá emitir um sinal]
  # (Normalmente para o Collectable)
  if body is Player:
    followCollision.set_deferred("disabled", true)
    signalCanBeCollected.emit(body)

func _on_collection_radius_body_entered(body: Node2D) -> void:
  # Quando a área de coleta entrar em contato, irá enviar um sinal para o Collectable
  # fazer a coleta do item.
  if body is Player:
    signalOnCollected.emit()