defmodule BasketballWebsite do
  def extract_from_path(data, path) do
    Enum.reduce(
      String.split(path, "."),
      data,
      fn
        _, nil -> nil
        [], value -> value
        key, acc -> acc[key]
      end
    )
  end

  def get_in_path(data, path) do
    Kernel.get_in(data, String.split(path, "."))
  end
end
