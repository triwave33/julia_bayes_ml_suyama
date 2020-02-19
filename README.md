# julia_bayes_ml_suyama
reproducing figures in "Introduction to Machine Learning by Bayesian Inference" written by Suyama, Atsushi using JuliaLang.

![image](https://user-images.githubusercontent.com/36175603/74348688-6d580500-4df6-11ea-8883-780d44352897.png)

(ISBN 9784061538320)

## Environments

- Julia: 1.3.1

  - "LaTeXStrings"     => v"1.0.3"
  - "Combinatorics"    => v"1.0.0"
  - "Makie"            => v"0.9.5"
  - "IJulia"           => v"1.20.2"
  - "AbstractPlotting" => v"0.9.17"
  - "Plots"            => v"0.28.4"
  - "Colors"           => v"0.9.6"


## Fig 2_1
### 2.1.5 Approximate calculation of expectation by sampling

<img src="https://latex.codecogs.com/gif.latex?\left&space;\langle&space;f(x)&space;\right&space;\rangle_{p(x)}&space;\approx&space;\frac{1}{L}&space;\sum_{l=1}^{L}f(x^{(l)})"/>


![fig_2_1](https://github.com/triwave33/julia_bayes_ml_suyama/blob/master/fig_2_1.png)


________________________________________

## Fig 2_2
### 2.2.1 Bernoulli distribution

<img src="https://latex.codecogs.com/gif.latex?\textup{Bern}&space;(x|\mu)&space;=&space;\mu^x(1-\mu)^{1-x}"/>
 
 #### Entropy of Bernoulli distribution
 
 <img src="https://latex.codecogs.com/gif.latex?H[\textup{Bern}&space;(x|\mu)]&space;=&space;-\mu&space;\textup{ln}&space;\mu&space;-&space;(1-\mu)&space;\textup{ln}&space;(1-\mu)"/>
 
 

![fig_2_2](https://github.com/triwave33/julia_bayes_ml_suyama/blob/master/fig_2_2.png)

________________________________________


## Fig 2_3
### 2.2.2 Binomial distribution

<img src="https://latex.codecogs.com/gif.latex?\mathrm{Bin}(m|M,&space;\mu)&space;=&space;\,{}_M&space;\mathrm{C}_m&space;\mu^m(1-\mu)^{M-m}"/>


![fig_2_3](https://github.com/triwave33/julia_bayes_ml_suyama/blob/master/fig_2_3.png)


#### Julia Tips

layout of divided figures

```JUlia
l = @layout [a; b c]
a = bar(...)
b = bar(...)
c = bar(...)
plot(a,b,c, layout=l)
```

____________________________________________________________


## Fig 2_4
### 2.2.4 Multinomial distribution

<img src="https://latex.codecogs.com/gif.latex?\textup{Mult}(m|\pi,&space;M)&space;=&space;M!\prod_{k=1}^{K}\frac{\pi_k^{m_{k}}}{m_k&space;!}"/>


![fig_2_4](https://github.com/triwave33/julia_bayes_ml_suyama/blob/master/fig_2_4.png)


#### Julia tips

- 3D barplot

Makie.jl provides 3d scatter function as meshscatter.
3d barplot can be obtained from meshscatter like below.

```Julia 
using Makie
using AbstractPlotting

markersize = Vec3f0.(1,1, -vec(mplot))
```
Here, 1x1 tile on scatterring point is extended down to (x,y) plane by typing -1 * z_value (in this case; vec(mplot)). Then, we get "bars"!

- layout

Makie layout is used for displaying three bargraph.
Both an entire region in the figure or a sub-region containing each barplot are called "scene"
We can define the size of resion (see script).

Once scenes are defined. We can overwrite each one by calling plot function like this.

```
meshgrid!(scene1, ...)
```

________________________________________

## Fig 2.6
### 2.2.5 Poison distribution

<a href="https://www.codecogs.com/eqnedit.php?latex=\textup{Poi}(x|\lambda)&space;=&space;\frac{\lambda^{x}}{x&space;!}&space;e^{-\lambda}" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\textup{Poi}(x|\lambda)&space;=&space;\frac{\lambda^{x}}{x&space;!}&space;e^{-\lambda}" title="\textup{Poi}(x|\lambda) = \frac{\lambda^{x}}{x !} e^{-\lambda}" /></a>


![fig_2_6](https://github.com/triwave33/julia_bayes_ml_suyama/blob/master/fig_2_6.png)


__________________________________________

## Fig 2.7
### Beta distribution

#### beta distribution
<a href="https://www.codecogs.com/eqnedit.php?latex=\textup{Beta}(\mu|\a,b)&space;=&space;C_B(a,b)\mu^{(a-1)})(1-\mu)^{(b-1)}" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\textup{Beta}(\mu|\a,b)&space;=&space;C_B(a,b)\mu^{(a-1)})(1-\mu)^{(b-1)}" title="\textup{Beta}(\mu|\a,b) = C_B(a,b)\mu^{(a-1)})(1-\mu)^{(b-1)}" /></a>


 #### gamma function
 <img src="https://latex.codecogs.com/gif.latex?C_B(a,b)&space;=&space;\frac{\Gamma&space;(a&plus;b)}{\Gamma(a)\Gamma(b)}" title="C_B(a,b) = \frac{\Gamma (a+b)}{\Gamma(a)\Gamma(b)}" /></a>


![fig_2_7](https://github.com/triwave33/julia_bayes_ml_suyama/blob/master/fig_2_7.png)


## Fig 2.8
### Dirichlet distribution

#### dirichlet distribution
Formura should be added


![fig_2_8](https://github.com/triwave33/julia_bayes_ml_suyama/blob/master/fig_2_8.png)

#### Julia tips

If you want to omit the color bar in a plot. Use legend=:none option in plot function.

```Julia 
legend=:none
``` 
