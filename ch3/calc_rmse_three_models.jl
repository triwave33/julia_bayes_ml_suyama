using Plots
using Plots.PlotMeasures
using Distributions
using LinearAlgebra
using ProgressBars

# if use ssh connection, comment out
ENV["GKSwstype"]="100"

######### sample point creation #########

# make ground truth
# to check -> https://github.com/triwave33/julia_bayes_ml_suyama/blob/master/ch3/fig_3_10.png
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
  return cat(get_feature.(x_arr, M)..., dims=2)
end

# regression
function pred_poly_reg(λ, x_arr, y_arr, x_grid, M; isPlot, label)
  m = zeros(M)
  Λ = I(M)

  f_arr = get_feature_matrix(x_arr,M)
  Λ̂= λ* f_arr*f_arr' + Λ
  m̂ = inv(Λ̂)*(λ* f_arr * y_arr' +Λ* m)
  f_grid = get_feature_matrix(x_grid,M) # feature
  μ_post = f_grid' * m̂ # y_pred
  return μ_post
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
function pred_NN_reg(x_arr, y_arr, x_grid; isPlot)
  y_pred = get_NN.(Ref(x_arr), Ref(y_arr), x_grid)
  return y_pred
end
######################################


# calculate root mean square error
function calc_rmse(y_pred, y_ans)
  return sqrt(mean((y_pred - y_ans).^2))
end


function main()
  N_train = 1000 # maximum num of sampling points 
  N_test = 20 # sample points for calculate RMSE
  N_train_arr = 1:N_train 
  N_trial = 10 # averaging num for regression results (RMSE)

  # parameter for ground truth
  a = 1.0/40 # coef for quadratic func
  center=2.0 # center point of quadratic func
  λ = 13.0 # noise parameter
  x_min = -10
  x_max = 30
  x_step = 0.01
  
  x_test, y_test = get_sample(N_test, x_min, x_max, a, center)
  
  # initialize
  lin_rmse_arr = zeros(N_train)
  quad_rmse_arr = zeros(N_train)
  nn_rmse_arr = zeros(N_train)
  
  for n in ProgressBar(N_train_arr) # increasing sample points
    lin_tmp = 0 
    quad_tmp = 0
    nn_tmp = 0
    for i in 1:N_trial # average results 
      x_train, y_train = get_sample(n, x_min, x_max, a, center)
    
      # linear
      y_pred = pred_poly_reg(λ, x_train, y_train, x_test, 2;
                                  isPlot=false, label="line")
      lin_tmp += calc_rmse(y_test, y_pred')
      # quad
      y_pred = pred_poly_reg(λ, x_train, y_train, x_test, 3;
                                  isPlot=false, label="quad")
      quad_tmp += calc_rmse(y_test, y_pred')
      # NN
      y_pred  = pred_NN_reg(x_train, y_train, x_test;
                                  isPlot=false)
      nn_tmp += calc_rmse(y_test, y_pred')
    end
    # averaging
    lin_rmse_arr[n] = lin_tmp/N_trial
    quad_rmse_arr[n] = quad_tmp/N_trial
    nn_rmse_arr[n] = nn_tmp/N_trial
  end
    
    
  plot(xlabel="sample_num", ylabel="rmse")
  plot!(log10.(lin_rmse_arr), xaxis=:log,  label="lin")
  plot!(log10.(quad_rmse_arr), xaxis=:log,  label="quad")
  plot!(log10.(nn_rmse_arr), xaxis=:log,  label="nn")
  savefig("rmse.png")
end

println("running main")
main()

