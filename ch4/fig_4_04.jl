using Plots
using Distributions
using LinearAlgebra
using LaTeXStrings

function get_ellipse_data(A)
  eigval = eigvals(A)
  eigvec = eigvecs(A)
  conf_scale = 5.991 /200
  len_major_axis = 2 * sqrt(conf_scale*eigval[1])
  len_minor_axis = 2 * sqrt(conf_scale*eigval[2])
  v1x = eigvec[1,1]
  v1y = eigvec[1,2]
  α = atan(v1y/v1x)
  return len_major_axis, len_minor_axis, α
end


function plot_ellipse(len_major, len_minor, α; kwargs...)
  rot = [cos(α) -sin(α);
        sin(α) cos(α)]

  t = 0:0.01:2pi
  x = len_major*cos.(t)
  y = len_minor*sin.(t)
  ellipse_mat = [x y] * rot
  l = plot!(ellipse_mat[:,1], ellipse_mat[:,2],
            legend=:none, xlim=(-2,2), ylim=(-2,2),
            xlabel=L"x_1", ylabel=L"x_2",
            ; kwargs...)
  return l
end

function conditional_Gauss(μ, Λ, 


# true distributions
μ = [0,0]
Λ = [1 0.5; 0.5 1]

# plot true distribution
ax1, ax2, α = get_ellipse_data(inv(Λ))
a = plot_ellipse(μ[1] + ax1, μ[2] + ax2, α)
plot!(annotations=[(-0.6,-2.3, text("Fig.4.1. representation by single Gaussian distribution", 12))])

# sampling from true distribution using Gibbs sampling




savefig("fig_4_04.png")
