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
    def reverse(lst) do reverse(lst, []) end
    def reverse([], acc) do acc end
    def reverse([h | t], acc) do
        reverse(t, [h | acc])
    end

    def emulator(instructions, counter, registers, output) do
        instruction = Kernel.elem(instructions, counter)

        case instruction do
            {:halt} -> {:halted, reverse(output)}

            {:beq, regX, regY, offset} ->
                x = Kernel.elem(registers, regX)
                y = Kernel.elem(registers, regY)

                if x == y do
                    counter = counter + offset
                    emulator(instructions, counter, registers, output)
                else
                    counter = counter + 1
                    emulator(instructions, counter, registers, output)
                end

            {:addi, destination, regX, imm} ->
                x = Kernel.elem(registers, regX)

                result = x + imm


                registers = Kernel.put_elem(registers, destination, result)

                counter = counter + 1
                emulator(instructions, counter, registers, output)

            {:add, destination, regX, regY} ->
                x = Kernel.elem(registers, regX)
                y = Kernel.elem(registers, regY)

                result = x + y
                registers = Kernel.put_elem(registers, destination, result)

                counter = counter + 1
                emulator(instructions, counter, registers, output)

            {:out, regX} ->
                x = Kernel.elem(registers, regX)


                counter = counter + 1
                emulator(instructions, counter, registers, [x | output])

        end
    end

    def test() do
        instructions = {
                        {:addi, 1, 0, 10},  #0
                        {:addi, 3, 0, 1},   #1
                        {:out, 3},          #2
                        {:addi, 1, 1, -1},  #3
                        {:addi, 4, 3, 0},   #4
                        {:add, 3, 2, 3},    #5
                        {:out, 3},          #6
                        {:beq, 1, 0, 3},    #7
                        {:addi, 2, 4, 0},   #8
                        {:beq, 0, 0, -6},   #9
                        {:halt}             #10
        }
        emulator(instructions, 0, {0, 0, 0, 0, 0, 0}, [])
    end

    def test1() do
        instructions = {{:addi, 1, 0, 10}, {:out, 1}, {:addi, 2, 0, 5},
                        {:out, 2}, {:add, 3, 1, 2}, {:out, 3}, {:beq, 4,4,3}, {:halt}, {:out, 1}, {:addi, 4, 4, -1}, {:out, 4}, {:halt}
                    }
        emulator(instructions, 0, {0, 0, 0, 0, 0, 0}, [])
    end
end
