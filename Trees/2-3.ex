defmodule TwoThree do

    @moduledoc """
    Key-value pairs only exist in leaves.

    In a two-node, all keys in the left branch <= the key of the
    node.

    In a three-node:
    * The keys of the left branch <= the left key
    * The keys of the middle branch <= the right key
    """
    @type value() :: atom() | number()
    @type key() :: number()
    @type tree() ::
        :nil |
        {:leaf, key(), value()} |
        {:two, key(), tree(), tree()} |
        {:three, key(), key(), tree(), tree(), tree()} |
        {:four, key(), key(), key(), tree(), tree(), tree(), tree()}

    @doc """
    To insert a key-value pair in an empty tree return a leaf
    containing the key and value.

    To insert a key-value pair in a leaf, return a two-node
    containing the existing leaf and a new leaf. The smaller
    of the two keys should be the key of the two-node.

    To insert a key-value pair in a two-node, create a new leaf
    and return a three-node containing all three leaves in order,
    the three-node holds the two smallest keys in order

    To insert a key-value pair in a three-node, create a new leaf
    and return a four-node containing all four leaves in order,
    the four-node holds the three smallest keys in order
    """
    def insert(:nil, key, value) do
        {:leaf, key, value}
    end
    def insert({:leaf, key, _} = leaf, k, v) do
        if key <= k do
            {:two, key, leaf, {:leaf, k, v}}
        else
            {:two, k, {:leaf, k, v}, leaf}
        end
    end
    def insert({:two, key, {:leaf, kl, _} = l1, {:leaf, _, _} = l2}, k, v) when k <= key do
        if k <= kl do
            {:three, k, kl, {:leaf, k, v}, l1, l2}
        else
            {:three, kl, k, l1, {:leaf, k, v}, l2}
        end
    end
    def insert({:two, key, {:leaf, _, _} = l1, {:leaf, rk, _} = l2}, k, v) do
        if k > rk do
            {:three, key, rk, l1, l2, {:leaf, k, v}}
        else
            {:three, key, k, l1, {:leaf, k, v}, l2}
        end
    end
    def insert({:three, k1, k2, {:leaf, _, _} = l, {:leaf, mk, _} = m, {:leaf, _, _} = r}, k, v) when k <= mk do
        if k <= k1 do
            {:four, k, k1, k2, {:leaf, k, v}, l, m, r}
        else
            {:four, k1, k, k2, l, {:leaf, k, v}, m, r}
        end
    end
    def insert({:three, k1, k2, {:leaf, _, _} = l, {:leaf, _, _} = m, {:leaf, rk, _} = r}, k, v) do
        if k > rk do
            {:four, k1, k2, rk, l, m, r, {:leaf, k, v}}
        else
            {:four, k1, k2, k, l, m, {:leaf, k, v}, r}
        end
    end
    def insert({:two, key, left, right}, k, v) do
        cond do
            k <= key ->
                case insert(left, k, v) do
                    {:four, q1, q2, q3, t1, t2, t3, t4} ->
                        first = {:two, q1, t1, t2}
                        second = {:two, q3, t3, t4}
                        {:three, key, q2, first, second, right}
                    updated ->
                        {:two, key, updated, right}
                end
            true ->
                case insert(right, k, v) do
                    {:four, q1, q2, q3, t1, t2, t3, t4} ->
                        first = {:two, q1, t1, t2}
                        second = {:two, q3, t3, t4}
                        {:three, q1, q2, left, first, second}
                    updated ->
                        {:two, key, left, updated}
                end
            end
    end

    def test() do
        insert({:two, 7,
                    {:three, 2, 5,
                        {:leaf, 2, :foo},
                        {:leaf, 5, :bar},
                        {:leaf, 7, :zot}},
                    {:three, 13, 16,
                        {:leaf, 13, :foo},
                        {:leaf, 16, :bar},
                        {:leaf, 18, :zot}}},
                14, :grk)
    end
end
