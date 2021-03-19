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
    def print_instruction({type, reg1, reg2, regorint}) do
        IO.puts type <> reg1 <> reg2 <> regorint
    end
    def print_instruction({type, reg}) do
        IO.puts type <> reg
    end
    def print_instruction(_) do
        IO.puts("idk")
    end

    def print_registers({s0, s1, s2, s3, s4, s5}) do
        IO.puts s0 <> s1 <> s2 <> s3 <> s4 <> s5
    end

    def print_thing(x) do
        IO.puts("hmm #{x}")
    end


    # This or instructions as [next | rest] with tuples?
    def emulator(instructions, counter, registers) do
        #print_instruction(elem(instructions, counter))
        #print_registers(registers)
        instruction = elem(instructions, counter)
        IO.puts("counter: #{counter}")

        case instruction do
            {:halt} -> :halted

            {:beq, regX, regY, offset} ->
                x = elem(registers, regX)
                y = elem(registers, regY)

                if x == y do
                    counter = counter + offset
                    emulator(elem(instructions, counter), counter, registers)
                else
                    counter = counter + 1
                    emulator(elem(instructions, counter), counter, registers)
                end

            {:addi, destination, regX, imm} ->
                x = elem(registers, regX)

                result = x + imm
                IO.puts("res: #{result}")
                registers = put_elem(registers, destination, result)

                counter = counter + 1
                emulator(elem(instructions, counter), counter, registers)

            {:add, destination, regX, regY} ->
                x = elem(registers, regX)
                y = elem(registers, regY)

                result = x + y
                registers = put_elem(registers, destination, result)

                counter = counter + 1
                emulator(elem(instructions, counter), counter, registers)

            {:out, regX} ->
                x = elem(registers, regX)
                print_thing(x)

                counter = counter + 1
                emulator(elem(instructions, counter), counter, registers)

            something -> IO.puts("wtf")
                        something
        end
    end

    def test() do
        instructions = {
                        {:addi, 1, 0, 10},
                        {:addi, 3, 0, 1},
                        {:out, 3},
                        {:addi, 1, 1, -1},
                        {:add, 3, 2, 3},
                        {:out, 3},
                        {:beq, 1, 0, 3},
                        {:addi, 2, 4, 0},
                        {:beq, 0, 0, -6},
                        {:halt}
        }
        emulator(instructions, 0, {0, 0, 0, 0, 0, 0})
    end

    def test1() do
        instructions = {{:addi, 1, 0, 10}, {:out, 1}, {:halt}}
        emulator(instructions, 0, {0, 0, 0, 0, 0, 0})
    end
end
