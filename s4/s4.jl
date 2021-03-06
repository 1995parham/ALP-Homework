using JuMP
using GLPK
using GLPKMathProgInterface

m = Model()
@variable(m, x[1:3] >= 0)
@constraint(m, [i=1:3], x[i] <= 0.5)
@constraint(m, [i=1:3], x[i] >= 0.2)
@constraint(m, sum(x[i] for i=1:3) <= 1)
@constraint(m, x[1] * 19.5 + x[2] * 27.35 + x[3] * 1.75 == 15)
@objective(m, Max, x[1] * 10.9 + x[2] * 16.9 + x[3] * 7.4)
println(m)

@time optimize!(m, with_optimizer(GLPK.Optimizer))

println("Objective value: ", objective_value(m))
X = value.(x)
println("X: ", X)
