class_name PlayerIdleState extends State

var player : Player

func Enter() -> void:
  super()
  player = entity

func Update(_delta) -> void:
  # Troca para o "Walk" caso pressione alguma direção.
  if player.direction != Vector2.ZERO:
    stateMachine.ChangeState(PlayerWalkState)

  # Ao apertar o botão de utilização da ferramenta, troca para o state equivalente
  # à ferramenta equipada.
  if GameInputs.isUsingTool():
    match(player.currentTool):
      DataTypes.ToolTypes.Axe:
        stateMachine.ChangeState(PlayerChoppingState)

      DataTypes.ToolTypes.Pickaxe:
        stateMachine.ChangeState(PlayerMiningState)

func Exit() -> void:
  # Reseta a desaceleração.
  player.currentDeceleration = player.deceleration

func PhysicsUpdate(_delta) -> void:
  # Retira toda a velocidade do player.
  player.velocity = player.velocity.move_toward(Vector2.ZERO, player.currentDeceleration * _delta)