using Plots
using Distributions
using LinearAlgebra
using Random
using LaTeXStrings

function get_feature(x,M)
  # input: R^1
  # output: R^M 
  arr = zeros(M)
  for i in 1:M
    arr[i] = x^(i-1)
  end
  return arr
end

function get_feature_matrix(x_arr, M)
  return cat(get_feature.(x_arr, M)..., dims=2)
end

# create sample data points
N = 10 # sample num
x_range = (-1,6)
λ = 13.0
Random.seed!(1234567)
x_arr = rand(Uniform(x_range...),N)
y_arr = reshape(rand.(Normal.(sin.(x_arr), λ^(-1))), (N, 1))'


function pred_poly_reg(x_arr, y_arr, M)
  p = plot()
  # plot sampling points
  p = plot!(x_arr,y_arr', seriestype=:scatter, legend=false,
          markercolor=:black, markersize=2)
  
  m = zeros(M)
  Λ = I(M)

  f_arr = get_feature_matrix(x_arr,M)
  Λ̂= λ* f_arr*f_arr' + Λ
  m̂ = inv(Λ̂)*(λ* f_arr * y_arr' +Λ* m)
  x_grid = -1:0.01:7
  f_grid = get_feature_matrix(x_grid,M) # feature
  μ_post = f_grid' * m̂
  λ_post_inv = inv(λ) .+ diag(f_grid' * inv(Λ̂)*  f_grid)
  
  # plot iference results
  p= plot!(x_grid,sin.(x_grid), legend=true,
          label="groung truth", linecolor=:black)
  p= plot!(x_grid, μ_post[:,1],legend=true, linewidth=2)
  p= plot!(x_grid, μ_post[:,1] + sqrt.(λ_post_inv) ,
         legend=false, linecolor=:black, linestyle=:dot)
  p= plot!(x_grid, μ_post[:,1] - sqrt.(λ_post_inv) ,
         legend=false, linecolor=:black, linestyle=:dot)
  p= plot!(xlim=(-1,6),ylim=(-4,4))
  p= plot!(annotations=[(0,3, text("M=$M", 12))])

  likeli = -0.5*(sum(y_arr.^2 .- log(λ) .+ log(2*π)) 
             + m'*Λ*m - log(det(Λ)) 
             - (m̂'*Λ̂*m̂)[1,1] + log(det(Λ̂)))

  return p, likeli
end


M_arr = [1,2,3,4,5,10] 
likeli_arr = zeros(maximum(M_arr))
PP = []
for i in 1:maximum(M_arr)
  p, likeli = pred_poly_reg(x_arr, y_arr, i)
  if i in M_arr
    push!(PP, p)
  end
  likeli_arr[i] = likeli
end
plot(PP...; dpi=300, layout=(length(M_arr))) 
savefig("fig_3_08.png")

plot(1:maximum(M_arr), likeli_arr, xlabel="M", ylabel=L"\textup{ln}p(\mathbf{Y}|\mathbf{X})")
savefig("fig_3_09.png")



