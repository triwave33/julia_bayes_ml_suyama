using Plots
using Plots.PlotMeasures
using LaTeXStrings
using Distributions
using LinearAlgebra

function get_ellipse_data(A)
  eigval = eigvals(A)
  eigvec = eigvecs(A)
  conf_scale = 5.991 /200
  len_major_axis = 2 * sqrt(conf_scale*eigval[1])
  len_minor_axis = 2 * sqrt(conf_scale*eigval[2])
  v1x = eigvec[1,1]
  v1y = eigvec[1,2]
  α = atan(v1y/v1x)
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
            legend=:none, xlim=(-2,2), ylim=(-2,2),
            xlabel=L"x_1", ylabel=L"x_2",
            ; kwargs...)
  return l
end

l = @layout [a; b c]
N = 5

#### case 1 ####
ν= 5.0
W =  Matrix{Float64}(2.0I, 2,2)
samples = rand(InverseWishart(ν, W), N)
a = plot(title=L"\nu=5.0, \textbf{W}=2.0\textbf{I}_2",
        titlefont=10)
for A in samples
  ax1, ax2, α= get_ellipse_data(A)
  a = plot_ellipse(ax1, ax2, α,
      right_margin=40mm, left_margin=40mm)
end
Λ= ν*W
Σ= inv(Λ)  
a = plot_ellipse(Σ[1,1] .*2, Σ[2,2].*2, 0,
    linestyle=:dot, linecolor=:black,
    right_margin=40mm, left_margin=40mm)

#### case 2 ####
ν= 2.0
W =  Matrix{Float64}(5.0I, 2,2)
samples = rand(InverseWishart(ν, W), N)
b = plot(title=L"\nu=2.0, \textbf{W}=5.0\textbf{I}_2",
        titlefont=10)
for A in samples
  ax1, ax2, α= get_ellipse_data(A)
  b = plot_ellipse(ax1, ax2, α)
end
Λ= ν*W
Σ= inv(Λ)  
b = plot_ellipse(Σ[1,1].*2, Σ[2,2].*2, 0,
    linestyle=:dot, linecolor=:black)


#### case 3 ####
ν= 20.0
W =  Matrix{Float64}(0.5I, 2,2)
samples = rand(InverseWishart(ν, W), N)
c = plot(title=L"\nu=20.0, \textbf{W}=0.5\textbf{I}_2",
        titlefont=10)
for A in samples
  ax1, ax2, α= get_ellipse_data(A)
  c = plot_ellipse(ax1, ax2, α)
end
Λ= ν*W
Σ= inv(Λ)  
c = plot_ellipse(Σ[1,1].*2, Σ[2,2].*2, 0,
    linestyle=:dot, linecolor=:black)



plot(a,b,c, layout=l, dpi=300)
savefig("fig_2_13.png")
