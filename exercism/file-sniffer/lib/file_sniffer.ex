defmodule FileSniffer do
  @ext2type %{
    exe: "application/octet-stream",
    bmp: "image/bmp",
    png: "image/png",
    jpg: "image/jpg",
    gif: "image/gif"
  }

  def str2atom(str), do: String.to_atom(str)

  def type_from_extension(extension) do
    @ext2type[str2atom(extension)]
  end

  def type_from_binary(<<0x42, 0x4D, _::binary>>), do: type_from_extension("bmp")
  def type_from_binary(<<0xFF, 0xD8, 0xFF, _::binary>>), do: type_from_extension("jpg")
  def type_from_binary(<<0x47, 0x49, 0x46, _::binary>>), do: type_from_extension("gif")
  def type_from_binary(<<0x7F, 0x45, 0x4C, 0x46, _::binary>>), do: type_from_extension("exe")

  def type_from_binary(<<0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, _::binary>>),
    do: type_from_extension("png")

  def verify(file_binary, extension) do
    file_binary_type = type_from_binary(file_binary)

    case file_binary_type == type_from_extension(extension) do
      true -> {:ok, file_binary_type}
      false -> {:error, "Warning, file format and file extension do not match."}
    end
  end
end
