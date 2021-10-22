defmodule ComplexNumbers do
  @typedoc """
  In this module, complex numbers are represented as a tuple-pair containing the real and
  imaginary parts.
  For example, the real number `1` is `{1, 0}`, the imaginary number `i` is `{0, 1}` and
  the complex number `4+3i` is `{4, 3}'.
  """
  @type complex :: {float, float}

  @doc """
  Return the real part of a complex number
  """
  @spec real(a :: complex) :: float
  def real({r, _}) do
    r
  end

  @doc """
  Return the imaginary part of a complex number
  """
  @spec imaginary(a :: complex) :: float
  def imaginary({_, i}) do
    i
  end

  @doc """
  Multiply two complex numbers
  """
  @spec mul(a :: complex, b :: complex) :: complex
  def mul(a, b) do
    {real(a) * real(b) - imaginary(a) * imaginary(b),
     real(a) * imaginary(b) + real(b) * imaginary(a)}
  end

  @doc """
  Add two complex numbers
  """
  @spec add(a :: complex, b :: complex) :: complex
  def add(a, b) do
    {real(a) + real(b), imaginary(a) + imaginary(b)}
  end

  @doc """
  Subtract two complex numbers
  """
  @spec sub(a :: complex, b :: complex) :: complex
  def sub(a, b) do
    {real(a) - real(b), imaginary(a) - imaginary(b)}
  end

  @doc """
  Divide two complex numbers
  """
  @spec div(a :: complex, b :: complex) :: complex
  def div(a, b) do
    {(real(a) * real(b) + imaginary(a) * imaginary(b)) /
       (:math.pow(real(b), 2) + :math.pow(imaginary(b), 2)),
     (imaginary(a) * real(b) - real(a) * imaginary(b)) /
       (:math.pow(real(b), 2) + :math.pow(imaginary(b), 2))}
  end

  @doc """
  Absolute value of a complex number
  """
  @spec abs(a :: complex) :: float
  def abs({r, i}) do
    :math.sqrt(:math.pow(r, 2) + :math.pow(i, 2))
  end

  @doc """
  Conjugate of a complex number
  """
  @spec conjugate(a :: complex) :: complex
  def conjugate({r, i}) do
    {r, -i}
  end

  @doc """
  Exponential of a complex number
  """
  @spec exp(a :: complex) :: complex
  def exp({r, i}) do
    {:math.pow(:math.exp(1), r) * :math.cos(i), :math.pow(:math.exp(1), r) * :math.sin(i)}
  end
end
