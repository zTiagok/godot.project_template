# Extendendo um CharacterBody2D para aplicar animações de movimento manuais.
@icon("res://Assets/Icons/objects/chest-blue.png")
class_name Collectable extends CharacterBody2D

@onready var collectableComponent : CollectableComponent = $CollectableComponent

@export var movementSpeed : float = 20.0
@export var incrementalSpeed : float = 80.0

var canBeCollected : bool = false
var player: Player

func _ready():
  collectableComponent.signalCanBeCollected.connect(onCollectionEnabled)
  collectableComponent.signalOnCollected.connect(onCollected)


func _physics_process(_delta):
  # Quando habilitar a coleta, irá se mover em direção ao Player.
  if canBeCollected:
    moveTowardsPlayer(_delta)

  move_and_slide()


func moveTowardsPlayer(time: float) -> void:
  # Pega a direção entre o coletável e o Player
  var direction = global_position.direction_to(player.global_position).normalized()
  
  # Incrementa a velocidade do coletável com o passar do tempo
  movementSpeed += incrementalSpeed * time

  # Aplica a direção e multiplica pela velocidade de movimento, resultando em
  # movimento em relação ao Player.
  velocity = direction * movementSpeed


func onCollectionEnabled(entity: Player) -> void:
  # Ativa o coletável e salva os dados do Player.
  
  canBeCollected = true
  player = entity


func onCollected() -> void:
  queue_free()