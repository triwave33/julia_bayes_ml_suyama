using Plots
using LaTeXStrings
using SpecialFunctions

function Beta(μ, a, b)
  CB = gamma(a+b)/(gamma(a)*gamma(b))
  return CB * μ^(a-1) * (1- μ)^(b-1)
end

function plot_Beta(μ, a, b)
  prob_arr = Beta.(μ, a, b)
  plot!(μ, prob_arr, label="a=$a, b=$b")
end

a_arr = (0.5, 0.6, 1.0, 10.0, 10.0)
b_arr = (0.5, 0.8, 1.0, 40.0, 5.0)
μ = range(0,1, length=100)

for (a,b) in zip(a_arr, b_arr)
  plot_Beta(μ, a, b)
end
  
plot!(title="Fig. 2.7. Beta distribution")
xlabel!(L"\mu")
ylabel!("Probability")
savefig("fig_2_07.png")
