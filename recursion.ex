defmodule Recursion do

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
    def add(x, []) do
        [x]
    end
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
    def remove(_x, []) do
        []
    end
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
    def unique([]) do
        []
    end
    def unique(l) do
        [head | tail] = l
        [head | unique(unique(head, tail))]
    end
    #Functions to remove instanes matching head
    def unique(_x, []) do
        []
    end
    def unique(x, l) do #x is head, l is tail
        [head | tail] = l
        cond do
            head == x -> unique(x, tail)
            true -> [head | unique(x, tail)]
        end
    end


    @doc """
    Packs equal elements in lists containg equal elements

    Returns a list of lists with equal elements

    ## Example

            iex> l = [:a,:a,:b,:c,:b,:a,:c]
            iex> Recursion.pack(l)
            [[:a,:a,:a], [:b, :b], [:c, :c]]
    """
end
