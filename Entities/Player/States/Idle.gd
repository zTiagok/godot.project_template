class_name PlayerIdleState extends State

var player : Player

func Enter() -> void:
  super()
  player = entity

func Update(_delta) -> void:
  # Troca para o "Walk" caso pressione alguma direção.
  if player.direction != Vector2.ZERO:
    stateMachine.ChangeState(PlayerWalkState)

  if player.currentTool == DataTypes.ToolTypes.Axe && GameInputs.isUsingTool():
    stateMachine.ChangeState(PlayerChoppingState)

func Exit() -> void:
  # Reseta a desaceleração.
  player.currentDeceleration = player.deceleration

func PhysicsUpdate(_delta) -> void:
  # Retira toda a velocidade do player.
  player.velocity = player.velocity.move_toward(Vector2.ZERO, player.currentDeceleration * _delta)