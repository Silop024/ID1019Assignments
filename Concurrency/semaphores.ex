defmodule Semaphs do

    def semaphore(0) do
        receive do :release -> semaphore(1) end
    end

    def semaphore(n) do
        receive do
            {:request, from} ->
                send(from, :granted)
                semaphore(n - 1)
            :release -> semaphore(n + 1)
        end
    end

    def request(semaphore) do
        send(semaphore, {:request, self()})
        receive do :granted -> :ok end
    end
    # Somehow write the semaphore thing with only one clause,
    # no bullshit with cases either because thats the same thing!
    def one_semaph(n) do
        "idk"
    end
end
