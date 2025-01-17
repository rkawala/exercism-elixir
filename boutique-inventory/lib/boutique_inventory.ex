defmodule BoutiqueInventory do
  def sort_by_price(inventory) do
    Enum.sort_by(inventory, &(&1.price))
  end

  def with_missing_price(inventory) do
    Enum.filter(inventory, &(&1.price == nil))
  end

  def update_names(inventory, old_word, new_word) do
    Enum.map(inventory, &(%{&1 | name: Regex.replace(~r/#{old_word}/, &1.name, new_word)}))
  end

  def increase_quantity(item, count) do
    modified_quantities = Map.new(item.quantity_by_size, fn { size, qty } -> { size, qty + count } end)
    %{ item | quantity_by_size: modified_quantities }
  end

  def total_quantity(item) do
    Enum.reduce(item.quantity_by_size, 0, fn { _size, qty }, acc -> acc + qty end)
  end
end
