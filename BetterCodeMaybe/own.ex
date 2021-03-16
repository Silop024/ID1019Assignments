defmodule Own do

    @doc """
    Returns a list with every nth element removed, problem stolen
    from old exam
    """
    def remove_nth(n, lst) do remove_nth(n, n, lst, []) end
    def remove_nth(_, _, [], removed) do removed end
    def remove_nth(1, nth, [_ | t], removed) do
        remove_nth(nth, nth, t, removed)
    end
    def remove_nth(n, nth, [h | t], removed) do
        remove_nth(n - 1, nth, t, [h | removed])
    end

    # Other version, naive, not tail recursive
    def nremove(n, lst) do nremove(n, n, lst) end
    def nremove(_, _, []) do [] end
    def nremove(1, nth, [_ | t]) do nremove(nth, nth, t) end
    def nremove(n, nth, [h | t]) do
        [h | nremove(n - 1, nth, t)]
    end

    @doc """
    Returns a list with every nth element kept
    """
    def keep_nth(n, lst) do keep_nth(n, n, lst, []) end
    def keep_nth(_, _, [], kept) do kept end
    def keep_nth(1, nth, [h | t], kept) do
        keep_nth(nth, nth, t, [h | kept])
    end
    def keep_nth(n, nth, [_ | t], kept) do
        keep_nth(n - 1, nth, t, kept)
    end

    # Naive version, not tail recursive
    def nkeep_nth(n, lst) do nkeep_nth(n, n, lst) end
    def nkeep_nth(_, _, []) do [] end
    def nkeep_nth(1, nth, [h | t]) do
        [h | nkeep_nth(nth, nth, t)]
    end
    def nkeep_nth(n, nth, [_ | t]) do nkeep_nth(n - 1, nth, t) end

    @doc """
    Splits a list into three lists,
    returns a list of three lists

    Feels like all these 3 problems are the same
    """
    def tri_split(lst) do tri_split(2, lst, [], [], []) end
    def tri_split(_, [], l1, l2, l3) do [l1, l2, l3] end
    def tri_split(0, [h | t], l1, l2, l3) do
        tri_split(2, t, l1, l2, [h | l3])
    end
    def tri_split(n, [h | t], l1, l2, l3) do
        tri_split(n - 1, t, [h | l2], l1, l3)
    end

    @doc """
    Selection sort
    """
    def select_sort([]) do [] end
    def select_sort(lst) do select_sort(lst, []) end

    def select_sort([], sorted) do sorted end
    def select_sort([h | t], sorted) do
        {max, rest} = get_max(t, h, [])
        select_sort(rest, [max | sorted])
    end

    def get_max([], max, rest) do {max, rest} end
    def get_max([h | t], max, rest) when h < max do
        get_max(t, max, [h | rest])
    end
    def get_max([h | t], max, rest) do
        get_max(t, h, [max | rest])
    end


end
