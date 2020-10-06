defmodule Soapboxer.CutTest do
  use ExUnit.Case

  describe "between_clause/1" do
    test "when single cut, creates the ffmpeg `between` filter clause" do
      cuts = [%{cut_start: 4, cut_end: 10}]

      assert Soapboxer.Cut.between_clause(cuts) ==
               "between(t,4,10)"
    end

    test "when many cuts, creates the ffmpeg `between` filter clause" do
      cuts = [
        %{cut_start: 4, cut_end: 10},
        %{cut_start: 12, cut_end: 15},
        %{cut_start: 18, cut_end: 20}
      ]

      assert Soapboxer.Cut.between_clause(cuts) ==
               "between(t,4,10)+between(t,12,15)+between(t,18,20)"
    end
  end

  describe "between_snippet/2" do
    test "creates the associated ffmpeg `between` snippet" do
      assert Soapboxer.Cut.between_snippet(%{cut_start: 4, cut_end: 10}) ==
               "between(t,4,10)"
    end
  end
end
