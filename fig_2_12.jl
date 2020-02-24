using Plots
using Plots.PlotMeasures
using LinearAlgebra
using LaTeXStrings

# D-dimension Gaussian Distribution

function D_Gauss(xx, μ, Σ)
  D = length(xx)
  return exp(-0.5 * (xx - μ)' * inv(Σ) * (xx - μ)) /  (sqrt((2π)^D)* det(Σ))
end


function D_log_Gauss(xx, μ, Σ)
  D = length(xx)
  return -0.5* ((xx -μ)' * inv(Σ) * (xx -μ) +logdet(Σ) +D*log(2π))
end

N = 200
x1 = -5:0.1:5
x2 = -5:0.1:5
μ= [0; 0]

l = @layout [a; b c]


### case 1 ###
Σ= [3.0 0.0; 0.0 3.0]
Z = exp.([D_log_Gauss([i; j], μ, Σ) for i in x1, j in x2]')

a = plot(x1, x2, Z, st=:surface, camera= (30,60),
    title = L"\mathcal{N}(x|\mu,\Sigma)=\frac{1}{\sqrt{(2\pi)^D\left | \Sigma \right |}}\textup{exp}\left \{ -\frac{1}{2}(x-\mu)^\top \Sigma^{-1}(x-\mu) \right \}",

    ### matrices with LaTeXStrings does not work!!! (bug or my mistake)
    #title=L"\begin{bmatrix}3.0&0.0 \\ 0.0&3.0 \\ \end{bmatrix}",

    left_margin=40mm, right_margin=40mm,
    xlabel=L"x_2", ylabel=L"x_1", zlabel="probability density",
    legend=:none)

### case 2 ###
Σ= [2.0 -sqrt(3); -sqrt(3) 4.0 ]
Z = exp.([D_log_Gauss([i; j], μ, Σ) for i in x1, j in x2]')

b = plot(x1, x2, Z, st=:surface, camera= (30,60),
    legend=:none)

### case 1 ###
Σ= [4.0 sqrt(3); sqrt(3) 2.0]
Z = exp.([D_log_Gauss([i; j], μ, Σ) for i in x1, j in x2]')

c = plot(x1, x2, Z, st=:surface, camera= (30,60),
    legend=:none)

plot(a,b,c, layout=l, size=(600,600))
savefig("fig_2_12.png")

