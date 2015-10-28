defmodule Palindromes do

  @doc """
  Generates all palindrome products from an optionally given min factor (or 1) to a given max factor.
  """
  @spec generate(non_neg_integer, non_neg_integer) :: map()
  def generate(max_factor, min_factor \\ 1) do
    all_pairs
    |> IO.inspect
  end

  defp all_pairs do
    for a <- min_factor..max_factor,
        b <- a..max_factor, do: [a, b]
  end
end
