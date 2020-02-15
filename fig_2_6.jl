using Plots
using Plots.PlotMeasures

X_LIM = 12

x = 0:X_LIM

function Poisson(x, λ)
  return λ^x * exp(-λ) / factorial(x)
end

Poi = Poisson.(x, 0.5)

#### plot ####
l = @layout [a; b c]
color=:darkblue; margin = 40mm
fs = 10 # fontsize

a = bar(x, Poisson.(x,0.5), title="lambda=0.5", label="",
          color=color, xlabel="x", ylabel="probability",
          titlefont=fs, bar_edges=true,
          left_margin=margin, right_margin=margin)
b = bar(x, Poisson.(x,4.0), title="lambda=4.0", label="",
          titlefont=fs, bar_edges= true,
          color=color, xlabel="m", ylabel="probability")

c = bar(x, Poisson.(x, 1.0), title="lambda=0.6", label="",
          titlefont=fs, bar_edges=true,
          color=color, xlabel="m", ylabel="probability")
plot(a,b,c, layout=l)
savefig("fig_2_6.png")


