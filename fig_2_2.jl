using Plots
using LaTeXStrings

N = 100
H_array = zeros(N)
for (i,μ) in enumerate(range(0,1, length = N))
  H_array[i] = -1 * μ * log(μ) - (1-μ) * log(1-μ)
end

plot(range(0,1,length=N), H_array, label="", title="fig 2.2")
xlabel!(L"$\mu$")
ylabel!("entropy")
savefig("fig_2_2.png")
