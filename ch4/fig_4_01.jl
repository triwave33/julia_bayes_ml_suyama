using Plots
using Distributions
using LinearAlgebra
using LaTeXStrings

# Sample creation
# Class 1
N1 = 100
sigma = 0.3
x1 = rand(Uniform(-1.0, 0.2), N1)
noise = rand(Normal(0,sigma), N1)
y1 = -1.5 .* x1 .- 1.5 .+ noise

# Class 2
N2 = 40
sigma = 0.15
x2 = rand(Uniform(-1.0, 0.0), N2)
noise = rand(Normal(0,sigma), N2)
y2 = -0.0 .* x2 .+ 1.0 .+ noise

# Class 3
N3 = 40
sigma = 0.10
x3 = rand(Uniform(0.3, 0.9), N3)
noise = rand(Normal(0,sigma), N3)
y3 = -0.0 .* x3 .+ 0.5 .+ noise

N = N1 + N2 + N3
x = vcat(x1, x2, x3)
y = vcat(y1, y2, y3)
X = hcat(x,y)
plot(x, y, seriestype=:scatter, legend=false, markercolor=:red)



###### Learning for multi-dimension-Gaussian-dist.
# hyper parameter for Gaussian-Wishart distribution
m = [0,0]
β= 1.0
ν = 2.0
W = I(length(m)) 

# updated hyperparameters
β̂ = N + β
m̂ = 1/ β̂ .* (sum(X, dims=1)' + β .* m)
Ŵ_inv = X' * X + β .* (m * m') - β̂ .* (m̂ * m̂') +  inv(W)
ν̂ = N + ν

###### plot function
function get_ellipse_data(A)
  eigval = eigvals(A)
  eigvec = eigvecs(A)
  conf_scale = 5.991 /30 # empirical (no meaning!)
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
            legend=:none, xlim=(-1.5,1.0), ylim=(-2,2),
            xlabel=" ", ylabel=" ", # dummy for margin
            ; kwargs...)
  return l
end


# sampling from Gaussian-Wishart distribution (prior distribution)
Λ = rand(Wishart(ν̂, inv(Ŵ_inv)))
μ = rand(MvNormal(m̂[:,1], inv(β̂ .* Λ)))
# plot sample
ax1,ax2, α = get_ellipse_data(inv(Λ))
b = plot_ellipse(μ[1] + ax1, μ[2] + ax2, α)
plot!(annotations=[(-0.6,-2.3, text("Fig.4.1. representation by single Gaussian distribution", 12))])

savefig("fig_4_01.png")
