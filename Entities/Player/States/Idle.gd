class_name PlayerIdleState extends State

var player : Player

func Enter() -> void:
  super()
  player = entity

func Update(_delta) -> void:
  # Troca para o "Walk" caso pressione alguma direção.
  if player.direction != Vector2.ZERO:
    stateMachine.ChangeState(PlayerWalkState)

func PhysicsUpdate(_delta) -> void:
  # Retira toda a velocidade do player.
  player.velocity = Vector2.ZERO