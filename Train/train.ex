defmodule Train do

    @type train() :: list(atom())

    @type state() :: {train(), train(), train()}

    @type move() :: {:one, number()} | {:two, number()}

    def test() do
        s = {[:a, :b], [:c, :d], [:e, :f]}
        s1 = single({:one, 1}, s)
        s2 = single({:two, 1}, s1)
        s3 = single({:one, -2}, s2)
        s4 = single({:one, 1}, {[:a, :b], [], []})

        moves = [{:one, 1}, {:two, 1}, {:one, -2}]
        move(moves, s)
    end

    def single({_, 0}, {main, t1, t2}) do {main, t1, t2} end
    def single({:one, n}, {main, t1, t2}) when n > 0 do
        move_n_wagons_hi({:one, n}, {main, t1, t2})
    end
    def single({:one, n}, {main, t1, t2}) do
        move_n_wagons_lo({:one, -n}, {main, t1, t2})
    end
    def single({:two, n}, {main, t1, t2}) when n > 0 do
        move_n_wagons_hi({:two, n}, {main, t1, t2})
    end
    def single({:two, n}, {main, t1, t2}) do
        move_n_wagons_lo({:two, -n}, {main, t1, t2})
    end

    def move([], state) do [state | []] end
    def move([h | t], s) do
        [s | move(t, single(h, s))]
    end

    def move_n_wagons_hi({:one, n}, {main, t1, t2}) do
        case main do
            [] -> {main, t1, t2}
            [h | []] -> {[], [h | t1], t2}
            _ ->
                {take(main, len(main) - n), append(drop(main, n), t1), t2}
        end
    end
    def move_n_wagons_hi({:two, n}, {main, t1, t2}) do
        case main do
            [] -> {main, t1, t2}
            [h | []] -> {[], t1, [h | t2]}
            _ ->
                {take(main, len(main) - n), t1, append(drop(main, n), t2)}
        end
    end

    def move_n_wagons_lo({:one, n}, {main, t1, t2}) do
        {append(main, take(t1, n)), drop(t1, n), t2}
    end
    def move_n_wagons_lo({:two, n}, {main, t1, t2}) do
        {append(main, take(t2, n)), t1, drop(t2, n)}
    end


    def take([], _) do [] end
    def take(lst, 0) do [] end
    def take([h | t], n) do
        [h | take(t, n - 1)]
    end

    def drop([], _) do [] end
    def drop(lst, 0) do lst end
    def drop([_h | t], n) do
        #if n < 0 do n = -n end
        drop(t, n - 1)
    end

    def append(first, last) do
        case first do
            [] -> last
            [h | t] -> [h | append(t, last)]
            _ -> :error
        end
    end

    def member([], _) do :false end
    def member([h | t], x) do
        if h == x do
            :true
        else
            member(t, x)
        end
    end

    def position(lst, x) do
        position(lst, x, 1)
    end
    def position([], _, _) do :error end
    def position([h | t], x, n) do
        if h == x do
            n
        else
            position(t, x, n + 1)
        end
    end

    def len(lst) do
        len(lst, 0)
    end
    def len([], n) do n end
    def len([_h | t], n) do
        len(t, n + 1)
    end

end
