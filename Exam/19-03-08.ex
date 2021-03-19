defmodule Exam do

    @doc """

    PROBLEM 7 A STREAM OF FIBONACCI VALUES

    Implement a function fib/0 that returns an infinite sequence
    of Fibonacci numbers. The sequence should be represented by a
    function that takes no argument and returns a tuple
    {:ok, next, cont} where next is the next Fibonacci number and
    cont is the continuation of the sequence represented as
    function with the same properties.

    Example:

    def test() do
        cont = fib()
        {:ok, f1, cont} = cont.()
        {:ok, f2, cont} = cont.()
        {:ok, f3, cont} = cont.()
        [f1, f2, f3]
    end

    test() should return [1,1,2]

    Then implement a function take/2 that takes a function, with
    the above described behavior, and a number n, and returns
    {:ok, first, cont} where first is a list of the n first
    elements from the sequence nad the cont is the rest of the
    infinite sequence represented as above. The function need not
    be tail recursive

    Example:

    {:ok, _, cont} = take(fib(), 4); take(cont, 5)
    returns
    {:ok, [5,8,13,21,34], ...}
    """
    def fib() do
        fn() -> fib(1,1) end
    end
    def fib(f1, f2) do
        {:ok, f1, fn() -> fib(f2, f1 + f2) end}
    end

    # When I say sequence I mean the infinite stream of fibonacci
    # numbers we get from fib()
    def take(fib, 0) do
        # ok, acc, next
        {:ok, [], fib}
    end
    def take(fib, n) do
        # current is the next fibonacci number in the sequence
        # next_fib is the continuation of the fibonacci sequence

        # So when you call fib.() you get the next fib nr
        # and the rest of the sequence as a function
        {:ok, current, next_fib} = fib.()

        {:ok, acc, next_fib} = take(next_fib, n - 1)

        {:ok, [current | acc], next_fib}
    end

    def test71() do
        cont = fib()
        {:ok, f1, cont} = cont.()
        {:ok, f2, cont} = cont.()
        {:ok, f3, cont} = cont.()
        [f1,f2,f3]

    end

    def test72() do
        {:ok, _, cont} = take(fib(), 4); take(cont, 5)
    end



    @doc """

    PROBLEM 9 PARALLEL PROCESSING


    Assume we have a process that is defined as given below:

    def start(user) do
        {:ok, spawn(fn() -> proc(user) end)}
    end

    def proc(user) do
        receive do
            {:process, task} ->
                done = doit(task)
                send(user, done)
                proc(user)
            :quit ->
                :ok
        end
    end

    Rewrite the code so that we can utilize a parallel hardware.
    Other processes that are using this process should see no
    difference, the only difference should be that it (hopefull)
    runs faster.

    The function doit/1 is determenistic and does not have any side
    effects. It is a heavy computation that will take different
    time depending on the task. Think about the order of messages.

    I would try using semaphores because I find it the easiest
    """

    def start(user) do
        {:ok, spawn(fn -> proc(user) end)} # Start a new process
    end

    def proc(user) do
        receive do # Receive buffer
            {:process, task} -> "hi"
                #done = doit(task)
                #send(user, done)
                #proc(user)
            :quit ->
                :ok
        end
    end


end
