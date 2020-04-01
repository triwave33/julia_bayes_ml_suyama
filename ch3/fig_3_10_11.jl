using Plots
using Plots.PlotMeasures
using Distributions
using LinearAlgebra
using ProgressBars

ENV["GKSwstype"]="100"

# global variables
const N_train = 1000 # maximum num of sampling points 
const N_test = 20 # sample points for calculate RMSE
const N_train_arr = 1:N_train 
const N_trial = 10 # averaging num for regression results (RMSE)

const x_min = -10
const x_max = 30
const x_step = 0.01

const a = 1.0/40
const center=2.0
const λ = 13.0
const x_min = -10
const x_max = 30
const x_step = 0.01

######### sample point creation #########

# make ground truth
function truth(x, a, center)
  return (1 + sin(x)) + (a*(x - center)^2)
end
  
# create sample data points
function get_sample(N, x_min, x_max, a, center)
  x_arr = rand(Uniform(x_min, x_max),N)
  y_arr = reshape(truth.(x_arr, a, center), (1,N))
  return x_arr, y_arr
end
########################################


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
  m̂ = inv(Λ̂)*(λ* f_arr * y_arr' +Λ* m)
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
############################################



######## Nearest neighbor regression ##############
# return nearest neighbor against reference points
function get_NN(x_ref_arr, y_ref_arr, x)
  dist = sqrt.((x_ref_arr .- x).^2)
  index = argmin(dist)
  return y_ref_arr[index]
end

# regression
function pred_NN_reg!(x_arr, y_arr, x_grid; isPlot)
  y_pred = get_NN.(Ref(x_arr), Ref(y_arr), x_grid)
  p = :none
  if isPlot == true
    p = plot!(x_grid, y_pred, label="nn")
  end
  return p, y_pred
end
######################################



# plot all regresion results for fig_3_10
function plot_all_regs!(x_grid, y_grid, x_sample, y_sample,  N; isPlot, kwargs...)
  λ = 13.0
  a = 1.0/40
  center = 2

  p = plot()
  p = plot!(x_grid, y_grid, label="truth"; kwargs...)
  p, _ = pred_poly_reg!(λ, x_sample, y_sample, x_grid, 2; isPlot=isPlot, label="line")
  p, _ = pred_poly_reg!(λ, x_sample, y_sample, x_grid, 3; isPlot=isPlot, label="quad")
  p, _  = pred_NN_reg!(x_sample, y_sample, x_grid; isPlot=isPlot)
  p = plot!(legend=:topleft, legendfont= font(5),
            xlim=(-10,30), ylim=(-5,20))
  p = plot!(x_sample, y_sample', seriestype=:scatter, 
            label="data", markerstrokecolor=false, 
            markercolor=:purple, markersize=3)
  p = plot!(annotations=[(-5,18, text("N=$N",8))])

  return p
end

# calculate root mean square error for fig 3.11
function calc_rmse(y_pred, y_ans)
  return sqrt(mean((y_pred - y_ans).^2))
end


###############################################################


function fig_3_10()
  x_grid = x_min:x_step:x_max
  y_grid = truth.(x_grid, a, center)
  
  
  #y_arr = reshape(rand.(Normal.(sin.(x_arr), λ^(-1))), (N, 1))'
  l = @layout [a; b c]
  m = Dict(:left_margin=>40mm, :right_margin=>40mm)
  
  N_arr = [3,10,50]
  PP = []
  for (i,n) in enumerate(N_arr)
    # make sampling data points
    x_sample, y_sample = get_sample(n, x_min, x_max, a, center)
  
    plot
    p = plot(dpi=300)
    if i ==1
      p = plot_all_regs!(x_grid, y_grid, x_sample, y_sample, n; isPlot=true, m...)
    else
      p = plot_all_regs!(x_grid, y_grid, x_sample, y_sample, n; isPlot=true)
    end
    push!(PP, p)
  end
  plot(PP..., dpi=600, layout=l)
  savefig("fig_3_10.png")
end



############# fig_3_11.jl ##############
function fig_3_11()

  lin_rmse_arr = zeros(N_train)
  quad_rmse_arr = zeros(N_train)
  nn_rmse_arr = zeros(N_train)

  x_test, y_test = get_sample(N_test, x_min, x_max, a, center)
  for n in ProgressBar(N_train_arr) # increasing sample points
    lin_tmp = 0 
    quad_tmp = 0
    nn_tmp = 0
    for i in 1:N_trial # average results 
      x_train, y_train = get_sample(n, x_min, x_max, a, center)
    
      # linear
      _, y_pred = pred_poly_reg!(λ, x_train, y_train, x_test, 2;
                                  isPlot=false, label="line")
      lin_tmp += calc_rmse(y_test, y_pred')
      # quad
      _, y_pred = pred_poly_reg!(λ, x_train, y_train, x_test, 3;
                                  isPlot=false, label="quad")
      quad_tmp += calc_rmse(y_test, y_pred')
      # NN
      _, y_pred  = pred_NN_reg!(x_train, y_train, x_test;
                                  isPlot=false)
      nn_tmp += calc_rmse(y_test, y_pred')
    end
    # averaging
    lin_rmse_arr[n] = lin_tmp/N_trial
    quad_rmse_arr[n] = quad_tmp/N_trial
    nn_rmse_arr[n] = nn_tmp/N_trial
  end
    
    
  plot(dpi=300)
  plot!(log10.(lin_rmse_arr), xaxis=:log,  label="lin")
  plot!(log10.(quad_rmse_arr), xaxis=:log,  label="quad")
  plot!(log10.(nn_rmse_arr), xaxis=:log,  label="nn")
  savefig("fig_3_11.png")
end

fig_3_10()
println("running fig_3_11")
fig_3_11()

