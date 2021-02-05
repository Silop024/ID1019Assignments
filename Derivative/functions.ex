defmodule Functions do

    def derivative(n) when is_number(n) do "nothing" end
    def derivative(n) when is_atom(n) do "nothing" end

    @type literal() :: {:num, number()} | {:var, atom()}

    @type expr() :: {:add, expr(), expr()}
                    | {:mul, expr(), expr()}
                    | {:exp, expr(), expr()}
                    | {:ln, expr()}
                    | {:sqrt, expr()}
                    | {:trig, expr()}
                    | literal()

    def test() do
        #e1 = {:add, {:mul, {:num, 2}, {:var, :x}}, {:num, 4}}
        #e2 = {:exp, {:var, :x}, {:num, 3}}
        #e3 = {:ln, {:exp, {:var, :x}, {:num, -1}}}
        e4 = {:sqrt, {:mul, {:var, :x}, {:num, 4}}}
        d = deriv(e4, :x)
        simplify(d)
    end


    def deriv({:num, _}, _) do {:num, 0} end
    def deriv({:var, v}, v) do {:num, 1} end
    def deriv({:var, _}, _) do {:num, 0} end
    def deriv({:mul, e1, e2}, v) do
        {:add,  {:mul, deriv(e1, v), e2},
                {:mul, e1, deriv(e2, v)}}
    end
    def deriv({:add, e1, e2}, v) do
        {:add, deriv(e1, v), deriv(e2, v)}
    end
    def deriv({:exp, e, {:num, n}}, v) do
        {:mul,
            {:mul,
                {:num, n},
                {:exp, e, {:num, n - 1}}},
            deriv(e, v)}
    end
    def deriv({:ln, e}, v) do ##help meeee I dont knooow
        {:exp, e, {:num, -1}}
    end
    def deriv({:sqrt, e}, v) do #Not working help meeee
        {:exp, deriv(e, v), {:mul,
                                {:num, -1},
                                {:mul,
                                    {:num, 2},
                                    {:sqrt, e}}}}
    end


    @doc """
    These functions are used to simplify an expression, removing any
    unnessecary clutter

    Example
        This expression ((0*x + 2*1) + 0)
        {:add,
            {:add,
                {:mul,
                    {:num, 0},
                    {:vad, :x}},
                {:mul,
                    {:num, 2},
                    {:num, 1}}},
            {:num, 0}}
        Turns into (2)
        {:num, 2}
    """

    def simplify({:num, n}) do {:num, n} end
    def simplify({:var, v}) do {:var, v} end
    def simplify({:add, e1, e2}) do
        simplify_add(simplify(e1), simplify(e2))
    end
    def simplify({:mul, e1, e2}) do
        simplify_mul(simplify(e1), simplify(e2))
    end
    def simplify({:exp, e1, e2}) do
        simplify_exp(simplify(e1), simplify(e2))
    end
    def simplify({:sqrt, e}) do
        simplify_sqrt(simplify(e))
    end

    def simplify_add(e1, {:num, 0}) do e1 end
    def simplify_add({:num, 0}, e2) do e2 end
    def simplify_add({:num, n1}, {:num, n2}) do {:num, n1 + n2} end
    def simplify_add(e1, e2) do {:add, e1, e2} end

    def simplify_mul(_, {:num, 0}) do {:num, 0} end
    def simplify_mul({:num, 0}, _) do {:num, 0} end
    def simplify_mul(e1, {:num, 1}) do e1 end
    def simplify_mul({:num, 1}, e2) do e2 end
    def simplify_mul({:num, n1}, {:num, n2}) do {:num, n1 * n2} end
    def simplify_mul(e1, e2) do {:mul, e1, e2} end

    def simplify_exp(_, {:num, 0}) do {:num, 1} end
    def simplify_exp(e1, {:num, 1}) do e1 end
    def simplify_exp({:num, 0}, _) do {:num, 0} end
    def simplify_exp({:num, 1}, _) do {:num, 1} end
    def simplify_exp({:exp, e, {:num, n1}}, {:num, n2}) do
        {:exp, e, {:num, n1 + n2}}
    end
    def simplify_exp(e1, e2) do {:exp, e1, e2} end

    def simplify_sqrt({:num, 0}) do {:num, 0} end
    def simplify_sqrt({:Num, 1}) do {:num, 1} end
    def simplify_sqrt(e) do {:sqrt, e} end

end
