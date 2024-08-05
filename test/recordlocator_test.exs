defmodule RecordlocatorTest do
  use ExUnit.Case
  doctest Recordlocator

  import Recordlocator

  describe "encode/1" do
    test "encodes 0 correctly" do
      assert encode(0) == {:ok, "2"}
    end

    test "encodes small numbers correctly" do
      assert encode(1) == {:ok, "3"}
      assert encode(31) == {:ok, "Z"}
    end

    test "encodes medium numbers correctly" do
      assert encode(32) == {:ok, "32"}
      assert encode(1000) == {:ok, "ZA"}
    end

    test "encodes large numbers correctly" do
      assert encode(5325) == {:ok, "78G"}
      assert encode(3_512_345) == {:ok, "5E82T"}
    end

    test "encodes very large numbers correctly" do
      assert encode(1_000_000_000) == {:ok, "XTOLJ2"}
      assert encode(1_000_000_001) == {:ok, "XTOLJ3"}
    end

    test "encode gives error for invalid values" do
      assert encode(-1) == {:error, "Input must be a non-negative integer"}
    end

    test "encode! raises ArgumentError for negative numbers" do
      assert_raise ArgumentError, fn ->
        encode!(-1)
      end
    end
  end

  describe "decode/1" do
    test "decodes 0 correctly" do
      assert decode("2") == {:ok, 0}
    end

    test "decodes small numbers correctly" do
      assert decode("3") == {:ok, 1}
      assert decode("Z") == {:ok, 31}
    end

    test "decodes with lower case characters correctly" do
      assert decode("3a") == {:ok, 40}
    end

    test "decodes large numbers correctly" do
      assert decode("78G") == {:ok, 5325}
      assert decode("78H") == {:ok, 5326}
      assert decode("5E82T") == {:ok, 3_512_345}
    end

    test "decode gives error for invalid characters" do
      assert decode("B") == {:error, "Invalid character in input string: B"}
    end

    test "decode! raises ArgumentError for invalid characters" do
      assert_raise ArgumentError, fn ->
        decode!("B")
      end
    end
  end
end
