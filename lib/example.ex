defmodule Utils.Format do
  @moduledoc """
  Functions for common string formatting.
  """

  @doc """
  Format a phone number with an expected area code.

  ## Examples

      iex> Format.phone("8005554444")
      "(800) 555-4444"

      iex> Format.phone("5554444")
      "555-4444"

      iex> Format.phone("short")
      "short"

      iex> Format.phone(nil)
      nil

  """
  @spec phone(value :: nil | String.t()) :: nil | String.t()
  def phone(value)

  def phone(nil), do: nil

  def phone(<<area::binary-size(3), three::binary-size(3), four::binary-size(4)>>) do
    "(#{area}) #{three}-#{four}"
  end

  def phone(<<three::binary-size(3), four::binary-size(4)>>) do
    "#{three}-#{four}"
  end

  def phone(other) when is_binary(other), do: other
end
