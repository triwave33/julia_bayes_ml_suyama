using Plots
using LinearAlgebra
using Distributions
using Random

M = 4
m = zeros(M)
Λ= I(M)

mv = MvNormal(m, inv(Λ))

rep_num = 5

Random.seed!(123)
w_arr = rand(mv, rep_num)

function third_order_func(x, w_arr)
  feature = [1 x x^2 x^3]
  return dot(feature, w_arr)
end

x_arr = -1:0.01:1

plot(xlabel="x", ylabel="y", legend=false, ylim=(-3,5))
for i in 1:rep_num
  plot!(x_arr, third_order_func.(x_arr, Ref(w_arr[:,i])))
end

savefig("fig_3_06.png")
