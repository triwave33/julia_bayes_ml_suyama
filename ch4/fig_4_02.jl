using Plots
using Distributions
using LinearAlgebra

## global constants
#sampling parameter
const N = 25
const x_low = -2.0
const x_high = 2.0
#

# quad1
const a1 = 5
const b1 = -0.6
const c1 = -0.5

# quad2
const a2 = -5
const b2 = -0.8
const c2 = -0.5

# function 
quad(xx, a, b, c) = a * (xx - b) ^2 + c

plot(ylim=(-30,30))
x1_sample = rand(Uniform(x_low, x_high), N)
y1_sample = quad.(x1_sample, Ref(a1), Ref(b1), Ref(c1))
x2_sample = rand(Uniform(x_low, x_high), N)
y2_sample = quad.(x2_sample, Ref(a2), Ref(b2), Ref(c2))
x_sample = vcat(x1_sample, x2_sample)
y_sample = vcat(y1_sample, y2_sample)
plot!(x_sample, y_sample, seriestype=:scatter, markercolor=:black)


####### Polynominal regression  #######
# get M-dimension polynominal vector from single input
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
  return hcat(get_feature.(x_arr, M)...)
end

# regression
function pred_poly_reg!(λ, x_arr, y_arr, x_grid, M; isPlot, label)
  
  m = zeros(M)
  Λ = I(M)

  f_arr = get_feature_matrix(x_arr,M)
  Λ̂= λ* f_arr*f_arr' + Λ
  m̂ = inv(Λ̂)*(λ* f_arr * y_arr +Λ* m)
  f_grid = get_feature_matrix(x_grid,M) # feature
  μ_post = f_grid' * m̂ # y_pred
  λ_post_inv = inv(λ) .+ diag(f_grid' * inv(Λ̂)*  f_grid)
  p = :none
  if isPlot == true
    # plot iference results
    p= plot!(x_grid, μ_post[:,1],legend=true, linewidth=1, label=label)
  end
  return p, μ_post
end
#


# Linear regresion
λ = 0.3
x_grid = x_low:0.01:x_high
M_arr = [4,30]

for m in M_arr
  p, μ_post = pred_poly_reg!(λ, x_sample, y_sample, x_grid, m, isPlot=true, label="M=$m")
end

savefig("fig_4_02.png")
