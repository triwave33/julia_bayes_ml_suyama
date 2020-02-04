using Random
using Plots

L = 500
n_trial = 4

p_1 = 1/3
p_0 = 1 - p_1

H_array = zeros(L, n_trial)
H_theory = -1 * (p_1 * log(p_1) + p_0 * log(p_0))

for t in 1:n_trial
  global p_1_count = 0
  global p_0_count = 0
  for l in 1:L
    if Random.rand() < p_1
      p_1_count += 1
    else
      p_0_count += 1
    end
    H = -1 * (p_1_count * log(p_1) + p_0_count * log(p_0)) / l
    H_array[l, t] = H
  end
  plot(H_array, label="")
end

plot!(Vector[[H_theory]], linecolor=:black, linestyle=:dash, 
        linetype=:hline, width=1, label="")
xlabel!("sample number")
ylabel!("expectation")
savefig("fig_2_1.png")
