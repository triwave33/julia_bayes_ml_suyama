# KL divergence
using Plots
using Plots.PlotMeasures

function KL(μ,σ,μ̂,σ̂)
  (((μ - μ̂)^2 + σ̂^2)/σ^2 + log(σ^2 / σ̂^2) -1)/2
end


function Norm(x, μ, σ)
  return exp(-1*(x - μ)^2/(2*σ^2)) / sqrt(2*π * σ^2)
end

function plot_1D_norm(x_arr, μ, σ, is_hat; kwargs...)
  prob = Norm.(x_arr, μ, σ)
  if is_hat
    label= "\$ \\hat{\\mu}=$μ, \\hat{\\sigma}=$σ\$";
  else
    label= "\$ \\mu=$μ, \\sigma=$σ\$";
  end
  l = plot!(x_arr, prob, label=label; kwargs...)
  
  return l
end


μ_arr = [0.0, 0.0, 0.0]
μ̂_arr = [0.5, 0.0, 2.0]
σ_arr = [1.0, 2.0, 2.0]
σ̂_arr = [1.0, 1.0, 1.0]

l = @layout [a; b c]
m = Dict(:left_margin=>40mm, :right_margin=>40mm) # Margin
fs = Dict(:legendfont=> 5, :legend=>:topright, :ylims=>(0,0.7)) # Figure Style
as = Dict(:xlabel=>"x", :ylabel=>"probability", :fontfamily=>font(60,"Courier")) # Axis Style

N= 200
x_arr = range(-8,8, length=N)



### this does not work! Because we cannot rewrite each layout variable (a,b,c) in for-loop.

#for (i,p) in zip(1:(length(μ_arr)), [a,b,c])
#  prob = Norm.(x_arr, 0, 1)
#  p = plot()
#  p = plot_1D_norm(x_arr, μ_arr[i], σ_arr[i], false, a;  fs...)
#  p = plot_1D_norm(x_arr, μ_arr[i], σ_arr[i], true, a;  fs...)
#  kl1 = KL(μ_arr[i], σ_arr[i],μ̂_arr[i], σ̂_arr[i])
#  kl2 = KL(μ̂_arr[i], σ̂_arr[i],μ_arr[i], σ_arr[i])
#end
#plot(a,b,c, layout=l, dpi=300)


########## make figure ########### 

#case 1
x_arr = range(-8,8, length=N)
cn = 1 # Case Number
a = plot()
a = plot_1D_norm(x_arr, μ_arr[cn], σ_arr[cn],
    false; m...,  fs..., as...)
a = plot_1D_norm(x_arr, μ̂_arr[cn], σ̂_arr[cn],
    true;  fs...)
kl1 = KL(μ_arr[cn], σ_arr[cn],μ̂_arr[cn], σ̂_arr[cn])
kl2 = KL(μ̂_arr[cn], σ̂_arr[cn],μ_arr[cn], σ_arr[cn])
a = plot!(; annotations=[(-4.0, 0.67, text("KL(q||p)=$kl1", 6))])
a = plot!(; annotations=[(-4.0, 0.62, text("KL(q||p)=$kl2", 6))])



#case 2
cn = 2 # Case Number
b = plot()
b = plot_1D_norm(x_arr, μ_arr[cn], σ_arr[cn],
    false; fs...)
b = plot_1D_norm(x_arr, μ̂_arr[cn], σ̂_arr[cn],
    true;  fs...)
kl1 = KL(μ_arr[cn], σ_arr[cn],μ̂_arr[cn], σ̂_arr[cn])
kl2 = KL(μ̂_arr[cn], σ̂_arr[cn],μ_arr[cn], σ_arr[cn])
b = plot!(; annotations=[(-4.0, 0.67, text("KL(q||p)=$kl1", 6))])
b = plot!(; annotations=[(-4.0, 0.62, text("KL(q||p)=$kl2", 6))])


#case 3
cn = 3 # Case Number
c = plot()
c = plot_1D_norm(x_arr, μ_arr[cn], σ_arr[cn],
    false; fs...)
c = plot_1D_norm(x_arr, μ̂_arr[cn], σ̂_arr[cn],
    true;  fs...)
kl1 = KL(μ_arr[cn], σ_arr[cn],μ̂_arr[cn], σ̂_arr[cn])
kl2 = KL(μ̂_arr[cn], σ̂_arr[cn],μ_arr[cn], σ_arr[cn])
c = plot!(; annotations=[(-4.0, 0.67, text("KL(q||p)=$kl1", 6))])
c = plot!(; annotations=[(-4.0, 0.62, text("KL(q||p)=$kl2", 6))])


plot(a,b,c, layout=l, dpi=300)
savefig("fig_2_11.png")
