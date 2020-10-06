defmodule SoapboxerClientWeb.VideoHelpers do
  def valid_position(_pos, %{edits: edits}) when length(edits) == 0, do: true

  def valid_position(pos, %{edits: edits, active_edit: nil}) do
    do_validate_start(pos, edits, true)
  end

  def valid_position(pos, %{edits: edits, active_edit: active}) do
    do_validate_end(pos, active, edits, true)
  end

  defp do_validate_start(_pos, [], valid), do: valid
  defp do_validate_start(_pos, _edits, false), do: false

  defp do_validate_start(pos, edits, _valid) do
    [edit | rest] = edits

    do_validate_start(
      pos,
      rest,
      MapSet.disjoint?(MapSet.new([pos]), MapSet.new(edit.start..edit.end))
    )
  end

  defp do_validate_end(_pos, _active, [], valid), do: valid
  defp do_validate_end(_pos, _active, _edits, false), do: false

  defp do_validate_end(pos, active, edits, _valid) do
    [edit | rest] = edits

    size =
      MapSet.new(active.start..pos)
      |> MapSet.intersection(MapSet.new(edit.start..edit.end))
      |> MapSet.size()

    do_validate_end(
      pos,
      active,
      rest,
      size == 0
    )
  end

  def position_step(pos) do
    pos * 10
  end
end
