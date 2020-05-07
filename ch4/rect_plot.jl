using Plots

function rect_plot(p, a_x::Float64, a_y::Float64, b_x::Float64, b_y::Float64; rect_line=true)

  c = :green
  a = 0.25
  p = plot!([a_x], [a_y], markercolor=c, linecolor=c, markerstrokecolor=c,
          markersize=4, seriestype=:scatter, legend=:false, alpha=a)
  p = plot!([b_x], [b_y], markercolor=c, linecolor=c, markerstrokecolor=c,
          markersize=4, seriestype=:scatter, legend=:false, alpha=a)
  if rect_line
    p = plot!([a_x, b_x], [a_y, a_y], color=c, ls=:dash, legend=:false, alpha=a)
    p = plot!([b_x, b_x], [a_y, b_y], color=c, ls=:dash, legend=:false, alpha=a)
  end
  return p 
end


