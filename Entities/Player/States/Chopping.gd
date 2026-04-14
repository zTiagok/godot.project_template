class_name PlayerChoppingState extends State

var player : Player

func Enter() -> void:
  super()
  player = entity
  player.canChangeDirection = false


func PhysicsUpdate(_delta) -> void:
  # Para o player.
  player.velocity = Vector2.ZERO


func Exit() -> void:
  player.canChangeDirection = true



func onAnimationEnd() -> void:
  # No final da animação, checa se o Player ainda está segurando o botão da ferramenta.
  if !GameInputs.isUsingTool():
    if player.direction != Vector2.ZERO:
      stateMachine.ChangeState(PlayerWalkState)
    else:
      stateMachine.ChangeState(PlayerIdleState)
