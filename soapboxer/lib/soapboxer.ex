defmodule Soapboxer do
  def main(args) do
    [input | edits] = args

    [first | rest] = String.split("input.mp4", ".")
    output = [first | [".edited." | rest]] |> Enum.join()

    {:ok, body} = File.read(edits)
    cuts = Jason.decode!(body, keys: :atoms)

    case Soapboxer.Cut.execute(input, output, cuts) do
      :ok -> IO.puts("Created #{output}")
      _ -> IO.puts("An error occured")
    end
  end
end
