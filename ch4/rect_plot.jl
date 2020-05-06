using Plots

function rect_plot(p, a_x::Float64, a_y::Float64, b_x::Float64, b_y::Float64; rect_line=true)

  c = :green
  p = plot!([a_x], [a_y], markercolor=c, linecolor=c, markerstrokecolor=c,
          markersize=4, seriestype=:scatter, legend=:false)
  p = plot!([b_x], [b_y], markercolor=c, linecolor=c, markerstrokecolor=c,
          markersize=4, seriestype=:scatter, legend=:false)
  if rect_line
    p = plot!([a_x, b_x], [a_y, a_y], color=c, ls=:dash, legend=:false)
    p = plot!([b_x, b_x], [a_y, b_y], color=c, ls=:dash, legend=:false)
  end
  return p 
end


