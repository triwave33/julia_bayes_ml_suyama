using Printf
#using Plots
using Makie
using AbstractPlotting

K = 3

function multinomial_distribution(M, π, mk)
  val = factorial(M)
  for i in 1:length(mk)
    val *= π[i]^mk[i] / factorial(mk[i])
  end
  return val
end

function get_bardata(M, π)
  Multi = zeros(M+1, M+1)
  for m1 in 0:M
    for m2 in 0:(M-m1)
      m3 = M - (m1+m2)
      if m3 >= 0
        val  = multinomial_distribution(M, π, [m1,m2,m3])
        Multi[m1+1, m2+1] = val
      end
    end
  end
  return Multi
end


function plot_multinomiral(scene, mplot, scale_factor) 
	markersize = Vec3f0.(1,1, -vec(mplot))
	color=vec(mplot/maximum(mplot)) 
	mplot[mplot .== 0] .= NaN
	
	meshscatter!(scene, x,y,mplot,
	    limits = limits,
	    marker = marker,
	    markersize = markersize,
	    color = color,
	    )
	
	axis = scene[Axis]
	axis[:names][:axisnames] = ("m_1", "m_2", "z")
	tstyle = axis[:names] # or just get the nested attributes and work directly with them
	tstyle[:textsize] = 400
	axis[:ticks][:textsize] = (300,300,300)

	scale!(scene, 1,1,scale_factor)
end

scene = Scene(resolution=(2000,1600))
# makie layout section
margins = map(pixelarea(scene)) do hh
    xmargin = 0.05*hh.widths[1]
    ymargin = 0.05*hh.widths[2]
    Point2f0(xmargin, ymargin)
end
area1 = map(pixelarea(scene)) do hh
    xmargin = margins[][1]
    ymargin = margins[][2]
    height = (hh.widths[2]-2*ymargin)/2
    width = (hh.widths[1]-2*xmargin)
    IRect(xmargin, ymargin+height, width, height)
end
area2 = map(pixelarea(scene)) do hh
    xmargin = margins[][1]
    ymargin = margins[][2]
    height = (hh.widths[2]-2*ymargin)/2
    width = (hh.widths[1]-2*xmargin)/2
    IRect(xmargin, ymargin, width, height)
end
area3 = map(pixelarea(scene)) do hh
    xmargin = margins[][1]
    ymargin = margins[][2]
    height = (hh.widths[2]-2*ymargin)/2
    width = (hh.widths[1]-2*xmargin)/2
    IRect(xmargin+width, ymargin, width, height)
end

# instantiate scene on each layout
scene1 = Scene(scene, area1)
scene2 = Scene(scene, area2)
scene3 = Scene(scene, area3)

## layout 1 ##
M = 5
π= [0.4, 0.3, 0.3]
Multi = get_bardata(M, π)
Multi_plot = zeros(11,11)
Multi_plot[1:M+1, 1:M+1] = Multi
plot_multinomiral(scene1, Multi_plot, 50)

## layout 2 ##
M = 5
π= [0.15, 0.7, 0.15]
Multi = get_bardata(M, π)
Multi_plot = zeros(11,11)
Multi_plot[1:M+1, 1:M+1] = Multi
plot_multinomiral(scene2, Multi_plot, 50)

## layout 3 ##
M = 10
π= [0.15, 0.7, 0.15]
Multi = get_bardata(M, π)
Multi_plot = zeros(11,11)
Multi_plot[1:M+1, 1:M+1] = Multi
plot_multinomiral(scene3, Multi_plot, 50)



scene
Makie.save("fig_2_4..png", scene)
