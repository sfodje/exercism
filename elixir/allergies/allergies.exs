defmodule Allergies do
  use Bitwise

  @ordered_allergens ~w(
    eggs
    peanuts
    shellfish
    strawberries
    tomatoes
    chocolate
    pollen
    cats
  ) # flag value will be 2^index of allergy

  @doc """
  List the allergies for which the corresponding flag bit is true.

  Allergies should be ordered, starting with the allergie with the least
  significant bit ("eggs").
  """
  @spec list(non_neg_integer) :: [String.t]
  def list(flags) do
    allergens_with_flag_values
    |> Enum.reduce([], fn ({allergy, flag_value}, allergens) ->
      if (flags &&& flag_value) === 0 do
        allergens
      else
        [allergy | allergens]
      end
    end)
  end

  @doc """
  Returns whether the corresponding flag bit in 'flags' is set for the item.
  """
  @spec allergic_to?(non_neg_integer, String.t) :: boolean
  def allergic_to?(flags, item) do
    flags
    |> list
    |> Enum.any?(&(&1 === item))
  end

  @spec allergens_with_flag_values() :: [{String.t, non_neg_integer}]
  defp allergens_with_flag_values do
    allergens_with_indices =
      @ordered_allergens
      |> Enum.with_index
      |> Enum.reverse
    for {allergy, index} <- allergens_with_indices do
      {allergy, pow(2, index)}
    end
  end

  @spec pow(non_neg_integer, non_neg_integer) :: non_neg_integer
  defp pow(_, 0), do: 1
  defp pow(n, 1), do: n
  defp pow(n, exp), do: n * pow(n, exp - 1)

end
