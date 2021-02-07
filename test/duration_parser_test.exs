defmodule DurationParserTest do
  use ExUnit.Case
  alias Utils.Format, as: Format

  # @tag :pending
  test "parse hour and minutes without zero" do
    assert DurationParser.parse_minutes("2:15") == {:ok, 135}
  end

  # @tag :pending
  test "parse hour and minutes with zero" do
    assert DurationParser.parse_minutes("02:15") == {:ok, 135}
  end

  # @tag :pending)
  test "parse hour and minutes with spaces" do
    assert DurationParser.parse_minutes("2h 35m") == {:ok, 155}
  end

  # @tag :pending
  test "parse parse hour directly" do
    assert DurationParser.parse_minutes("10") == {:ok, 10}
  end

  # @tag :pending
  test "parse minutes with decimal and letter" do
    assert DurationParser.parse_minutes("0.5h") == {:ok, 30}
  end

  # @tag :pending
  test "parse minutes with decimal" do
    assert DurationParser.parse_minutes("0.5") == {:ok, 30}
  end

  # @tag :pending
  test "parse hours with decimals" do
    assert DurationParser.parse_minutes("10.0") == {:ok, 600}
  end

  # @tag :pending
  test "parse hours and minutes with decimals" do
    assert DurationParser.parse_minutes("7.5") == {:ok, 450}
  end

  # @tag :pending
  test "parse hours and minutes with decimals two" do
    assert DurationParser.parse_minutes("24.5") == {:ok, 1470}
  end

  # @tag :pending
  test "parsing error" do
    assert DurationParser.parse_minutes("a24.5") == {:error, "expected 2 digits"}
  end

  # @tag :pending
  test "format phone" do
    assert Format.phone("8005554444") == "(800) 555-4444"
  end
end
