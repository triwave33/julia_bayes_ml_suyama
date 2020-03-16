using Plots
using LinearAlgebra
using Distributions
using Random


M = 4
# for prior distribution about w
m = zeros(M)
Λ= I(M)

# known parameter about noise (Gaussian distribution)
λ= 0.3

mv = MvNormal(m, inv(Λ))

rep_num = 5
# for consistency with fig_3_06
Random.seed!(123)
w_arr = rand(mv, rep_num)
w_adopted = w_arr[:,rep_num]

function third_order_func(x, w_arr)
  feature = [1 x x^2 x^3]
  return dot(feature, w_arr)
end

x_arr = range(-1.0,1.0, length=40)
y_arr = rand.(Normal.(third_order_func.(x_arr, Ref(w_adopted)), λ), 1)
y_arr = [i[1] for i in y_arr] # any other way?
plot(x_arr, y_arr, seriestype=:scatter, legend=false,
     xlabel="x", ylabel="y", ylim=(-3,6))
x_grid = -1.0:0.01:1.0
y_grid = third_order_func.(x_grid, Ref(w_adopted))
plot!(x_grid, y_grid, legend=false)

savefig("fig_3_07.png")


