defmodule Exam do

    #1
    def drop(lst, nth) do
        drop(lst, nth, 1, [])
    end
    def drop([], _, _, acc) do acc end
    def drop([h | t], nth, n, acc) do
        if rem(n, nth) != 0 do
            drop(t, nth, n + 1, [h | acc])
        else
            drop(t, nth, n + 1, acc)
        end
    end


    #2
    def rotate(lst, n) do
        rotate(lst, n, [])
    end
    def rotate([], _, acc) do acc end
    def rotate(lst, 0, acc) do
        append(lst, reverse(acc))
    end
    def rotate([h | t], n, acc) do
        rotate(t, n - 1, [h | acc])
    end

    def append(first, last) do
        case first do
            [] -> last
            [h | t] -> [h | append(t, last)]
            _ -> :error
        end
    end

    def reverse(list) do
        reverse([], list)
    end
    defp reverse(rev_lst, []) do rev_lst end
    defp reverse(rev_lst, [head | tail]) do
        reverse([head | rev_lst], tail)
    end


    #3
    @type tree() :: {:leaf, any()} | {:node, tree(), tree()}

    def nth(1, {:leaf, val}) do
        {:found, val}
    end
    def nth(n, {:leaf, _}) do
        {:cont, n-1}
    end
    def nth(n, {:node, left, right}) do
        case nth(n, left) do
            {:cont, k} -> nth(k, right)
            {:found, val} -> {:found, val} 
        end
    end

end
