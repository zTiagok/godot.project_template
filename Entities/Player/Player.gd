class_name Player extends Entity


@export var label : Label
@export var speed : float = 150.0
@export var deceleration : float = 1200.0
@export var currentHairstyle : HairstyleResource

var direction : Vector2
var lastDirection : Vector2
var currentDeceleration : float = deceleration

@onready var bodySprite : Sprite2D = $Skeleton/Body
@onready var toolSprite : Sprite2D = $Skeleton/Tool
@onready var hairSprite : Sprite2D = $Skeleton/Hair


func _ready() -> void:
  # Inicia o cabelo do Player.
  hairSprite.texture = currentHairstyle.idle


func _process(_delta):
  direction = GameInputs.getDirections()
  lastDirection = GameInputs.getLastDirection()

  print(self.currentDeceleration)

  label.text = stateMachine.currentState.name
  changeSpriteDirection()


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


func changeSpriteDirection() -> void:
  # Caso a direção X do Player seja esquerda ou direita.
  if direction.x != 0:
    bodySprite.flip_h = direction.x < 1
    hairSprite.flip_h = bodySprite.flip_h
    toolSprite.flip_h = bodySprite.flip_h
  