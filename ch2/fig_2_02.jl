using Plots
using LaTeXStrings

N = 100
H_array = zeros(N)
for (i,μ) in enumerate(range(0,1, length = N))
  H_array[i] = -1 * μ * log(μ) - (1-μ) * log(1-μ)
end

plot(range(0,1,length=N), H_array, label="", title="fig 2.2")
xlabel!(L"\mu")

# TODO LaTeXStrings does not work even in the case of only one symbol
#xlabel!(L"$\mu$")


ylabel!("entropy")
savefig("fig_2_02.png")
