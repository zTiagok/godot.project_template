@icon("res://Assets/Icons/2d/spark-full-white.png")
class_name StateMachine extends Node

@export var initialState : State
@export var currentState: State
var stateList : Dictionary[Variant, State] = {}

signal SignalStateChange(state: State)


func _ready():
	# Percorre todos os filhos do StateMachine
	for state: State in self.get_children():
		# Salva a StateMachine no State.	
		state.stateMachine = self

		# Salva a entidade que tem o StateMachine no State.
		state.entity = self.get_parent()

		# Guarda o state na lista de States.
		stateList[state.get_script()] = state

	# Caso não exista um State inicial, pega o primeiro State salvo na lista de States.
	if !initialState:
		initialState = stateList.values()[0]

	# Seta o state inicial como o state atual.
	currentState = initialState

	# Ativa o a função "Enter" do State atual.
	currentState.Enter()


func _process(delta):
	# Caso exista um State atual, irá chamar a função "Update" atualizando a todo frame.
	if currentState:
		currentState.Update(delta)


func _physics_process(delta):
	# Caso exista um State atual, irá chamar a função "PhysicsUpdate" atualizando a todo frame.
	if currentState:
		currentState.PhysicsUpdate(delta)


func ChangeState(state):
	if state != null:
		var newState = stateList.get(state)

		if newState:
			print("Entity - ", newState.entity.name, " State: ", newState.name)
			# Ativa a função de saída do State atual e chama a função de entrada no novo State.

			# Executa o código de saída do state "antigo".
			currentState.Exit()

			# Altera o state atual, atualizando-o pelo novo state que foi chamado.
			currentState = newState
			
			# Executa o código de entrada do state novo.
			currentState.Enter()

			# Emite um sinal de que o state foi alterado, enviando-o como resposta.
			SignalStateChange.emit(newState)
			
