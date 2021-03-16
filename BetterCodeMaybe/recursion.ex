defmodule Recursion do
    @moduledoc """
    Better solutions of the recursion exercises
    """

    @doc """
    Returns the sum of all elements in a list

    O(n) time complexity
    """
    def sum(lst) do sum(lst, 0) end
    def sum([], sum) do sum end
    def sum([h | t], sum) do sum(t, h + sum) end

    @doc """
    Returns the length of a list

    O(n) time complexity
    """
    def len(list) do len(list, 0) end
    def len([], n) do n end
    def len([_h | t], n) do len(t, n + 1) end

    @doc """
    Returns the nth element of a list, or nil if there isnt one,
    0 indexed.

    O(n) time complexity
    """
    def nth(_, []) do nil end
    def nth(0, [h | _]) do h end
    def nth(n, [_h | t]) do nth(n - 1, t) end

    @doc """
    Returns a reversed version of a given list

    O(n) time complexity
    """
    def rev(lst) do rev(lst, []) end
    def rev([], rlst) do rlst end
    def rev([h | t], rlst) do rev(t, [h | rlst]) end

    @doc """
    Returns a list of unique elements from a given list

    Not sure about time complexity probably O(n^2)
    """
    def unique([]) do [] end
    def unique([h | t]) do
        [h | for(x <- unique(t), x != h, do: x)]
    end

    @doc """
    Returns a list where all elements e are removed from it

    Not sure about time complexity, around O(n) I would guess?
    """
    def remove(_, []) do [] end
    def remove(e, [e | t]) do remove(e, t) end
    def remove(e, [h | t]) do [h | remove(e, t)] end

    @doc """
    Returns the list with the added element e if there didnt
    an element e in the list already.

    Not sure about time complexity, around O(n)?
    """
    def add(e, []) do [e] end
    def add(e, [e | t]) do [e | t] end
    def add(e, [h | t]) do [h | add(e, t)] end

    @doc """
    Returns a list with all elements of its duplicated

    O(n) time complexity
    """
    def dupe(lst) do dupe(lst, []) end
    def dupe([], duped) do duped end
    def dupe([h | t], duped) do dupe(t, [h, h | duped]) end

    @doc """
    Returns a list of lists with equal elements

    Not sure about time complexity,
    pack is O(n), add_pack is around O(n), so O(n^2)?
    """
    def pack(lst) do pack(lst, []) end
    def pack([], packed) do packed end
    def pack([h | t], packed) do pack(t, add_pack(h, packed)) end
    def add_pack(e, []) do [[e]] end
    def add_pack(e, [[e | _]=sub | rest]) do
        [[e | sub] | rest]
    end
    def add_pack(e, [h | t]) do [h | add_pack(e, t)] end

    @doc """
    Inserts an element into an alread sorted list, keeping the
    order.

    Not sure about time complexity, around O(n)?
    """
    def insert(e, []) do [e] end
    def insert(e, [h | t]) when h < e do [h | insert(e, t)] end
    def insert(e, lst) do [e | lst] end

    @doc """
    Returns a sorted list of integers.

    Not sure about time complexity,
    insert is ~O(n) and isort is ~O(n) so, O(n^2) total?
    """
    def isort(lst) do isort(lst, []) end
    def isort([], sorted) do sorted end
    def isort([h | t], sorted) do isort(t, insert(h, sorted)) end


end
