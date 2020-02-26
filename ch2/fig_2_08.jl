# Dirichlet distribution
using Plots
using Plots.PlotMeasures
using LaTeXStrings
using SpecialFunctions


function Dir(π_arr, α_arr)
  CD = gamma(sum(α_arr))/prod(gamma.(α_arr))
  return CD * prod(π_arr .^ (α.- 1))
end

function get_surfacedata(α_arr, N)
  surf = zeros(N, N)
  π1_grid = range(0,1,length=N)
  π2_grid = range(0,1,length=N)
  for (i,π1) in enumerate(π1_grid)
    for (j,π2) in enumerate(π2_grid)
      π3 = 1 - (π1 + π2)
      if π3 >= 0
        val = Dir([π1,π2,π3], α_arr)
        surf[i,j] = val
      end
    end
  end
  return surf
end

l = @layout [a; b c]
fs =8
margin = 40mm

N=100
### case 1 ###
α = [10.0,10.0,10.0]
surfdata = get_surfacedata(α, N)
surfdata[surfdata .==0] .= NaN
a = plot(range(0,1,length=N), range(0,1,length=N), surfdata,
    xlabel=L"\pi_1",ylabel=L"\pi_2",
    title=L"\alpha = [10.0, 10.0, 10.0]",
    titlefont=fs, legend=:none, 
    left_margin= margin, right_margin= margin,
    st=:surface, camera=(30,60))
  
### case 2 ###
α = [0.5, 0.5, 0.5]
surfdata = get_surfacedata(α, N)
surfdata[surfdata .==0] .= NaN
b = plot(range(0,1,length=N), range(0,1,length=N), surfdata,
    title=L"\alpha = [0.5, 0.5, 0.5]",
    titlefont=fs, legend=:none,
    st=:surface, camera=(30,60))
  
### case 3 ###
α = [1.0, 1.0, 1.0]
surfdata = get_surfacedata(α, N)
surfdata[surfdata .==0] .= NaN
c = plot(range(0,1,length=N), range(0,1,length=N), surfdata,
    title=L"'alpha = [1.0, 1.0, 1.0]",
    titlefont=fs, legend=:none,
    st=:surface, camera=(30,60))
  
plot(a,b,c, layout=l, dpi=300)
savefig("fig_2_08.png")
