defmodule Streams do

    #1.1 Sum of all integers
    def sum({:range, from, from}) do from end
    def sum({:range, from, to}) do
        to + sum({:range, from, to - 1})
    end


    def sumR(range) do reduce(range, 0, fn(x, a) -> x + a end) end

    def reduce({:range, from, to}, acc, func) do
        if from <= to do
            reduce({:range, from, to - 1}, func.(to, acc), func)
        else
            acc
        end
    end


    def map({:range, from, from}, func) do [func.(from)] end
    def map({:range, from, to}, func) do
        [func.(from) | map({:range, from + 1, to}, func)]
    end

    #1.2
    def take({:range, _, _}, 0) do [] end
    def take({:range, from, to}, n) do
        [from | take({:range, from + 1, to}, n - 1)]
    end


    def sumG(range) do
        {_, res} = reduceG(range, {:cont, 0}, fn(x, a) -> {:cont, x + a} end)
        res
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
    #1.4 Reduce a list
    def reduceG([h | t], {:cont, acc}, func) do
        reduceG(t, func.(h, acc), func)
    end
    def reduceG([], {:cont, acc}, _) do
        {:done, acc}
    end
    #2.1
    def reduceG({:stream, fun}, {:cont, acc}, func) do
        case fib(fun, func) do
            {:ok, from, cont} ->
                reduceG({:stream, fun}, func.(from, acc), func)
            :nil ->
                {:done, acc}
        end
    end

    #1.2
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

    #1.3
    ##do stuff here

    #2.1
    def fib() do {:stream, fn() -> fib(1, 1) end} end
    def fib(f1, f2) do
        {:ok, f1, fn() -> fib(f2, f1 + f2) end}
    end

    #2.2
    def next(from, to) do
        if from <= to do
            {:ok, from, fn() -> next(from + 1, to) end}
        else
            :nil
        end
    end

    def range(from, to) do
        {:stream, fn() -> next(from, to) end}
    end

    def mapG({:stream, next}, func) do
        {:stream, fn() -> case next.() do
                                {:ok, from, cont} ->
                                    {:ok, func.(from), cont}
                                :nil ->
                                    :nil
                                end
                            end
                        }
    end




end
