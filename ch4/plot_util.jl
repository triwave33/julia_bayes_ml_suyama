using Plots

function rect_plot(p, a_x::Float64, a_y::Float64, b_x::Float64, b_y::Float64; rect_line=true)

  c = :green
  α = 0.40
  p = plot!([a_x], [a_y], markercolor=c, linecolor=c, markerstrokecolor=c,
          markersize=4, seriestype=:scatter, legend=:none, alpha=α, label=:none)
  p = plot!([b_x], [b_y], markercolor=c, linecolor=c, markerstrokecolor=c,
          markersize=4, seriestype=:scatter, legend=:none, alpha=α, label=:none)
  if rect_line
    p = plot!([a_x, b_x], [a_y, a_y], color=c, ls=:dash, legend=:none, alpha=α, label=:none)
    p = plot!([b_x, b_x], [a_y, b_y], color=c, ls=:dash, legend=:none, alpha=α, label=:none)
  end
  return p 
end

function get_ellipse_data(A)
  eigval = eigvals(A)
  eigvec = eigvecs(A)
  conf_scale = 5.991 /10
  len_major_axis = 2 * sqrt(conf_scale*eigval[1])
  len_minor_axis = 2 * sqrt(conf_scale*eigval[2])
  v1x = eigvec[1,1]
  v1y = eigvec[1,2]
  α = -atan(v1y/v1x)
  return len_major_axis, len_minor_axis, α
end


function plot_ellipse(μ, len_major, len_minor, α; kwargs...)
  rot = [cos(α) -sin(α);
        sin(α) cos(α)]

  t = 0:0.01:2pi
  x = len_major*cos.(t)
  y = len_minor*sin.(t)
  ellipse_mat = [x y] * rot
  l = plot!(μ[1] .+ ellipse_mat[:,1], μ[2] .+ ellipse_mat[:,2],
            legend=:topright, xlim=(-2,2), ylim=(-2,2),
            xlabel=L"x_1", ylabel=L"x_2",
            ; kwargs...)
  return l
end

function get_compl_mat(mat, index_arr)
  row_size, col_size = size(mat)
  @assert max(index_arr...) <= min(row_size, col_size)

  rest_index_arr = Not(index_arr)

  mat_aa = mat[rest_index_arr, rest_index_arr]
  mat_ab = mat[rest_index_arr, index_arr]
  mat_ba = mat[index_arr, rest_index_arr]
  mat_bb = mat[index_arr, index_arr]
  return mat_aa, mat_ab, mat_ba, mat_bb
end  


