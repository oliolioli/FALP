tokens = [
      {:begin_block, {0, [1], %{0 => {&(&1 == ?{), 1}}}},
      {:end_block, {0, [1], %{0 => {&(&1 == ?}), 1}}}},
      {:begin_par, {0, [1], %{0 => {&(&1 == ?(), 1}}}},
      {:end_par, {0, [1], %{0 => {&(&1 == ?)), 1}}}},
      {:semicolon, {0, [1], %{0 => {&(&1 == ?;), 1}}}},
      {:op_eg, {0, [2], %{0 => {&(&1 == ?=), 1}, 1 => {&(&1 == ?=), 2}}}},
      {:op_affect, {0, [1], %{0 => {&(&1 == ?=), 1}}}},
      {:op_add, {0, [1], %{0 => {&(&1 == ?+), 1}}}},
      {:op_minus, {0, [1], %{0 => {&(&1 == ?-), 1}}}},
      {:op_mult, {0, [1], %{0 => {&(&1 == ?*), 1}}}},
      {:op_div, {0, [1], %{0 => {&(&1 == ?/), 1}}}},
      {:type_int, {0, [3], %{0 => {&(&1 == ?i), 1}, 1 => {&(&1 == ?n), 2}, 2 => {&(&1 == ?t), 3}}}},
      {:cond, {0, [2], %{0 => {&(&1 == ?i), 1}, 1 => {&(&1 == ?f), 2}}}},
      {:loop, {0, [5], %{0 => {&(&1 == ?w), 1}, 1 => {&(&1 == ?h), 2}, 2 => {&(&1 == ?i), 3}, 3 => {&(&1 == ?l), 4}, 4 => {&(&1 == ?e), 5}}}},
      {:value_int, {0, [1], %{0 => {&(&1 in ?0..?9), 1}, 1 => {&(&1 in ?0..?9), 1}}}},
      {:ident, {0, [1], %{0 => {&(&1 in ?A..?Z or &1 in ?a..?z or &1 == ?_), 1}, 1 => {&(&1 in ?A..?Z or &1 in ?a..?z or &1 in ?0..?9 or &1 == ?_), 1}}}}
  ]


defmodule Token do
  @type code :: atom()
  @type recognized_token :: {Token.code(), String.t()}

  defstruct [:code, :automaton]

  @type t :: %Token{
    code: code(),
    automaton: Automaton.t()
  }
end

defmodule Automaton do
  @type valid_state :: integer()
  @type state :: valid_state() | nil
  @type predicate :: (char() -> boolean())
  @type transitions :: %{valid_state() => [{predicate(), valid_state()}, ...]}

  defstruct [:initial, :finals, :transitions]

  @type t :: %Automaton{
    initial: valid_state(),
    finals: [valid_state(), ...],
    transitions: transitions()
  }

  # Constructor for Automaton
  def new(initial, finals, transitions) do
  %Automaton{
      initial: initial,
      finals: finals,
      transitions: transitions
    }
    IO.inspect("Automaton constructed.")
  end

end

defmodule LexicalAnalyzer do
  # is_final_state(state, automaton) : cette fonction prend en paramètre un état state et un automate.
  # Elle retourne true si l'état est final dans cet automate, et false sinon.
  @spec is_final_state(any(), {any(), any(), any()}) :: any()
  def is_final_state(state, automaton) do
    {_, [final_state], _}  = automaton
    state == final_state
  end
end



#test_automat = Automaton.new(0, [1], %{0 => [{&(&1 == ?{), 1}]}) # est l'automate qui reconnaît la chaîne de caractère "{".

IO.puts(LexicalAnalyzer.is_final_state(0, {0, [0], %{0 => {&(&1 == ?{), 1}}}))
