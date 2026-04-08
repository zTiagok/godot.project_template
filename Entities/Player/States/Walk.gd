class_name PlayerWalkState extends State

var player : Player

func Enter() -> void:
  player = entity

func Update(_delta) -> void:
  # Caso nenhum botão esteja sendo apertado, troca para o "Idle".
  if GameInputs.getDirections() == Vector2.ZERO:
    stateMachine.ChangeState(PlayerIdleState)

func PhysicsUpdate(_delta) -> void:
  # Movimenta o Player com base na direção escolhida.
  player.velocity = player.speed * GameInputs.getDirections()

  # Habilita a física.
  player.move_and_slide()