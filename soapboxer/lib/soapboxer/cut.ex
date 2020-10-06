defmodule Soapboxer.Cut do
  import FFmpex
  use FFmpex.Options

  def between_clause(cuts) do
    Enum.map(cuts, &between_snippet/1)
    |> Enum.join("+")
  end

  def between_snippet(cut) do
    "between(t,#{cut.start},#{cut.end})"
  end

  def build_command(input, output, cuts) do
    filter_clause = between_clause(cuts)

    vf = %FFmpex.Option{
      name: "-vf",
      argument: "select='not(#{filter_clause})',setpts=N/FRAME_RATE/TB"
    }

    af = %FFmpex.Option{
      name: "-af",
      argument: "aselect='not(#{filter_clause})',asetpts=N/SR/TB"
    }

    FFmpex.new_command()
    |> add_global_option(option_y())
    |> add_input_file(input)
    |> add_output_file(output)
    |> add_file_option(vf)
    |> add_file_option(af)
  end

  def execute(input, output, cuts) do
    build_command(input, output, cuts)
    |> execute
  end
end
