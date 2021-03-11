defmodule Recursion do

    @moduledoc """
    My solutions to the exercises in introduction.pdf
    """



    @doc """
    Computes the product of m to the power of n

    Returns the product

    ## Example

            iex> Recursion.power(2,8)
            256
    """
    def power(m, n) do
        case n do
            0 -> 1
            1 -> m
            _ -> prod(power(m, n - 1), m)
        end
    end

    def qpower(m, n) do
        case n do
            0 -> 1
            1 -> m
            _ -> qpower(m, div(n, 2) + rem(n, 2)) * qpower(m, div(n, 2))
        end
    end

    def exp(x, n) do
        cond do
            n == 0 -> 1
            n == 1 -> x
            rem(n, 2) == 1 -> exp(x, n - 1) * x
            true -> exp(x, div(n, 2)) * exp(x, div(n, 2))
        end
    end

    @doc """
    Computes the product of m times n (m non negative integer)

    Returns the product

    ## Example

            iex> Recursion.prod(5, 5)
            25
            iex> Recursion.prod(5, -5)
            -25
            iex> Recursion.prod(-5, 5)
            Infinite loop
    """
    def prod(m, n) do
        if m == 0 do
            0
        else
            prod(m - 1, n) + n
        end
    end

    def caseProd(m, n) do
        case m do
            0 -> 0
            1 -> n
            _ -> caseProd(m - 1, n) + n
        end
    end

    def condProd(m, n) do
        cond do
            m == 0 -> 0
            m == 1 -> n
            true -> condProd(m - 1, n) + n
        end
    end

    def prodClauses(0, _) do 0 end

    def prodClauses(m, n) do
        prodClauses(m - 1, n) + n
    end






    @doc """
    Takes a list l and an integer n to give the item at position n in
    the list.

    Returns the n'th element of the list l if the n'th element exists

    ## Example

            iex> l = [1,2,3,4]
            iex> Recursion.nth(3, l)
            3
            iex> Recursion.nth(4, l)
            4
            iex> Recursion.nth(5, l)
            "out of bounds"
            iex> Recursion.nth(0, l)
            "out of bounds"

    """
    def nth(_n, []) do
        "out of bounds"
    end
    def nth(n, l) do
        [head | tail] = l
        case n do
            1 -> head
            _ -> nth(n - 1, tail)
        end
    end

    @doc """
    Takes a list l and gives the number of elements in the list

    Returns the length of the list l

    ## Example

            iex> l = [1,2,3,4]
            iex> Recursion.len(l)
            4
    """
    def len(l) do
        case l do
            [] -> 0
            #[_] -> 1
            _ -> [_head | tail] = l
                len(tail) + 1
        end
    end

    @doc """
    Tales a list l of integers and gives the sum of the integers

    Returns the sum of the elements in l

    ## Example

            iex> l = [1,2,3]
            iex> Recursion.sum(l)
            6
    """
    def sum(l) do
        case l do
            [] -> 0
            _ -> [head | tail] = l
                head + sum(tail)
        end
    end

    @doc """
    Takes a list l and duplicates all elements in it

    Returns a new list with duplicate elements of l

    ## Example

            iex> l = [1,2,3]
            iex> Recursion.duplicate(l)
            [1,1,2,2,3,3]
    """
    def duplicate(l) do
        case l do
            [] -> l
            _ ->
                [head | tail] = l
                [head | [head | duplicate(tail)]]
        end
    end

    #wrong version, gives a list of two equal lists
    def dupe(l) do
        [l | [l]]
    end


    @doc """
    Takes an element x and adds it to a list l

    Looks at the elements in the list to determine if x is unique
    if not, state that it is not unique
    If it is unique, append x to the list

    Returns the list l with the added element x

    ## Examples

            iex> l = [1,2,3,4]
            iex> Recursion.add(3, l)
            [1,2,3,4]
            iex> Recursion.add(5, l)
            [1,2,3,4,5]
    """
    def add(x, []) do [x] end
    def add(x, l) do
        [head | tail] = l
        cond do
            x == head -> l
            true -> [head | add(x, tail)]
        end
    end


    @doc """
    Takes and element x and removes each instance of it in the list

    Looks at the elementsi n the list, if it matches x then it gets
    removed.

    Returns the list l without any instance of x

    ## Examples

            iex> l = [1,2,1,3,4,1]
            iex> Recursion.remove(1, l)
            [2,3,4]
            iex> Recursion.remove(3, l)
            [1,2,1,4,1]
    """
    def remove(_x, []) do [] end
    def remove(x, l) do
        [head | tail] = l
        cond do
            head == x -> remove(x, tail)
            true -> [head | remove(x, tail)]
        end
    end

    @doc """
    Takes a list l and takes the unique elements from it

    Returns a list of unique elements

    ## Example

            iex> l = [:a,:b,:a,:d,:a,:b,:b,:a]
            iex> Recursion.unique(l)
            [:a,:b,:d]
    """
    def unique([]) do [] end
    def unique(l) do
        [head | tail] = l
        [head | unique(unique(head, tail))]
    end
    #Functions to remove instanes matching head
    def unique(_x, []) do [] end
    def unique(x, l) do #x is head, l is tail
        [head | tail] = l
        cond do
            head == x -> unique(x, tail)
            true -> [head | unique(x, tail)]
        end
    end


    @doc """
    This function packs equal elements in lists containg equal elements

    Returns a list of lists with equal elements

    ## Example

            iex> l = [:a,:a,:b,:c,:b,:a,:c]
            iex> Recursion.pack(l)
            [[:a,:a,:a], [:b, :b], [:c, :c]]
    """ ##WIP
    def pack(list) do pack(list, []) end
    def pack([], pckd_lst) do pckd_lst end
    def pack([h | t], pckd_lst) do
        pack(remove(h, t), [pack(h, t, []) | pckd_lst])
    end ##Remove function is from a previous exercise
    def pack(x, [], sub_lst) do
        [x | sub_lst]
    end
    def pack(x, [h | t], sub_lst) do
        if x == h do
            pack(x, t, [h | sub_lst])
        else
            pack(x, t, sub_lst)
        end
    end
    ##This must be the messiest code I have done in a long time

    ##Version by teacher ->
    def pck(lst) do pck(lst, []) end
    def pck([], all) do all end
    def pck([h | t], all) do
        pack(t, add_elm(h, all))
    end
    def add_elm(elm, []) do [[elm]] end
    def add_elm(elm, [elm | _t] = sublist | rest) do
        [[elm | sublist] | rest]
    end
    def add_elm(elm, [first | rest]) do
        [first | add_elm(elm, rest)]
    end

    ##Another version by teacher
    def pock([]) do [] end
    def pock([h | t]) do
        packed = pock(t)
        ins(h, packed)
    end
    def ins(h, []) do [[h]] end
    def ins(h, [[h | t] | rest]) do
        [[h, h | t] | rest]
    end
    def ins(h, [first | rest]) do
        [first | ins(h, rest)]
    end



    @doc """
    This function reverses a given list l

    Returns a list where the order of elements is reversed

    ## Example

            iex> l = [1,2,3,4,5]
            iex> Recursion.rev(l)
            [5,4,3,2,1]
    """
    def rev(list) do
        rev([], list)
    end
    defp rev(rev_lst, []) do rev_lst end
    defp rev(rev_lst, [head | tail]) do
        rev([head | rev_lst], tail)
    end
    ##Ended up just being like the one given...


    @doc """
    This function sorts a list of elements by taking them one at a time
    and insert them into an already sorted list. The already sorted list
    will be empty at start and then contain all the elements when done.

    """
    def insert(element, list) do
        if list == [] do
            [element | list]
        else
            [head | tail] = list
            cond do
                element > head -> [head | insert(element, tail)]
                element <= head -> [element | list]
            end
        end
    end
    @doc """
    This function, with the help of insert, sorts a given list of
    integers.

    Returns a sorted list of integers.

    ## Example

            iex> l = [3,2,5,1,4]
            iex> Recursion.isort(l)
            [1,2,3,4,5]
    """
    def isort(list) do isort(list, []) end
    def isort(list, sorted) do
        case list do
            [] -> sorted
            [h | t] -> isort(t, insert(h, sorted))
            _ -> "error"
        end
    end

    @doc """
    This function divides the list into two lists. Then merge sort each
    of those lists two obtain two sorted sub-lists. These sorted sub-lists
    are then merged into one final sorted list.
    The two last lists are marged by picking the smallest of the elements
    from each list. Since each list is sorted, one need only to look at
    the first element of each list to determine which element is
    the smallest.
    """ ##WIP DOESNT WORK
    def msort(l) do
        case l do
            [] ->  []
            _ ->
            {left, right} = msplit(l, [], [])
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

    """
    def qsort([]) do [] end
    def qsort([p | l]) do
        {small, large} = qsplit(p, l, [], [])
        small = qsort(small)
        large = qsort(large)
        append(small, [p | large])
    end
    def qsplit(_, [], small, large) do {small, large} end
    def qsplit(p, [h | t], small, large) do
        if h < p do
            qsplit(p, t, [h | small], large)
        else
            qsplit(p, t, small, [h | large])
        end
    end
    def append(first, last) do
        case first do
            [] -> last
            [h | t] -> [h | append(t, last)]
            _ -> :error
        end
    end





    @doc """
    DISCLAIMER: Not my own reverse functions
    These functions are taken from "5 Reverse" in introduction.pdf
    """
    def nreverse([]) do [] end
    def nreverse([h | t]) do
        r = nreverse(t)
        append(r, [h])
    end

    def reverse(l) do
        reverse(l, [])
    end
    def reverse([], r) do r end
    def reverse([h | t], r) do
        reverse(t, [h | r])
    end
end
