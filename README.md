# julia_bayes_ml_suyama
reproducing figures in "Introduction to Machine Learning by Bayesian Inference" written by Suyama, Atsushi using JuliaLang.

![image](https://user-images.githubusercontent.com/36175603/74348688-6d580500-4df6-11ea-8883-780d44352897.png)

(ISBN 9784061538320)

## Fig 2_1
### 2.1.5 Approximate calculation of expectation by sampling

<img src="https://latex.codecogs.com/gif.latex?\left&space;\langle&space;f(x)&space;\right&space;\rangle_{p(x)}&space;\approx&space;\frac{1}{L}&space;\sum_{l=1}^{L}f(x^{(l)})"/>

![fig_2_1](https://user-images.githubusercontent.com/36175603/74021931-e105a680-49df-11ea-8746-c4f9843dba23.png)


________________________________________

## Fig 2_2
### 2.2.1 Bernoulli distribution

<img src="https://latex.codecogs.com/gif.latex?\textup{Bern}&space;(x|\mu)&space;=&space;\mu^x(1-\mu)^{1-x}"/>
 
 #### Entropy of Bernoulli distribution
 
 <img src="https://latex.codecogs.com/gif.latex?H[\textup{Bern}&space;(x|\mu)]&space;=&space;-\mu&space;\textup{ln}&space;\mu&space;-&space;(1-\mu)&space;\textup{ln}&space;(1-\mu)"/>
 
 
![Fig 2_2.png](https://user-images.githubusercontent.com/36175603/74019791-8b2eff80-49db-11ea-9ea1-80810041f79d.png)

________________________________________


## Fig 2_3
### 2.2.2 Binomial distribution

<img src="https://latex.codecogs.com/gif.latex?\mathrm{Bin}(m|M,&space;\mu)&space;=&space;\,{}_M&space;\mathrm{C}_m&space;\mu^m(1-\mu)^{M-m}"/>

![fig_2_3](https://user-images.githubusercontent.com/36175603/74347873-19005580-4df5-11ea-8f00-c3844d29eb10.png)

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

![fig_2_4](https://user-images.githubusercontent.com/36175603/74550301-80a0d700-4f94-11ea-99f3-e7ddf120ada2.png)

#### Julia tips

- 3D barplot

Makie.jl provides 3d scatter function as meshscatter.
3d barplot can be obtained from meshscatter like below.

```Julia 
using Makie
using AbstractPlotting

markersize = Vec3f0.(1,1, -vec(mplot))
```
Here, 1x1 tile is extended to (x,y) plane in z=0 from scattering points (so we get "bars").

- layout

Makie layout is used for displaying three bargraph.
Both an entire region in the figure or a sub-region containing each barplot are called "scene"
We can define the size of resion (see script).

Once scenes are defined. We can overwrite the scene by calling plot function like this.

```
meshgrid!(scene, ...)
```

