defmodule SoapboxerClientWeb.VideoLive do
  use SoapboxerClientWeb, :live_view
  import SoapboxerClientWeb.VideoHelpers

  def mount(_params, _session, socket) do
    {:ok,
     assign(
       socket,
       edits: [],
       edit_type: "cut",
       active_edit: nil
     )}
  end

  def handle_event(
        "timeline-clicked",
        %{"offsetX" => pos} = _event,
        socket
      ) do
    pos = div(pos, 10)

    socket =
      case valid_position(pos, socket.assigns) do
        true -> create_edit(socket, socket.assigns, pos)
        _ -> socket
      end

    {:noreply, socket}
  end

  def create_edit(socket, %{edit_type: "zoom"}, _pos), do: socket

  def create_edit(socket, %{edit_type: "cut", active_edit: nil}, pos) do
    edit = %{edit_type: "cut", start: pos, end: nil}
    assign(socket, :active_edit, edit)
  end

  def create_edit(socket, %{edit_type: "cut", active_edit: active}, pos) do
    active =
      case pos > active.start do
        true ->
          %{active | end: pos}

        false ->
          start = active.start
          %{active | start: pos, end: start}
      end

    socket =
      update(socket, :edits, fn edits ->
        [active | edits]
      end)

    assign(socket, :active_edit, nil)
  end
end
