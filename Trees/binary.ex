defmodule Binary do



    #LEAF AND NODE
    def member(_, :nil) do :no end
    def member(key, {:leaf, key}) do :yes end
    def member(_, {:leaf, _}) do :no end

    def member(key, {:node, key, _, _}) do :yes end
    def member(key, {:node, k, left, _}) when key < k do
        member(key, left)
    end
    def member(key, {:node, _, _, right}) do
        member(key, right)
    end



    def insert(key, :nil) do {:leaf, key} end
    def insert(key, {:leaf, k}) when key < k do
        {:node, k, {:leaf, key}, :nil}
    end
    def insert(key, {:leaf, k}) do
        {:node, key, {:leaf, k}, :nil}
    end
    def insert(key, {:node, k, left, right}) when key < k do
        {:node, k, insert(key, left), right}
    end
    def insert(key, {:node, k, left, right}) do
        {:node, k, left, insert(key, right)}
    end



    def delete(key, {:leaf, key}) do :nil end
    def delete(key, {:node, key, :nil, right}) do right end
    def delete(key, {:node, key, left, :nil}) do left end
    def delete(key, {:node, key, left, right}) do
        k = rightmost(left)
        new_left = delete(k, left)
        {:node, k, new_left, right}

    end
    def delete(key, {:node, k, left, right}) when key < k do
        {:node, k, delete(key, left), right}
    end
    def delete(key, {:node, k, left, right}) do
        {:node, k, left, delete(key, right)}
    end

    def rightmost({:leaf, key}) do key end
    def rightmost({:node, key, _, :nil}) do key end
    def rightmost({:node, _, _, right}) do rightmost(right) end







    #ONLY NODE BUT NOW WITH KEY-VALUE PAIR
    def lookup(_, _, :nil) do :no end
    def lookup(key, {:node, key, value, :nil, :nil}) do {:ok, value} end
    def lookup(_, {:node, _, _, :nil, :nil}) do :no end

    def lookup(key, {:node, key, value, _, _}) do {:ok, value} end
    def lookup(key, {:node, k, _, left, _}) when key < k do
        lookup(key, left)
    end
    def lookup(key, {:node, _, _, _, right}) do
        lookup(key, right)
    end



    def add(key, value, :nil) do {:node, key, value, :nil, :nil} end
    def add(key, value, {:node, key, _, left, right}) do
        {:node, key, value, left, right}
    end
    def add(key, value, {:node, k, v, left, right}) when key < v do
        {:node, k, v, add(key, value, left), right}
    end
    def add(key, value, {:node, k, v, left, right}) do
        {:node, k, v, left, add(key, value, right)}
    end


    def remove(key, {:node, key, _, :nil, :nil}) do :nil end
    def remove(key, {:node, key, _,:nil, right}) do right end
    def remove(key, {:node, key, _, left, :nil}) do left end

    def remove(key, {:node, key, v, left, right}) do
        k = rightmost2(left)
        new_left = remove(k, left)
        {:node, k, v, new_left, right}

    end

    def remove(key, {:node, k, v, left, right}) when key < k do
        {:node, k, v, remove(key, left), right}
    end
    def remove(key, {:node, k, v, left, right}) do
        {:node, k, v, left, remove(key, right)}
    end

    def rightmost2({:node, key, _, :nil, :nil}) do key end
    def rightmost2({:node, key, _, :nil}) do key end
    def rightmost2({:node, _, _, _, right}) do rightmost(right) end
end
