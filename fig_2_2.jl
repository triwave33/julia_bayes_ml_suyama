using Plots

N = 100
H_array = zeros(N)
for (i,mu) in enumerate(range(0,1, length = N))
  H_array[i] = -1 * mu * log(mu) - (1-mu) * log(1-mu)
end

plot(range(0,1,length=N), H_array, label="", title="fig 2.2")
xlabel!("mu")
ylabel!("entropy")
#savefig("fig_2_2.png")
