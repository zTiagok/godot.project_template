# Extendendo um CharacterBody2D para aplicar animações de movimento manuais.
@icon("res://Assets/Icons/objects/chest-blue.png")
class_name Collectable extends CharacterBody2D

@onready var collectableComponent : CollectableComponent = $CollectableComponent
@onready var stuckTimer : Timer = $Timer
@onready var animation : AnimationPlayer = $AnimationPlayer

@export_group("On Spawn")
@export var minDistance : float = 10.0
@export var maxDistance : float = 30.0
@export var deceleration : float = 20.0

@export_group("On Following")
@export var movementSpeed : float = 20.0
@export var incrementalSpeed : float = 80.0

var canBeCollected : bool = false
var player: Player
var lastPosition : Vector2
var spawnDirection : Vector2
var spawnAngle : float

func _ready():
  collision_layer = LayerTypes.COLLECTABLES
  collision_mask = LayerTypes.WORLD | LayerTypes.INTERACTABLES

  collectableComponent.signalCanBeCollected.connect(onCollectionEnabled)
  collectableComponent.signalOnCollected.connect(onCollected)

  movementOnSpawn()
  animation.seek(randf() * animation.current_animation_length, true)


func _physics_process(_delta):
  lastPosition = global_position

  # Quando habilitar a coleta, irá se mover em direção ao Player.
  if canBeCollected:
    moveTowardsPlayer(_delta)
  else:
    # Caso não, ele irá desacelerar até parar.
    velocity = velocity.move_toward(Vector2.ZERO, deceleration * _delta)

  move_and_slide()

  # Depois de calcular a física com o "move_and_slide", verifica a posição e vê
  # se está preso.
  checkIfStuck()


func movementOnSpawn() -> void:
  # Escolhe um ângulo aleatório dentro dos 360 graus.
  spawnAngle = randf() * TAU

  # Escolhe uma direção dentro desse ângulo.
  spawnDirection = Vector2.RIGHT.rotated(spawnAngle)

  # Escolhe uma velocidade em base a distância mínima e máxima selecionada.
  var spawnForce = randf_range(minDistance, maxDistance)

  # Aplica a velocity para esta direção.
  velocity = spawnDirection * spawnForce


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