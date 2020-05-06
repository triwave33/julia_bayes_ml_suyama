using Plots
using Distributions
using LinearAlgebra
using LaTeXStrings
using InvertedIndices

include("./rect_plot.jl")

function get_ellipse_data(A)
  eigval = eigvals(A)
  eigvec = eigvecs(A)
  conf_scale = 5.991 /10
  len_major_axis = 2 * sqrt(conf_scale*eigval[1])
  len_minor_axis = 2 * sqrt(conf_scale*eigval[2])
  v1x = eigvec[1,1]
  v1y = eigvec[1,2]
  α = -atan(v1y/v1x)
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
            legend=:false, xlim=(-2,2), ylim=(-2,2),
            xlabel=L"x", ylabel=L"y",
            ; kwargs...)
  return l
end

function get_compl_mat(mat, index_arr)
  row_size, col_size = size(mat)
  @assert max(index_arr...) <= min(row_size, col_size)

  rest_index_arr = Not(index_arr)

  mat_aa = mat[rest_index_arr, rest_index_arr]
  mat_ab = mat[rest_index_arr, index_arr]
  mat_ba = mat[index_arr, rest_index_arr]
  mat_bb = mat[index_arr, index_arr]
  return mat_aa, mat_ab, mat_ba, mat_bb
end  

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
  


function Gibbs_sampling()
  # Gibbs Sampling
  start_point = rand(Uniform(-10,10), 2)
  x_old = start_point[1]
  y_old = start_point[2]
  isPlot = true
  N_Gibbs = 100
  xy_arr = zeros(N_Gibbs, 2)
  usePres = false

  print("start_point")
  print(start_point)

  # true distributions
  μ = [0,0]
  #Σ = [1 0.5; 0.5 1]
  Σ = [1 -0.9 ; -0.9 1] .* 0.3 
  #Σ = [3 3.4 ; 3.4 3]
  
  # plot true distribution
  ax1, ax2, α = get_ellipse_data(Σ)
  a = plot()
  a = plot_ellipse(μ[1] + ax1, μ[2] + ax2, α)

 
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
  for i in 1:3
    # sampling from Gaussian-Wishart distribution (prior distribution)
    Λ = rand(Wishart(ν̂, inv(Ŵ_inv)))
    μ = rand(MvNormal(m̂[:,1], inv(β̂ .* Λ)))
    ax1,ax2, α = get_ellipse_data(inv(Λ))
    a = plot_ellipse(μ[1] + ax1, μ[2] + ax2, α, label="q(x,y)")
    plot!(a, annotations=[(-0.6,-2.3, text("Fig.4.1. representation by single Gaussian distribution", 12))])
  end


  savefig("fig_4_04.png")
  
end

Gibbs_sampling()





