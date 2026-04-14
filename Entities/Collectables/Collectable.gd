# Extendendo um CharacterBody2D para aplicar animações de movimento manuais.
@icon("res://Assets/Icons/objects/chest-blue.png")
class_name Collectable extends CharacterBody2D

@onready var collectableComponent : CollectableComponent = $CollectableComponent
@onready var stuckTimer : Timer = $Timer

@export var movementSpeed : float = 20.0
@export var incrementalSpeed : float = 80.0

var canBeCollected : bool = false
var player: Player
var lastPosition : Vector2

func _ready():
  collision_layer = LayerTypes.COLLECTABLES
  collision_mask = LayerTypes.WORLD | LayerTypes.INTERACTABLES
  stuckTimer.stop()

  collectableComponent.signalCanBeCollected.connect(onCollectionEnabled)
  collectableComponent.signalOnCollected.connect(onCollected)


func _physics_process(_delta):
  lastPosition = global_position

  print(stuckTimer.time_left)

  # Quando habilitar a coleta, irá se mover em direção ao Player.
  if canBeCollected:
    moveTowardsPlayer(_delta)

  move_and_slide()

  # Depois de calcular a física com o "move_and_slide", verifica a posição e vê
  # se está preso.
  checkIfStuck()


func moveTowardsPlayer(time: float) -> void:
  # Pega a direção entre o coletável e o Player
  var direction = global_position.direction_to(player.global_position).normalized()
  
  # Incrementa a velocidade do coletável com o passar do tempo
  movementSpeed += incrementalSpeed * time

  # Aplica a direção e multiplica pela velocidade de movimento, resultando em
  # movimento em relação ao Player.
  velocity = direction * movementSpeed


func checkIfStuck() -> void:
  if canBeCollected:
    # Pega a distância movida depois do cálculo das físicas.
    var movedDistance = global_position.distance_to(lastPosition)
    
    # Se ficar sem se mover, iniciará um timer. Caso mova-se, irá desativa-lo.
    if movedDistance <= 0.1:
      if stuckTimer.is_stopped():
        stuckTimer.start()
    else:
      if !stuckTimer.is_stopped():
        stuckTimer.stop()
  
func _on_timer_timeout() -> void:
  # Quando o timer acabar, irá desativar todas as colisões e aumentará a 
  # velocidade de movimento do coletável.
  movementSpeed *= 2
  collision_mask = 0


func onCollectionEnabled(entity: Player) -> void:
  # Ativa o coletável e salva os dados do Player.
  
  canBeCollected = true
  player = entity


func onCollected() -> void:
  queue_free()