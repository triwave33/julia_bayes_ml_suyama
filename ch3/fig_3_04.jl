using Plots
using LaTeXStrings
using SpecialFunctions

# Student's t distribution
function St(x, μ, λ, ν)
  gamma((ν+1)/2)/gamma(ν/2) \
      *(λ/(π*ν))^0.5 *(1+ λ/ν *(x-μ)^2)^(-(ν+1)/2)
end


# plot Student's t distribution
  
params = [(0, 1.0, 1.0),    # μ, λ, ν
          (0, 1.0, 4.0),
          (0, 4.0, 1.0)]

function plot_St(x_arr, μ, λ, ν)
  prob = St.(x_arr, μ, λ, ν)
  #plot!(x_arr, prob, label=L"\mu_s=$μ, \lambda_s=$λ, \nu_s=$ν",
  plot!(x_arr, prob, label="\$\\mu_s=$μ, \\lambda_s=$λ, \\nu_s=$ν\$",
        )
  return prob
end

# main
x_arr = -4:0.01:4
plot(legend=:topright, xlabel="x", ylabel="probability density")
for (μ, λ, ν) in params
  plot_St(x_arr, μ, λ, ν)
end


savefig("fig_3_04.png")
