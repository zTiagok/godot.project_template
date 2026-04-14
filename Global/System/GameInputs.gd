class_name GameInputs

# Pega as direções pressionadas pelo Player.
static func getDirections() -> Vector2:
  var currentDirection : Vector2 = Vector2(Input.get_axis("MoveLeft", "MoveRight"), Input.get_axis("MoveUp", "MoveDown"))
  return currentDirection

# Verifica se a direção é diferente de zero, e salva a última direção quando o Player estava se movendo.
static func getLastDirection() -> Vector2:
  var lastDirection : Vector2 = Vector2.RIGHT
  var direction : Vector2 = getDirections()
  
  if direction != Vector2.ZERO:
    lastDirection = direction

  return lastDirection 

static func isUsingTool() -> bool:
  return Input.is_action_pressed("UseTool")