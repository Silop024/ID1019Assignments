defmodule Basic do

    @doc """

    def add(d, s1, s2) do

    end

    def addi(d, s1, imm) do

    end

    def beq(s1, s2, offset) do

    end

    def out(s1) do

    end

    def halt() do

    end

    """

    def update_reg(register) do

    end

    def get_reg(register) do
        
    end

    def start() do
        spawn(fn() -> emulator(0, [:nil, :nil, :nil, :nil, :nil: :nil]))
    end

    def emulator(counter, registers) do
        receive do
            {:halt} ->
                stop()

            {:addi, destination, reg, int} ->
                i = get_reg(reg)


            {:out, reg} ->
                "stuff here"

            {:add, destination, regX, regY} ->
                "stuff here"

            {:beq, regX, regY, offset} ->
                "stuff here"
        end
    end
end
