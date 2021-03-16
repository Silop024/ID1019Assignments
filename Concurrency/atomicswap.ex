defmodule Cell do

    def new(), do: spawn_link(fn -> cell(:open) end)

    defp cell(state) do
        receive do
            {:swap, value, from} ->
                send(from, {:ok, state})
                cell(value)
            {:set, value, from} ->
                send(from, :ok)
                cell(value)
        end
    end

    def swap(cell, value) do
        send(cell, {:swap, value, self()})
        receive do
            {:ok, value} -> value
        end
    end

    def get(cell) do
        send(cell, {:get, self()})
        receive do
            {:ok, value} -> value
        end
    end

    def set(cell, value) do
        send(cell, {:set, value, self()})
        receive do
            :ok -> :ok
        end
    end

    def do_it(op, lock) do
        case Cell.swap(lock, :taken) do
            :taken ->
                do_it(op, lock)
            :open ->
                do_critical(op)
                Cell.set(lock, :open)
        end
    end

    def do_critical(op) do
        IO.puts("omg! #{op}")
    end
end
