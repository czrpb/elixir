defmodule RationalNumbers do
  @type rational :: {integer, integer}

  @doc """
  Add two rational numbers
  """
  @spec add(a :: rational, b :: rational) :: rational
  def add({a1, d}, {b1, d}), do: {a1+b1, d} |> reduce
  def add({a1, a2}, {b1, b2}), do: {a1*b2 + b1*a2, a2*b2} |> reduce

  @doc """
  Subtract two rational numbers
  """
  @spec subtract(a :: rational, b :: rational) :: rational
  def subtract({a1, d}, {b1, d}), do: {a1-b1, d} |> reduce
  def subtract({a1, a2}, {b1, b2}), do: {a1*b2 - b1*a2, a2*b2} |> reduce

  @doc """
  Multiply two rational numbers
  """
  @spec multiply(a :: rational, b :: rational) :: rational
  def multiply({a1, a2}, {b1, b2}), do: {a1*b1, a2*b2} |> reduce

  @doc """
  Divide two rational numbers
  """
  @spec divide_by(num :: rational, den :: rational) :: rational
  def divide_by(num, {d1, d2}), do: multiply(num, {d2, d1})

  @doc """
  Absolute value of a rational number
  """
  @spec abs(a :: rational) :: rational
  def abs({n, d}), do: {Kernel.abs(n), Kernel.abs(d)}

  @doc """
  Exponentiation of a rational number by an integer
  """
  @spec pow_rational(a :: rational, n :: integer) :: rational
  def pow_rational(r, 0), do: {1, 1}
  def pow_rational({a, b}, n)
  when n > 0 do
    {:math.pow(a, n)|>round, :math.pow(b, n)|>round}
    |> reduce
  end
  def pow_rational({a, b}, n)
  when n < 0 do
    {:math.pow(b, Kernel.abs(n))|>round, :math.pow(a, Kernel.abs(n))|>round}
    |> reduce
  end

  @doc """
  Exponentiation of a real number by a rational number
  """
  @spec pow_real(x :: integer, n :: rational) :: float
  def pow_real(_, {0, _}), do: 1.0
  def pow_real(x, {a, b}) do
    p = x |> :math.pow(a)
    guess = (p |> :math.sqrt |> :math.sqrt) * 2
    root(p, b, guess)
  end

  defp root(p, q, guess) do
    update = p-:math.pow(guess, q)
    if Kernel.abs(update) <= 1.0e-11 do
      guess
    else
      guess = guess + update
      root(p, q, guess)
    end
  end

  @doc """
  Reduce a rational number to its lowest terms
  """
  @spec reduce(a :: rational) :: rational
  def reduce({0, _}), do: {0, 1}
  def reduce({n, n}), do: {1, 1}
  def reduce({a, b})
  when b<0 do
    {-a, -b} |> reduce
  end
  def reduce(r), do: r |> gcd

  defp gcd({n, d}=r)
  do
    case Kernel.abs(n) < Kernel.abs(d) do
      true -> gcd(r, Kernel.abs(n))
      false -> gcd(r, Kernel.abs(d))
    end
  end
  defp gcd(r, 1), do: r
  defp gcd({n, d}=r, gcd_) do
    case {rem(n, gcd_), rem(d, gcd_)} do
      {0, 0} -> {div(n, gcd_), div(d, gcd_)}
      _ -> gcd(r, gcd_-1)
    end
  end
end
