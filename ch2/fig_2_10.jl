# 1D Gaussian distribution
using Plots
using LaTeXStrings

function Norm(x, μ, σ)
  return exp(-1*(x - μ)^2/(2*σ^2)) / sqrt(2*π * σ^2)
end

plot() # initialize
function plot_1D_norm(x_arr, μ, σ)
  prob = Norm.(x_arr, μ, σ)
  plot!(x_arr, prob, label="\\mu=$μ, \\sigma=$σ")
end

x_arr = range(-10,10,length=1000)
μ_arr = [0.0, 2.0, -6.0]
σ_arr = [1.0, 2.0, 0.3]

for (μ, σ) in zip(μ_arr, σ_arr)
  plot_1D_norm(x_arr, μ, σ)
end

xlabel!("x")
ylabel!("probability")
title!("Fig 2.10 1D gaussian distribution")

savefig("fig_2_10.png")
