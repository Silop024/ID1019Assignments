defmodule Dynamic do

    @type product() :: {number(), number(), number()}

    def test() do
        hinge = {260, 40, 30}
        latch = {180, 60, 24}
        mat = 2400
        time = 480
        search(mat, time, hinge, latch)
    end
    def search(mat, time, {hm, ht, hp}=h, {lm, lt, lp}=l) when  (hm <= mat) and
                                                                (lm <= mat) and
                                                                (ht <= time) and
                                                                (lt <= time) do
        {h1, l1, p1} = search((mat - hm), (time - ht), h, l)
        {h2, l2, p2} = search((mat - lm), (time - lt), h, l)
        if (p1 + hp) > (p2 + lp) do
            {(h1 + 1), l1, (p1 + hp)}
        else
            {h2, (l2 + 1), (p2 + lp)}
        end
    end
    def search(mat, time, {hm, ht, hp}=h, l) when (mat >= hm) and
                                                  (time >= ht) do
        {hn, ln, p} = search((mat - hm), (time - ht), h, l)
        {(hn + 1), ln, (p + hp)}
    end
    def search(mat, time, h, {lm, lt, lp}=l) when (mat >= lm) and
                                                  (time >= lt) do
        {hn, ln, p} = search((mat - lm), (time - lt), h, l)
        {hn, (ln + 1), (p + lp)}
    end
    def search(_, _, _, _) do
        {0, 0, 0}
    end

    def fib(0) do {0, nil} end
    def fib(1) do  {1, 0} end
    def fib(n) do
        {n1, n2} = fib(n - 1)
        {n1+n2, n1}
    end

end
