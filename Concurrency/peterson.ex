defmodule Cell do

    def new(), do: spawn_link(fn -> cell(:open) end)

    defp cell(state) do
        receive do
            {:get, from} ->
                send(from, {:ok, state})
                cell(state)

            {:set, value, from} ->
                send(from, :ok)
                cell(value)
        end
    end

    def get(cell) do
        send(cell, {:get, self()})
        receive do
            {:ok, value} -> value
        end
    end
    def set(cell, value) do
        send(cell, {:Set, value, self()})
        receive do
            :ok -> :ok
        end
    end

    def lock(id, m, p, q) do
        Cell.set(m, true)
        other = rem(id + 1, 2)
        Cell.set(q, other)

        case Cell.get(p) do
            false -> :locked
            true ->
                case Cell.get(p) do
                    ^id -> :locked
                    ^other -> lock(id, m, p, q)
                end
        end
    end
    def unlock(_id, m, _p, _q) do
        Cell.set(m, false)
    end
end
