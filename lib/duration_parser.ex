defmodule DurationParser do
  @moduledoc """
    Parse a given string as either a time interval or a fractional number of hours
    and return the equivalent number of hours and minutes.
  """

  @spec parse_minutes(<<_::16, _::_*8>>) :: {:ok, integer}
  def parse_minutes(<<hours_bin::bytes-size(1)>> <> ":" <> <<minutes_bin::bytes-size(2)>>),
    do: parse_time(hours_bin, minutes_bin, :integer)

  def parse_minutes(<<hours_bin::bytes-size(2)>> <> ":" <> <<minutes_bin::bytes-size(2)>>),
    do: parse_time(hours_bin, minutes_bin, :integer)

  def parse_minutes(
        <<hours_bin::bytes-size(1)>> <>
          "h " <>
          <<minutes_bin::bytes-size(2)>> <>
          "m"
      ),
      do: parse_time(hours_bin, minutes_bin, :integer)

  def parse_minutes(
        <<hours_first::bytes-size(1)>> <> "." <> <<hour_second::bytes-size(1)>> <> "h"
      ),
      do: parse_time(hours_first <> "." <> hour_second, nil, :float)

  def parse_minutes(<<hours_first::bytes-size(1)>> <> "." <> <<hour_second::bytes-size(1)>>),
    do: parse_time(hours_first <> "." <> hour_second, nil, :float)

  def parse_minutes(<<hours_first::bytes-size(2)>> <> "." <> <<hour_second::bytes-size(1)>>),
    do: parse_time(hours_first <> "." <> hour_second, nil, :float)

  def parse_minutes(<<minutes_bin::bytes-size(2)>>), do: parse_time(nil, minutes_bin, :integer)

  defp parse_time(nil, minutes_bin, type) do
    minutes = minutes_bin |> parse_min(type)
    {:ok, minutes}
  end

  defp parse_time(hour_bin, nil, type) do
    hour = hour_bin |> parse_hour(type)
    {:ok, hour}
  end

  defp parse_time(hour_bin, minutes_bin, type) do
    hour = hour_bin |> parse_hour(type)
    minutes = minutes_bin |> parse_min(type)
    {:ok, hour + minutes}
  end

  defp parse_hour(hour_bin, :integer) do
    {hour, _} =
      hour_bin
      |> Integer.parse()

    hour |> convert_to_sec()
  end

  defp parse_hour(hour_bin, :float) do
    {hour, _} =
      hour_bin
      |> Float.parse()

    hour |> convert_to_sec()
  end

  defp parse_min(minutes_bin, :integer) do
    {minutes, _} =
      minutes_bin
      |> Integer.parse()

    minutes
  end

  defp convert_to_sec(time) do
    time * 60
  end
end
