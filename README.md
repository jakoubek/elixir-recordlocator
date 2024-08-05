# Recordlocator for Elixir

**An Elixir module to encode integers into a short and easy to read string and decode the strings back to the initial numbers**

This is the Elixir equivalent to [go-recordlocator](https://github.com/jakoubek/go-recordlocator), [php-recordlocator](https://github.com/jakoubek/php-recordlocator), [lua-recordlocator](https://github.com/jakoubek/lua-recordlocator), [postgresql-recordlocator](https://github.com/jakoubek/postgresql-recordlocator) and [sqlanywhere-recordlocator](https://github.com/jakoubek/sqlanywhere-recordlocator).

A RecordLocator is an alphanumerical string that represents an integer. This package encodes integers to RecordLocators and decodes RecordLocators back to integers.

A RecordLocator is shorter than the corresponding integer and easier to read and memorize. You can use it to encode autoincrement primary keys from an database into an human-readable representation for your users.

## Examples

- The integer 5,325 encodes to the RecordLocator 78G.
- The integer 3,512,345 encodes to the RecordLocator 5E82T.

Both RecordLocators are shorter than their integer equivalent. You can encode more than 33.5 million integers in an 5-char RecordLocator: the largest 5-char RecordLocator, ZZZZZ, represents the integer 33,554,431.

With 6 chars you can encode integers up to more than 1 billion.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `recordlocator` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:recordlocator, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/recordlocator>.





## Usage

Encoding integers to recordlocators:

```elixir
{:ok, rl} = Recordlocator.encode(5325)

rl
# => 78G
```

Decoding recordlocators back into the integer values:

```elixir
{:ok, number} = Recordlocator.decode("78G")

number
# => 5325
```
