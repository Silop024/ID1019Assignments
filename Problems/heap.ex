defmodule Heap do

    @type heap() :: nil | {integer(), heap(), heap()}

    @spec new() :: heap()
    def new() do
        nil
    end

    @spec add(heap(), integer()) :: heap()
    def add(nil, k) do
        {k, nil, nil}
    end
    def add({key, left, right}, k) do
        if key >= k do
            {key, add(right, k), left}
        else
            {k, add(right, key), left}
        end
    end

    @spec pop(heap()) :: :fail | {:ok, integer(), heap()}
    def pop(nil) do
        :fail
    end
    def pop({key, left, right}) do
        {:ok, key, {nil, left, right}}
    end

end
