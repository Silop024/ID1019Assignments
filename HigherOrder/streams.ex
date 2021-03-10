defmodule Streams do

    #1
    def sum({:range, from, from}) do from end
    def sum({:range, from, to}) do
        to + sum({:range, from, to - 1})
    end


    #2
    def sumR(range) do reduce(range, 0, fn(x, a) -> x + a end) end

    def reduce({:range, from, to}, acc, func) do
        if from <= to do
            reduce({:range, from, to - 1}, func.(to, acc), func)
        else
            acc
        end
    end


    #3
    def map({:range, from, from}, func) do [func.(from)] end
    def map({:range, from, to}, func) do
        [func.(from) | map({:range, from + 1, to}, func)]
    end

    def take({:range, _, _}, 0) do [] end
    def take({:range, from, to}, n) do
        [from | take({:range, from + 1, to}, n - 1)]
    end


    #4
    def sumG(range) do
        reduceG(range, {:cont, 0}, fn(x, a) -> {:cont, x + a} end)
    end

    def reduceG({:range, from, to}, {:cont, acc}, func) do
        if from <= to do
            reduceG({:range, from + 1, to}, func.(from, acc), func)
        else
            {:done, acc}
        end
    end
    def reduceG({:range, _from, _to}, {:halt, acc}, _func) do
        {:halted, acc}
    end


    #5
    def takeG(range, n) do
        {_, res} = reduceG(range, {:cont, {:sofar, 0, []}},
            fn(x, {:sofar, s, acc}) ->
                if s == n do
                    {:halt, acc}
                else
                    {:cont, {:sofar, s + 1, [x | acc]}}
                end
            end)
        case res do
            {_, _, r} -> r
            _ -> res
        end
    end

end
