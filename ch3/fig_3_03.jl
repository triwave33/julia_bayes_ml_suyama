using Plots
using LaTeXStrings
using SpecialFunctions 
using Distributions

ab_arr = [(0.5, 0.5), (1.0, 1.0), (5.0, 2.5)] # prior beta distribution
μ_arr = 0:0.001:1 # defining X_axis grid
N = 50 # total sampling number
plot_timing = [0,3,10,N]
μ_truth = 0.25


##################### functions ######################

function beta_distribution(μ, a, b)
  CB = gamma(a+b)/(gamma(a)*gamma(b))
  return CB * μ^(a-1) * (1- μ)^(b-1)
end


function Bernoulli_sampler(μ, sample_num)
  return rand(Bernoulli(μ), sample_num)
end


function bayes_inference()
  cnt= 1
  prob_arr = zeros(length(μ_arr), 
             length(ab_arr) * length(plot_timing))
  
  for (i, (a,b)) in enumerate(ab_arr)
    for n in 0:N
      ## plot if plot_timing
      if in(n, plot_timing)
        prob = beta_distribution.(μ_arr, a, b)
        prob_arr[:, cnt] = prob
        #prob_arr = hcat(prob_arr, prob)
        cnt += 1
      end
      
      ## sampling, then update parameter
      sample = Bernoulli_sampler(μ_truth, 1)[1]
      if sample == 0
        b +=1
      else
        a +=1
      end
    end
  end
  return prob_arr
end

###################################################


prob_arr = bayes_inference()
plot(μ_arr, prob_arr, legend=:none,
      title=["N=$t" for j in 1:1, t in plot_timing],
      titleloc=:right, titlefont=font(8),
      ylim=(0,8),
      layout=(length(ab_arr), length(plot_timing)),
      dpi=300
      )

savefig("fig_3_03.png")



