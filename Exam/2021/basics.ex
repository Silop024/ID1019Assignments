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

    def update_reg(register) do

    end

    def get_reg(register) do

    end



    def start() do
        spawn(fn() -> emulator([], 0, [], [], [], [], [], []))
    end

    def emulator(instructions, counter, s0, s1, s2, s3, s4, s5) do
        receive do
            {:halt} ->
                stop()

            {:addi, destination, reg, int} ->
                # Save instruction to be able to go back
                instructions = [{couner, :addi, destination, reg, int} | instructions]

                # Get value
                case reg do
                    0 -> reg_val = s0
                    1 -> reg_val = s1
                    2 -> reg_val = s2
                    3 -> reg_val = s3
                    4 -> reg_val = s4
                    5 -> reg_val = s5
                end

                result = reg_val + int

                case reg do
                    0 -> s0 = result
                    1 -> s1 = result
                    2 -> s2 = result
                    3 -> s3 = result
                    4 -> s4 = result
                    5 -> s5 = result
                end

                emulator(instructions, )




            {:out, reg} ->
                "stuff here"

            {:add, destination, regX, regY} ->
                "stuff here"

            {:beq, regX, regY, offset} ->
                "stuff here"
        end
    end

    """
    @doc """
    def emulator() do
        {0, fn() ->
    end
    """
    

    def emulator([], _, _) do
        "something idk"
    end
    def emulator([next_instruction | rest], counter, registers) do
        case next_instruction do
            {:halt} -> :halted

            {:beq, regX, regY, offset} ->
                if regX == regY do

                end
        end
    end
end
