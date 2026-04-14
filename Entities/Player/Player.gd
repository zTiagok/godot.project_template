class_name Player extends Entity

@export var deceleration : float = 1200.0
@export var currentHairstyle : HairstyleResource
@export var currentTool : DataTypes.ToolTypes

var direction : Vector2
var lastDirection : Vector2
var currentDeceleration : float = deceleration
var canChangeDirection : bool = true

@onready var bodySprite : Sprite2D = $Skeleton/Body
@onready var toolSprite : Sprite2D = $Skeleton/Tool
@onready var hairSprite : Sprite2D = $Skeleton/Hair
@onready var stateLabel : Label = $Skeleton/State

func _ready() -> void:
  # Inicia o cabelo do Player.
  hairSprite.texture = currentHairstyle.idle
  hitbox.collision.disabled = true


func _process(_delta):
  direction = GameInputs.getDirections()
  lastDirection = GameInputs.getLastDirection()
  
  stateLabel.text = stateMachine.currentState.name
  changeSpriteDirection()
  changeHitboxDirection()


func _physics_process(_delta: float) -> void:
  # Habilita a física.
  self.move_and_slide()


func changeAnimation() -> void:
  # Altera a animação baseando-se no state.
  if stateMachine && animation:
    match(stateMachine.currentState.get_script()):
      PlayerIdleState:
        hairSprite.texture = currentHairstyle.idle
        animation.play("Idle")
      
      PlayerWalkState:
        hairSprite.texture = currentHairstyle.walk
        animation.play("Walk")

      PlayerChoppingState:
        hairSprite.texture = currentHairstyle.axe
        animation.play("Chopping")


func changeSpriteDirection() -> void:
  # Caso a direção X do Player seja esquerda ou direita.
  if direction.x != 0 && canChangeDirection:
    bodySprite.flip_h = direction.x < 1
    hairSprite.flip_h = bodySprite.flip_h
    toolSprite.flip_h = bodySprite.flip_h

func changeHitboxDirection() -> void:
  if canChangeDirection:
    match(direction):
      Vector2.UP:
        hitbox.rotation_degrees = 270.0
      Vector2.RIGHT:
        hitbox.rotation_degrees = 0.0
      Vector2.DOWN:
        hitbox.rotation_degrees = 90.0
      Vector2.LEFT:
        hitbox.rotation_degrees = 180.0