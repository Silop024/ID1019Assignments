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


    @doc """

    PROBLEM 9 HP35 REVISITED

    You should implement a process that behaves like a calculator.
    The process should be able to receive a sequence of messages
    that are either numbers of operations. You only have to
    implement addition but we want the result returned to us when
    we perform an addition.

    Implement the process and then provide a test function that
    shows how the process can be used to add numbers.
    """
    # Spawn is a built in function like we have in java that
    # starts a new process on a thread or something.
    # So this just starts the calculator
    def start() do
        spawn(fn() -> calculator([]) end)
    end

    # Stack is a list
    def calculator(stack) do
        receive do
            # If we get a tuple with "":add" (our operator) and
            # "from" which is the process ID of the process
            # that called the calculator.
            {:add, from} ->
                # Get the first two integers from the stack
                [a, b | stack] = stack

                # Add them together
                result = a + b

                # Send the result back to the process that called
                # the calculator.
                send(from, {:res, result})

                # For some reason put the result on top of stack?
                calculator([result | stack])
            # If we get a tuple with ":int" and an integer then
            # we dont want to do anything with it yet, so we
            # just put it on the stack
            {:int, int} ->
                calculator([int | stack])

        end
    end

    def test9() do
        calc = start()

        # Send function takes first which process we want to call
        # and then what we want to send it.
        # Here we first give a 4 and a 3 to our calculator
        # Then we send a tuple with an :add so it takes our 3 and 4
        # and adds them together to then send it back to us
        send(calc, {:int, 4})
        send(calc, {:int, 3})
        send(calc, {:add, self()})

        receive do
            {:res, result} ->
                result
        end
    end
end
