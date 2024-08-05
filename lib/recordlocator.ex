defmodule Recordlocator do
  @moduledoc """
  Documentation for `Recordlocator`.
  """

  @char_map %{
    0 => ~c"2",
    1 => ~c"3",
    2 => ~c"4",
    3 => ~c"5",
    4 => ~c"6",
    5 => ~c"7",
    6 => ~c"8",
    7 => ~c"9",
    8 => ~c"A",
    9 => ~c"C",
    10 => ~c"D",
    11 => ~c"E",
    12 => ~c"F",
    13 => ~c"G",
    14 => ~c"H",
    15 => ~c"I",
    16 => ~c"J",
    17 => ~c"K",
    18 => ~c"L",
    19 => ~c"M",
    20 => ~c"N",
    21 => ~c"O",
    22 => ~c"P",
    23 => ~c"Q",
    24 => ~c"R",
    25 => ~c"T",
    26 => ~c"U",
    27 => ~c"V",
    28 => ~c"W",
    29 => ~c"X",
    30 => ~c"Y",
    31 => ~c"Z"
  }

  @reverse_char_map Map.new(@char_map, fn {k, v} -> {to_string(v), k} end)

  @doc """
  Encodes an integer into a Recordlocator.

  ## Examples

    iex> Recordlocator.encode(5325)
    {:ok, "78G"}

    iex> Recordlocator.encode(3512345)
    {:ok, "5E82T"}

    iex> Recordlocator.encode(-1)
    {:error, "Input must be a non-negative integer"}
  """
  @spec encode(integer) :: {:ok, String.t()} | {:error, String.t()}
  def encode(integer) when is_integer(integer) and integer >= 0 do
    result =
      do_encode(integer, [])
      |> IO.iodata_to_binary()

    {:ok, result}
  end

  def encode(integer) when is_integer(integer) do
    {:error, "Input must be a non-negative integer"}
  end

  def encode(_) do
    {:error, "Input must be an integer"}
  end

  @doc """
  Encodes an integer into a Recordlocator.
  Throws an ArgumentError for errors.

  ## Examples

  iex> Recordlocator.encode!(5325)
  "78G"

  iex> Recordlocator.encode!(3512345)
  "5E82T"

  iex> Recordlocator.encode!(-1)
  ** (ArgumentError) Input must be a non-negative integer

  """
  @spec encode!(integer) :: String.t()
  def encode!(integer) do
    case encode(integer) do
      {:ok, result} -> result
      {:error, reason} -> raise ArgumentError, reason
    end
  end

  defp do_encode(0, acc) when length(acc) > 0, do: acc

  defp do_encode(integer, acc) when integer >= 0 do
    remainder = rem(integer, 32)
    new_integer = div(integer, 32)
    new_acc = [@char_map[remainder] | acc]

    do_encode(new_integer, new_acc)
  end

  @doc """
  Decodes Recordlocator string back into an integer.
  Returns {:ok, integer} for valid Recordlocators and {:error, reason} for invalid characters.

  ## Examples

  iex> Recordlocator.decode("78G")
  {:ok, 5325}

  iex> Recordlocator.decode("5E82T")
  {:ok, 3512345}

  iex> Recordlocator.decode("2")
  {:ok, 0}

  iex> Recordlocator.decode("ABC")
  {:error, "Invalid character in input string: B"}
  """
  @spec decode(String.t()) :: {:ok, non_neg_integer} | {:error, String.t()}
  def decode(string) when is_binary(string) do
    string
    |> String.upcase()
    |> String.graphemes()
    |> Enum.reduce_while({:ok, 0}, fn char, {:ok, acc} ->
      case Map.fetch(@reverse_char_map, char) do
        {:ok, value} -> {:cont, {:ok, acc * 32 + value}}
        :error -> {:halt, {:error, "Invalid character in input string: #{char}"}}
      end
    end)
  end

  def decode(_), do: raise(ArgumentError, "Input must be a string")

  @doc """
  Decodes Recordlocator string back into an integer.
  Throws an ArgumentError if the input string contains invalid characters.

  ## Examples

  iex> Recordlocator.decode!("78G")
  5325

  iex> Recordlocator.decode!("5E82T")
  3512345

  iex> Recordlocator.decode!("2")
  0

  iex> Recordlocator.decode!("ABC")
  ** (ArgumentError) Invalid character in input string: B
  """
  @spec decode!(String.t()) :: non_neg_integer
  def decode!(string) do
    case decode(string) do
      {:ok, result} -> result
      {:error, reason} -> raise ArgumentError, reason
    end
  end
end
