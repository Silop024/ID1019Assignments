defmodule Church do

    def test() do
        four = to_church(4)
        three = to_church(3)
        r = add(four, three)
        #r = minus(four, three)

        to_integer(r)
    end





    def append(a, b) do
        app = fn x, y, f ->
            case x do
                [] -> y
                [h | t] -> [h | f.(t, y, f)]
            end
        end
        app.(a, b, app)
    end

    def to_church(0) do
        fn(_), y -> y end
    end
    def to_church(n) do
        fn(f, x) -> f.(to_church(n - 1).(f, x)) end
    end

    def to_integer(church) do
        church.(fn(x) -> 1 + x end, 0)
    end

    def succ(church) do
        fn(f, x) -> f.(church.(f, x)) end
    end

    def pred(church) do
        fn(f, x) ->
            (church.(fn(g) -> fn(h) -> h.(g.(f)) end end,
            fn(_) -> x end)).(fn(u) -> u end)
        end
    end

    def add(c1, c2) do
        fn(f, x) -> c1.(f, c2.(f, x)) end
    end

    def mul(c1, c2) do
        fn(f, x) -> c1.(fn(y) -> c2.(f, y) end, x) end
    end

    def minus(_c1, _c2) do
        #Subtract from c1 using pred, c2 times
        "nothing, f.(lambda calculus)"
    end
end
