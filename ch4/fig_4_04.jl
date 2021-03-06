using Plots
using Plots.PlotMeasures
using Distributions
using LinearAlgebra
using LaTeXStrings
using InvertedIndices

include("./plot_util.jl")

function get_cond_Gauss(μ, Σ, b_index_arr, x_arr; usePres = true)
  # this function is for ONLY 2D Gaussian
  @assert length(μ) == 2
  @assert all(size(Σ) .== 2)

  μ_a = μ[Not(b_index_arr)]
  μ_b = μ[b_index_arr]

  if usePres
    Λ = inv(Σ)
    Λ_aa, Λ_ab, Λ_ba, Λ_bb = get_compl_mat(Λ, b_index_arr)

    μ_a_over_b = μ_a - inv(Λ_aa) * Λ_ab * (x_arr - μ_b)
    Σ_a_over_b = inv(Λ_aa)
    return μ_a_over_b, Σ_a_over_b
  else
    Σ_aa, Σ_ab, Σ_ba, Σ_bb = get_compl_mat(Σ, b_index_arr)

    tmp = Σ_ab * inv(Σ_bb)

    μ_a_over_b = μ_a + tmp * (x_arr - μ_b)
    Σ_a_over_b = Σ_aa - tmp * Σ_ba

    return μ_a_over_b, Σ_a_over_b
  end
end
  


function Gibbs_sampling(start_point::Array{Float64, 1}, μ::Array{Float64, 1}, Σ::Array{Float64, 2})
  # Gibbs Sampling
  x_old = start_point[1]
  y_old = start_point[2]
  isPlot = true
  N_Gibbs = 30
  xy_arr = zeros(N_Gibbs, 2)
  usePres = false

 
  # plot true distribution
  ax1, ax2, α = get_ellipse_data(Σ)
  a = plot(bottom_margin=10mm)
  a = plot_ellipse(μ, ax1, ax2, α, label=L"p(\bf x)", color=:blue)
  a = plot!([μ[1]], [μ[2]], markershape=:xcross, label=:none, color=:blue)

 
  for i in 1:N_Gibbs
    # fix y, sample x_new
    b_index = 2 # fix y
    μ_cond, Σ_cond = get_cond_Gauss(μ, Σ, [b_index], [y_old]; usePres=usePres)
    x_new = rand(Normal(μ_cond[1], sqrt(Σ_cond[1,1])))
    
    # fix x, sample y_new
    b_index = 1 # fix x
    μ_cond, Σ_cond = get_cond_Gauss(μ, Σ, [b_index], [x_new], usePres=usePres)
    y_new = rand(Normal(μ_cond[1], sqrt(Σ_cond[1,1])))
    if isPlot
      a = rect_plot(a, x_old, y_old, x_new, y_new; rect_line=true)
    end
    xy_arr[i,1] = x_new
    xy_arr[i,2] = y_new
    x_old = x_new
    y_old = y_new
  end
  
  if isPlot
    plot(a)
  end

  # Baysean inference
  # hyper parameter for Gaussian-Wishart distribution
  m = [0,0]
  β= 1.0
  ν = 2.0
  W = I(length(m)) 
  
  # updated hyperparameters
  β̂ = N_Gibbs + β
  m̂ = 1/ β̂ .* (sum(xy_arr, dims=1)' + β .* m)
  Ŵ_inv = xy_arr' * xy_arr + β .* (m * m') - β̂ .* (m̂ * m̂') +  inv(W)
  ν̂ = N_Gibbs + ν

  # plot sample
  for i in 1:1 # one time
    # sampling from Gaussian-Wishart distribution (prior distribution)
    Λ = rand(Wishart(ν̂, inv(Ŵ_inv)))
    μ = rand(MvNormal(m̂[:,1], inv(β̂ .* Λ)))
    ax1,ax2, α = get_ellipse_data(inv(Λ))
    a = plot_ellipse(μ, ax1, ax2, α, label=L"q(\bf x)", color=:red)
    a = plot!([μ[1]], [μ[2]], markershape=:xcross, label=:none, color=:red)
  end

  return a
end


## CASE 1
# true distributions
μ = [0.0,0.0]
Σ = [1 -0.3 ; -0.3 1] .* 0.1 
start_point = [1.5, -1.5]
a = Gibbs_sampling(start_point, μ, Σ)

## CASE 2
# true distributions
μ = [0.0,0.0]
Σ = [1 -0.95 ; -0.95 1] .* 0.1 
start_point = [1.5, -1.5]
b = Gibbs_sampling(start_point, μ, Σ)

l = @layout [a b]
plot!(a, annotations=[(2, -2.5, text("Fig.4.4. Gibbs sampling for 2D Gaussian distribution", 12))])
plot(a,b, layout=l, size=(1000,400))
savefig("fig_4_04.png")



