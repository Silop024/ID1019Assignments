defmodule Exercise do

    def split(seq) do split(seq, Enum.sum(seq), [], []) end
    def split([], l, left, right) do
        [{left, right, l}]
    end
    def split([s], l, [], right) do
        [{[s], right, l}]
    end
    def split([s], l, left, []) do
        [{left, [s], l}]
    end
    def split([h | t], l, left, right) do
        split(t, l, [h | left], right) ++
        split(t, l, left, [h | right])
    end

    def cost([]) do 0 end
    def cost([_]) do 0 end
    def cost(seq) do cost(seq, 0, [], []) end
    def cost([], l, left, right) do
        cost(left) + cost(right) + l
    end
    def cost([s], l, [], right) do
        cost(right) + l + s
    end
    def cost([s], l, left, []) do
        cost(left) + l + s
    end
    def cost([h | t], l, left, right) do
        cl = cost(t, l + h, [h | left], right)
        cr = cost(t, l + h, left, [h | right])
        if cl < cr do
            cl
        else
            cr
        end
    end

end
