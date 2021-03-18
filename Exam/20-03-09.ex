defmodule Exam do

    @doc """

    PROBLEM 8 NEXT PRIME NUMBER

    You should implemnet a function primes/0 that returns a
    function that represents the endless sequence of prime numbers.
    The returned function should when applied to no arguments,
    return a tuplpe {:ok, prime, next} where prime is the next
    prime number and next a function that will give us the
    following prime numbers.

    @type next() :: {:ok, integer(), ( -> next())}

    @spec primes() :: ( -> next())

    One way to solve this is to implement sieve or Eratosthenes.
    When you have found a prime number p (the first one is 2)
    then you make sure that you do not return any number n that is
    a multiple of this prime (rem(n,p) == 0).

    Below is a good start of this algorithm:

    def primes() do
        fn() ->
            {:ok, 2, fn() -> sieve(2, fn() -> next(3) end) end} end
    end

    def next(n) do
        {:ok, n, fn() -> next(n + 1) end}
    end

    Now implement sieve/2
    """
    def primes() do
        fn() ->
            {:ok, 2, fn() -> sieve(2, fn() -> next(3) end) end} end
    end

    def next(n) do
        {:ok, n, fn() -> next(n + 1) end}
    end

    def sieve(prime, function) do
        {:ok, current, function} = function.()

        # If rem == 0 then the current number we are looking at
        # is divisible by a prime and thus not a prime itself,
        # so we ignore it
        if rem(current, prime) == 0 do
            sieve(prime, function)
        else
            # Else we take the current number and sieve the rest
            # with our new prime.
            {:ok, current, fn() ->
                sieve(current, fn() -> sieve(prime, function) end)
            end}
        end
    end

end
