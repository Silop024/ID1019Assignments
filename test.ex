defmodule Test do

    def double(n) do
        n + n
    end

    def toCelsius(f)do
        (f - 32) / 1.8
    end

    def rectArea(x, y) do
        x * y
    end

    def sqrArea(square) do
        {x, y} = square
        rectArea(x, y)
    end

    def circArea(r) do
        r * r * Math.pi
    end
