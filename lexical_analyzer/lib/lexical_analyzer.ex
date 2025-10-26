tokens = [
      # TODO: rewrite this block (if applicable) with constructors
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

  # next_state(state, c, automaton) prend en paramètre un état state, un caractère c et un automate.
  # Elle retourne l'état d'arrivée de la transition partant de l'état et portant le caractère.
  # Elle retourne -1 si la transition n'existe pas.
  def next_state(state, c, automaton) do
    {_, _, transitions} = automaton                             # Get transitions from the automaton
    {predicate, next_state} = transitions[state]                # TODO: Error Handling (for example when transition[n] doesn't exists)

    if predicate.(c) do
      next_state
    else
      0
      #raise "Invalid transition from state #{state} on character #{inspect c}"
    end
  end

  def recognized_from_state(state, text, {rec, len}, token) do

    {tokent_ident, {_, final_state, _}} = token

    IO.inspect(tokent_ident)     # we will need this as return value
    IO.inspect(final_state)     # we will need this to interrupt reading (and return rest)



    Enum.reduce(text, {rec, len}, fn c, {rec, len} ->
      IO.puts(c)
      IO.inspect({rec, len})

      #next_state(len, c, token) # Hier weiterfahren. Wir müssen wissen, wann wir das Ende erreichen
                                 # dazu somehow abgleichen, ob wir final_state erreicht haben

      {rec ++ [c], len + 1}      # Update accmulator with record and length
    end)
  end


    # {recognized, length} =
    #   Enum.reduce(text, {[], 0}, fn char, {rec_acc, len_acc} ->
    #     IO.puts("Char: #{<<char>>}")
    #     {rec_acc ++ [char], len_acc + 1}
    #   end)

end



# is_final_state (done)
#IO.puts(LexicalAnalyzer.is_final_state(0, {0, [0], %{0 => {&(&1 == ?{), 1}}}))

# implement next_state (done)
IO.puts(LexicalAnalyzer.next_state(0, ?{, {0, [1], %{0 => {&(&1 == ?{), 1}}}))  # returns 1


# retourne le quadruplet {:ok, {:ident, "toto"}, 4, ~c"=3;"}
LexicalAnalyzer.recognized_from_state(0, ~c"toto=3;", {[], 0}, Enum.at(tokens, 15))
