defmodule Prime do
  @first_4_primes [2, 3, 5, 7]

  def prime?(candidate, known_primes) do
    not (known_primes
         |> Stream.map(&(rem(candidate, &1) == 0))
         |> Enum.any?())
  end

  def get_next_prime(a_prime, known_primes) do
    candidate_prime = a_prime + 2

    if prime?(candidate_prime, known_primes) do
      candidate_prime
    else
      get_next_prime(candidate_prime, known_primes)
    end
  end

  @doc """
  Generates the nth prime.
  """
  @spec nth(non_neg_integer) :: non_neg_integer

  def nth(count)
      when count > 0 and count <= 4 do
    @first_4_primes |> Enum.take(count) |> Enum.reverse() |> hd
  end

  def nth(count)
      when count >= 5 do
    Stream.resource(
      fn -> {7, @first_4_primes} end,
      fn {latest_prime, primes} ->
        next_prime = get_next_prime(latest_prime, primes)
        {[next_prime], {next_prime, primes ++ [next_prime]}}
      end,
      fn acc -> acc end
    )
    |> Enum.take(count-4)
    |> Enum.reverse()
    |> hd
  end
end
