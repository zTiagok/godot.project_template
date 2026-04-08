class_name GameInputs

static var lastDirection : Vector2 = Vector2.RIGHT
static var currentDirection : Vector2 = Vector2.ZERO

# Pega as direções pressionadas pelo Player.
static func getDirections() -> Vector2:
  currentDirection = Vector2(Input.get_axis("MoveLeft", "MoveRight"), Input.get_axis("MoveUp", "MoveDown"))
  return currentDirection

# Verifica se a direção é diferente de zero, e salva a última direção quando o Player estava se movendo.
static func getLastDirection() -> Vector2:
  var direction = getDirections()
  
  if direction != Vector2.ZERO:
    lastDirection = direction

  return lastDirection 



