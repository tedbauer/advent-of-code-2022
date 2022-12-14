defmodule ElfGrouper do
  def group_by_elf(acc, last_elf) do
    case IO.read(:stdio, :line) do
      :eof ->
        acc ++ [last_elf]

      {:error, reason} ->
        IO.puts("Error: #{reason}")

      line ->
        case line do
          "\n" ->
            group_by_elf(acc ++ [last_elf], 0)

          number ->
            number
            |> String.trim()
            |> String.to_integer()
            |> then(&group_by_elf(acc, last_elf + &1))
        end
    end
  end
end

elves = ElfGrouper.group_by_elf([], 0)

List.foldl(elves, -1, fn cand, curr_max ->
  if cand > curr_max do
    cand
  else
    curr_max
  end
end)
|> IO.puts()
