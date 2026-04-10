extends Parallax2D

var currentVerticalDirection : float = 0
@export_range(0, 10) var maxVerticalRange : float = 3
@export_range(-10, 0) var minVerticalRange : float = -3
@export_range(0.1, 20) var verticalChangeVelocity : float = 0.5

func _process(delta: float) -> void:
  changeVerticalDirection(delta)

func changeVerticalDirection(time: float) -> void:
  # Altera a velocidade do offSet de acordo com o tempo.
  currentVerticalDirection += time * verticalChangeVelocity

  print(currentVerticalDirection)

  # Caso o valor antinja o limite máximo ou mínimo, altera o sentido.
  if currentVerticalDirection >= maxVerticalRange or currentVerticalDirection <= minVerticalRange:
    verticalChangeVelocity *= -1

  # Aplica o autoscroll.
  self.autoscroll.y = currentVerticalDirection