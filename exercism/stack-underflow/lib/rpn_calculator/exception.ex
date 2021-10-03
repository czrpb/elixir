defmodule RPNCalculator.Exception do
  # Please implement DivisionByZeroError here.
  defmodule DivisionByZeroError do
    defexception message: "division by zero occurred"
  end

  # Please implement StackUnderflowError here.
  defmodule StackUnderflowError do
    @message "stack underflow occurred"

    defexception message: @message

    @impl true
    def exception(ctx) do
      case ctx do
        [] -> %StackUnderflowError{}
        _ -> %StackUnderflowError{message: "#{@message}, context: #{ctx}"}
      end
    end
  end

  def divide([0, _ | _]) do
    raise DivisionByZeroError
  end

  def divide([demoninator, numerator | _]) do
    numerator / demoninator
  end

  def divide(_) do
    raise StackUnderflowError, "when dividing"
  end
end
