defmodule ProteinTranslation do
  @doc """
  Given an RNA string, return a list of proteins specified by codons, in order.
  """

  def of_rna([], acc) do
    {:ok, acc |> Enum.reverse}
  end
  def of_rna([d,n,a|remaining], acc) do
    try do
      {:ok, protein} = <<d, n, a>> |> of_codon
      case protein do
        "STOP" -> of_rna([], acc)
        _ -> of_rna(remaining, [protein|acc])
      end
    rescue
      [MatchError] -> {:error, "invalid RNA"}
    end
  end
  @spec of_rna(String.t()) :: {atom, list(String.t())}
  def of_rna(rna) do
    of_rna(String.to_charlist(rna), [])
  end

  @doc """
  Given a codon, return the corresponding protein

  UGU -> Cysteine
  UGC -> Cysteine
  UUA -> Leucine
  UUG -> Leucine
  AUG -> Methionine
  UUU -> Phenylalanine
  UUC -> Phenylalanine
  UCU -> Serine
  UCC -> Serine
  UCA -> Serine
  UCG -> Serine
  UGG -> Tryptophan
  UAU -> Tyrosine
  UAC -> Tyrosine
  UAA -> STOP
  UAG -> STOP
  UGA -> STOP
  """

  @codon_to_protein %{
    "UGU" => "Cysteine",
    "UGC" => "Cysteine",
    "UUA" => "Leucine",
    "UUG" => "Leucine",
    "AUG" => "Methionine",
    "UUU" => "Phenylalanine",
    "UUC" => "Phenylalanine",
    "UCU" => "Serine",
    "UCC" => "Serine",
    "UCA" => "Serine",
    "UCG" => "Serine",
    "UAU" => "Tyrosine",
    "UAC" => "Tyrosine",
    "UGG" => "Tryptophan",
    "UAA" => "STOP",
    "UAG" => "STOP",
    "UGA" => "STOP"
  }

  @spec of_codon(String.t()) :: {atom, String.t()}
  def of_codon(codon) do
    protein = @codon_to_protein[codon]
    if protein == nil do
      {:error, "invalid codon"}
    else
      {:ok, protein}
    end
  end
end
