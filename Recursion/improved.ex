defmodule Improved do

    def len(list) do len(list, 0) end
    def len([], n) do n end
    def len([_h | t], n) do
        len(t, n + 1)
    end

    def rev(lst) do rev (lst, []) end
    def rev(lst, rlst) do
        case lst do
            [] -> rlst
            [h | t] -> rev(t | [h | rlst])
        end
    end

    def unique(lst) do
        case lst do
            [] -> []
            [h | t] -> [h | for(x <- unique(t), x != h, do: x)]
        end
    end

    def insert(e, []) do [e] end
    def insert(e, [h | t]) do
        if e <= h do
            [e | [h | t]]
        else
            [h | insert(e, t)]
        end
    end
end
