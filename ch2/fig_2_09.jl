# Gamm distribution
using Plots
using LaTeXStrings
using SpecialFunctions

function Gam(λ, a, b)
  CG = b^a / gamma(a)
  return CG * λ^(a-1) * exp(-b * λ)
end


function plot_Gamma(λ_arr, a, b)
  prob = Gam.(λ_arr, a, b)
  plot!(λ_arr, prob, xlabel=L"\lambda", ylabel="probability",
        label="a=$a,b=$b")
end
  
λ_arr = range(0,10, length=100)
a_arr = [1,2,2]
b_arr = [1,2,0.5]

plot()

for (a,b) in zip(a_arr, b_arr)
  plot_Gamma(λ_arr, a, b)
end

title!("Fig 2.9")

savefig("fig_2_09.png")
