defmodule Improved do

    ##LENGTH OF LIST
    def len(list) do len(list, 0) end
    def len([], n) do n end
    def len([_h | t], n) do
        len(t, n + 1)
    end

    ##REVERSE LIST
    def rev(lst) do rev(lst, []) end
    def rev(lst, rlst) do
        case lst do
            [] -> rlst
            [h | t] -> rev(t, [h | rlst])
        end
    end

    ##LIST OF UNIQUE ELEMENTS
    def unique(lst) do
        case lst do
            [] -> []
            [h | t] -> [h | for(x <- unique(t), x != h, do: x)]
        end
    end

    ##INSERT AN ELEMENT IN A SORTED LIST
    def insert(e, []) do [e] end
    def insert(e, [h | t]) do
        if e <= h do
            [e | [h | t]]
        else
            [h | insert(e, t)]
        end
    end

    ##MERGE SORT
    def msort(lst) do
        case lst do
            [] -> []
            [x] -> [x]
            _ ->
            {left, right} = msplit(lst, [], [])
            merge(msort(left), msort(right))
        end
    end
    def merge([], right) do right end
    def merge(left, []) do left end
    def merge([hl | tl] = left, [hr | tr] = right) do
        if hl < hr do
            [hl | merge(tl, right)]
        else
            [hr | merge(left, tr)]
        end
    end
    def msplit([], left, right) do {left, right} end
    def msplit([h | t], left, right) do
        msplit(t, [h | right], left)
    end


    @doc """
    DISCLAIMER: Not my own reverse functions
    These functions are taken from "5 Reverse" in introduction.pdf

    Do performance analysis of these two functions with bench
    """
    # Not tail recursive
    def nreverse([]) do [] end
    def nreverse([h | t]) do
        r = nreverse(t)
        append(r, [h])
    end
    # Tail recursive
    def reverse(l) do
        reverse(l, [])
    end
    def reverse([], r) do r end
    def reverse([h | t], r) do
        reverse(t, [h | r])
    end


    def bench() do
        lst = [16, 32, 64, 128, 256, 512, 1024]
        n = 100
        # bench is a closure: a function with an environment

        bench = fn(l) ->
            sequence = Enum.to_list(1..l)
            tn = time(n, fn -> nreverse(sequence) end)
            tr = time(n, fn -> reverse(sequence) end)
            :io.format("length : ~6w nrev: ~8w us rev: ~8w us~n", [l, tn, tr])
        end

        # We use the library function Enum.each that will call
        # bench(l) for each element l in lst
        Enum.each(lst, bench)
    end

    # Time, the execution time of a function
    def time(n, func) do
        start = System.monotonic_time(:millisecond)
        loop(n, func)
        stop = System.monotonic_time(:millisecond)
        stop - start
    end

    # Apply the function n times
    def loop(n, func) do
        if n == 0 do
            :ok
        else
            func.()
            loop(n - 1, func)
        end
    end

    # Findings were that nreverse was by orders of magnitude
    # worse than reverse which shows the power of tail recursion.
    # I guess it has something to do with operations only being
    # done on the way down for tail recursion where as nreverse
    # does operations on the list both ways.



    @doc """
    Integer to binary
    """
    def to_binary(0) do [] end
    def to_binary(n) do
        [rem(n, 2) | to_binary(div(n, 2))]
    end

    def acc_binary(n) do acc_binary(n, []) end
    def acc_binary(0, acc) do acc end
    def acc_binary(n, acc) do
        acc_binary(div(n, 2), [rem(n, 2) | acc])
    end

    @doc """
    Binary to integer
    """
    def to_int(bin) do to_int(bin, 0) end
    def to_int([], acc) do
        acc
    end
    def to_int([h | t], acc) do
        to_int(t, acc*2 + h)
    end


    @doc """
    Fibonacci
    """
    def fib(0) do 0 end
    def fib(1) do 1 end
    def fib(n) do
        fib(n - 1) + fib(n - 2)
    end

    def bench_fib() do
        lst = [8,10,12,14,16,18,20,22,24,26,28,30,32]
        n = 10

        bench = fn(l) ->
            t = time(n, fn() -> fib(l) end)
            :io.format("n: ~4w fib(n) calculated in: ~8w us~n", [l, t])
        end
        Enum.each(lst, bench)
    end






    @doc """
    Functions needed to run other functions
    """
    def append(first, last) do
        case first do
            [] -> last
            [h | t] -> [h | append(t, last)]
            _ -> :error
        end
    end
end
