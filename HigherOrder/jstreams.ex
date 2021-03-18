defmodule Streams do

    @moduledoc """
    Solutions from johan montelius but I explain it hopefully
    pretty decently
    """

    @doc """
    The basic function needed to operate on our definition
    of range is reduce

    (square brackets do not refer to list, but a closed interval)

    Takes a range, [from, to] example, [1, 10] and applies
    some given function to it.

    It does nothing on its own, it lets other functions operate
    on ranges.

    ## Example
        Streams.sum({:range, 1, 4}) calls reduce with the
        function fn(x,a) -> {:continue, x + a} (lets call it f)
        and initializes the accumulator to 0.

        Streams.reduce({:range, 1, 4}, {:continue, 0}, f)
        as long as from <= to it will recursivly call itself
        incrementing from by one each time and applying the
        given function to "from" which we could say is our head
        in the range and our accumulator.

        We know f = x + a, so what it is doing is adding from to
        our accumulator.

        1st call it does f.(1, 0) = 1 + 0 = 0
        2nd f.(2, 1) = 2 + 1 = 3
        3rd f.(3, 3) = 3 + 3 = 6
        4th f.(4, 6) = 4 + 6 = 10

        After the 4th call from > to and we go to the else
        and we get {:done, 10}

    """
    def reduce({:range, from, to}, {:continue, acc}, function) do
        if from <= to do
            reduce({:range, from + 1, to}, function.(from, acc), function)
        else
            {:done, acc}
        end
    end

    @doc """
    Reduce function to handle lists

    Difference here is that in the recursive call we, instead of
    giving {:range, from + 1, to} we do like we always do with
    lists which is give the tail and apply the function to head
    """
    def reduce([], {:continue, acc}, _) do
        {:done, acc}
    end
    def reduce([h | t], {:continue, acc}, function) do
        reduce(t, function.(h, acc), function)
    end

    @doc """
    Reduce function able to handle suspend
    """
    def reduce(range, {:suspend, acc}, function) do
        {:suspended, acc, fn(cmd) ->
            reduce(range, cmd, function) end}
    end

    @doc """
    Reduce function able to handle halt
    """
    def reduce(_, {:halt, acc}, _) do
        {:halted, acc}
    end

    @doc """
    Reduce able to handle streams
    """
    def reduce({:stream, next_function}, {:continue, acc}, function) do
        case next_function.() do
            {:ok, from, continue} ->
                reduce({:stream, continue}, function.(from, acc), function)
            :nil ->
                {:done, acc}
        end
    end

    @doc """
    Range implemted as stream

    range gives the actual definintion of what range you want

    next allows
    """
    def range(from, to) do
        IO.puts("in range, from: #{from}, to: #{to}")
        {:stream, fn() -> next(from, to) end}
    end

    def next(from, to) do
        IO.puts("in next, from: #{from}, to: #{to}")
        if from <= to do
            {:ok, from, fn() -> next(from + 1, to) end}
        else
            :nil
        end
    end

    @doc """
    Map functions

    First is a mapping with streams

    Second is basic map with a range and function, no stream

    It applies a given function to all elements in the range
    or stream. The function "next" in the stream is always applied
    to no arguments and returns either {:ok, from, continue}
    or :nil
    """
    def map({:stream, next}, function) do
        {:stream,
            fn() -> case next.() do
                        {:ok, from, continue} ->
                            IO.puts("in map, from: #{from}")
                            {:ok, function.(from), continue}
                        :nil ->
                            IO.puts("ugh")
                            :nil
                        end
            end
        }
    end

    def map(range, function) do
        {:done, result} =
            reduce(range, {:continue, []}, fn(x, a) ->
                {:continue, [function.(x) | a]} end)
        result #Return only the result not the tuple
    end

    @doc """
    The sum of all integers in the range
    """
    def sum(range) do
        {:done, result} =
            reduce(range, {:continue, 0}, fn(x, a) ->
                {:cotinue, x + a} end)
        result
    end

    @doc """
    The product of all integers in the range
    """
    def prod(range) do
        {:done, result} =
            reduce(range, {:continue, 1}, fn(x, a) ->
                {:continue, x * a} end)
        result
    end

    @doc """
    A function that takes the first n elements of a range.

    Returns a list with these n elements


    "function" is the actual machinery of take, when we call take,
    the first thing it does is not go into "function", we call
    reduce with the function as an argument.

    So we could say that reduce is doing all the work and take
    is just giving instructions to reduce and intepreting the
    result it gets from it
    """
    def take(range, n) do

        # Defining the function
        function = fn(element, {:sofar, count, acc}) ->
            IO.puts("acc: #{acc}, count: #{count}")
            if count == n do
                {:halt, acc}
            else
                {:continue, {:sofar, count + 1, [element | acc]}}
            end
        end

        # Calling reduce with the function
        case reduce(range, {:continue, {:sofar, 0, []}}, function) do
            {:done, {:sofar, _, result}} ->
                result
            {:halted, result} ->
                result
        end

    end

    @doc """
    Take function with suspend instead of halt
    """
    def susp_take(range, n) do

        # Defining the function
        function = fn(element, {:sofar, count, acc}) ->
            if count == n do
                {:suspend, acc}
            else
                {:continue, {:sofar, count + 1, [element | acc]}}
            end
        end

        # Calling reduce with the function
        reduce(range, {:continue, {:sofar, 0, []}}, function)

    end

    @doc """
    A function that takes a range and some n and returns
    all elements < n
    """
    def up_to(range, n) do
        reduce(range, {:continue, []}, fn(element, acc) ->
            if element < n do
                {:continue, [element | acc]}
            else
                {:halt, acc}
            end
        end)
    end

    @doc """
    A function that returns the sum of all integers < n
    """
    def sum_to(range, n) do
        reduce(range, {:continue, 0}, fn(int, sum) ->
            if int < n do
                {:continue, int + sum}
            else
                {:halt, sum}
            end
        end)
    end

    @doc """
    My own, but very basic now that you know how to do it
    Returns the product of all integers < n
    """
    def prod_to(range, n) do
        reduce(range, {:continue, 1}, fn(int, product) ->
            if int < n do
                {:continue, int * product}
            else
                {:halt, product}
            end
        end)
    end

    @doc """
    Returns the last integer that makes the sum exceed n
    """
    def last(range, n) do
        reduce(range, {:continue, 0}, fn(int, sum) ->
            if int + sum < n do
                {:continue, int + sum}
            else
                {:halt, int}
            end
        end)
    end

    @doc """
    Fibonacci
    """
    def fib() do {:stream, fn() -> fib(1, 1) end} end
    def fib(f1, f2) do
        {:ok, f1, fn() -> fib(f2, f1 + f2) end}
    end

    def test() do
        # Just a generic function that maps all elements x to
        # x * 3
        function = fn(x) -> x * 3 end
        # Call range function to get a stream range 1-10
        range = range(1, 10)

        # Take the first 5 elements of the range 1-10 that is
        # mapped to x * 3
        # Should return [15, 12, 9, 6, 3]
        take(map(range, function), 5)
    end
end
