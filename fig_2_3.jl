using Plots
using Plots.PlotMeasures
#Plots.scalefontsizes(0.8)

M_arr = [10, 10, 20]
mu_arr = [0.5, 0.2, 0.6]
N = 20
l = @layout [a; b c]
color=:darkblue; margin = 40mm
fs = 10


p_arr = zeros(N+1, length(M_arr))
for (i, (M, mu)) in enumerate(zip(M_arr, mu_arr))
  for m in 0:N
    p_arr[m+1,i] = binomial(M, m)* mu^m * (1-mu)^(M-m)
  end
end

x_scale = range(0, step=1, length=N+1)
a = bar(x_scale, p_arr[:,1], title="M=10, mu=0.5", label="",
          color=color, xlabel="m", ylabel="probability",
          titlefont=fs, bar_edges=true,
          left_margin=margin, right_margin=margin)
b = bar(x_scale, p_arr[:,2], title="M=10, mu=0.2", label="",
          titlefont=fs, bar_edges= true,
          color=color, xlabel="m", ylabel="probability")

c = bar(x_scale, p_arr[:,3], title="M=20, mu=0.6", label="",
          titlefont=fs, bar_edges=true,
          color=color, xlabel="m", ylabel="probability")
plot(a,b,c, layout=l)
savefig("fig_2_3.png")
