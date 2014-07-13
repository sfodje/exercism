defmodule ListOps do

  @type acc :: any
  @spec reduce(list, acc, ((any, acc) -> acc)) :: acc
  def reduce([], acc, _fxn),   do: acc
  def reduce([h|t], acc, fxn), do: reduce(t, fxn.(h, acc), fxn)

  @spec count(list) :: non_neg_integer
  def count(list), do: reduce(list, 0, fn (_, acc) -> acc + 1 end)

  @spec reverse(list) :: list
  def reverse(list), do: reduce(list, [], &([&1 | &2]))

  @spec append(list, list) :: list
  def append(list, list2), do: reduce(reverse(list), list2, &([&1 | &2]))

  @spec concat([[any]]) :: [any]
  def concat(list), do: reduce(list, [], &(append &2, &1))

  @spec map(list, (any -> any)) :: list
  def map(list, fxn), do: reduce(reverse(list), [], &([ fxn.(&1) | &2 ]))

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter(list, fxn) do
    reduce(reverse(list), [], &(if fxn.(&1), do: [ &1 | &2 ], else: &2))
  end

end
