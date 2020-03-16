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


![fig_2_1](https://github.com/triwave33/julia_bayes_ml_suyama/blob/master/ch2/fig_2_01.png)

________________________________________

## Fig 2_2
### 2.2.1 Bernoulli distribution

<img src="https://latex.codecogs.com/gif.latex?\textup{Bern}&space;(x|\mu)&space;=&space;\mu^x(1-\mu)^{1-x}"/>
 
 #### Entropy of Bernoulli distribution
 
 <img src="https://latex.codecogs.com/gif.latex?H[\textup{Bern}&space;(x|\mu)]&space;=&space;-\mu&space;\textup{ln}&space;\mu&space;-&space;(1-\mu)&space;\textup{ln}&space;(1-\mu)"/>
 
 

![fig_2_2](https://github.com/triwave33/julia_bayes_ml_suyama/blob/master/ch2/fig_2_02.png)

________________________________________


## Fig 2_3
### 2.2.2 Binomial distribution

<img src="https://latex.codecogs.com/gif.latex?\mathrm{Bin}(m|M,&space;\mu)&space;=&space;\,{}_M&space;\mathrm{C}_m&space;\mu^m(1-\mu)^{M-m}"/>


![fig_2_3](https://github.com/triwave33/julia_bayes_ml_suyama/blob/master/ch2/fig_2_03.png)


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


![fig_2_4](https://github.com/triwave33/julia_bayes_ml_suyama/blob/master/ch2/fig_2_04.png)


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


![fig_2_6](https://github.com/triwave33/julia_bayes_ml_suyama/blob/master/ch2/fig_2_06.png)


__________________________________________

## Fig 2.7
### Beta distribution

#### beta distribution
<a href="https://www.codecogs.com/eqnedit.php?latex=\textup{Beta}(\mu|\a,b)&space;=&space;C_B(a,b)\mu^{(a-1)})(1-\mu)^{(b-1)}" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\textup{Beta}(\mu|\a,b)&space;=&space;C_B(a,b)\mu^{(a-1)})(1-\mu)^{(b-1)}" title="\textup{Beta}(\mu|\a,b) = C_B(a,b)\mu^{(a-1)})(1-\mu)^{(b-1)}" /></a>


 #### gamma function
 <img src="https://latex.codecogs.com/gif.latex?C_B(a,b)&space;=&space;\frac{\Gamma&space;(a&plus;b)}{\Gamma(a)\Gamma(b)}" title="C_B(a,b) = \frac{\Gamma (a+b)}{\Gamma(a)\Gamma(b)}" /></a>


![fig_2_7](https://github.com/triwave33/julia_bayes_ml_suyama/blob/master/ch2/fig_2_07.png)


## Fig 2.8
### 2.3.2 Dirichlet distribution

#### dirichlet distribution

<a href="https://www.codecogs.com/eqnedit.php?latex=\textup{Dir}(\pi|\alpha)=&space;C_D(\alpha)\prod_{k=1}^{K}\pi_k^{\alpha_k-1}" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\textup{Dir}(\pi|\alpha)=&space;C_D(\alpha)\prod_{k=1}^{K}\pi_k^{\alpha_k-1}" title="\textup{Dir}(\pi|\alpha)= C_D(\alpha)\prod_{k=1}^{K}\pi_k^{\alpha_k-1}" /></a>

where

<a href="https://www.codecogs.com/eqnedit.php?latex=C_D(\alpha)=\frac{\Gamma&space;(\sum_{k=1}^{K}\alpha_k&space;)}{\prod_{k=1}^{K}\Gamma(\alpha_k)}" target="_blank"><img src="https://latex.codecogs.com/gif.latex?C_D(\alpha)=\frac{\Gamma&space;(\sum_{k=1}^{K}\alpha_k&space;)}{\prod_{k=1}^{K}\Gamma(\alpha_k)}" title="C_D(\alpha)=\frac{\Gamma (\sum_{k=1}^{K}\alpha_k )}{\prod_{k=1}^{K}\Gamma(\alpha_k)}" /></a>


<a href="https://www.codecogs.com/eqnedit.php?latex=\Gamma(\cdot&space;)" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\Gamma(\cdot&space;)" title="\Gamma(\cdot )" /></a>
is Gamma function.

![fig_2_8](https://github.com/triwave33/julia_bayes_ml_suyama/blob/master/ch2/fig_2_08.png)


#### Julia tips

If you want to omit the color bar in a plot. Use legend=:none option in plot function.

```Julia 
legend=:none
``` 

## Fig 2.9
### 2.3.3 Gamma distribution

#### gamma distribution

<a href="https://www.codecogs.com/eqnedit.php?latex=\textup{Gam}(\lambda|a,b)=C_G(a,b)\lambda^{a-1}e^{-b\lambda}" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\textup{Gam}(\lambda|a,b)=C_G(a,b)\lambda^{a-1}e^{-b\lambda}" title="\textup{Gam}(\lambda|a,b)=C_G(a,b)\lambda^{a-1}e^{-b\lambda}" /></a>

where

<a href="https://www.codecogs.com/eqnedit.php?latex=C_G(a,b)=\frac{b^a}{\Gamma(a)}" target="_blank"><img src="https://latex.codecogs.com/gif.latex?C_G(a,b)=\frac{b^a}{\Gamma(a)}" title="C_G(a,b)=\frac{b^a}{\Gamma(a)}" /></a>

![fig_2_9](https://github.com/triwave33/julia_bayes_ml_suyama/blob/master/ch2/fig_2_09.png)

## Fig 2.10
### 2.3.4 One-dimensional Gaussian distribution

#### 1D Gaussian distribution

<a href="https://www.codecogs.com/eqnedit.php?latex=\mathcal{N}(x|\mu,\sigma^2)&space;=&space;\frac{1}{\sqrt{2\pi\sigma^2}}\textup{exp}\left&space;\{&space;-\frac{(x-\mu)^2}{2\sigma^2}&space;\right&space;\}" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\mathcal{N}(x|\mu,\sigma^2)&space;=&space;\frac{1}{\sqrt{2\pi\sigma^2}}\textup{exp}\left&space;\{&space;-\frac{(x-\mu)^2}{2\sigma^2}&space;\right&space;\}" title="\mathcal{N}(x|\mu,\sigma^2) = \frac{1}{\sqrt{2\pi\sigma^2}}\textup{exp}\left \{ -\frac{(x-\mu)^2}{2\sigma^2} \right \}" /></a>

![fig_2_10](https://github.com/triwave33/julia_bayes_ml_suyama/blob/master/ch2/fig_2_10.png)

## Fig 2.11
### 2.3.4 One-dimensional Gaussian distribution

#### Kullback-Laibler divergence

<a href="https://www.codecogs.com/eqnedit.php?latex=\begin{align*}&space;\textup{KL}\left&space;[&space;q(x)||p(x))&space;\right&space;]&space;&=&space;-\int&space;q(x)\,\textup{ln}\frac{p(x)}{q(x)}dx&space;\\&space;&=&space;\left&space;\langle&space;\textup{ln}\,q(x)&space;\right&space;\rangle_{q(x)}&space;-&space;\left&space;\langle&space;\textup{ln}\,p(x)&space;\right&space;\rangle_{q(x)}&space;\end{align*}" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\begin{align*}&space;\textup{KL}\left&space;[&space;q(x)||p(x))&space;\right&space;]&space;&=&space;-\int&space;q(x)\,\textup{ln}\frac{p(x)}{q(x)}dx&space;\\&space;&=&space;\left&space;\langle&space;\textup{ln}\,q(x)&space;\right&space;\rangle_{q(x)}&space;-&space;\left&space;\langle&space;\textup{ln}\,p(x)&space;\right&space;\rangle_{q(x)}&space;\end{align*}" title="\begin{align*} \textup{KL}\left [ q(x)||p(x)) \right ] &= -\int q(x)\,\textup{ln}\frac{p(x)}{q(x)}dx \\ &= \left \langle \textup{ln}\,q(x) \right \rangle_{q(x)} - \left \langle \textup{ln}\,p(x) \right \rangle_{q(x)} \end{align*}" /></a>

#### KL divergence for 1D Gaussian distribution

<a href="https://www.codecogs.com/eqnedit.php?latex=\textup{KL}\left&space;[&space;q(x)||p(x))&space;\right&space;]&space;=&space;\frac{1}{2}\left&space;\{&space;\frac{(\mu&space;-&space;\hat{\mu})^2&plus;\hat{\sigma}^2}{\sigma^2}&space;&plus;&space;\textup{ln}\frac{\sigma^2}{\hat{\sigma}^2}-1&space;\right&space;\}" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\textup{KL}\left&space;[&space;q(x)||p(x))&space;\right&space;]&space;=&space;\frac{1}{2}\left&space;\{&space;\frac{(\mu&space;-&space;\hat{\mu})^2&plus;\hat{\sigma}^2}{\sigma^2}&space;&plus;&space;\textup{ln}\frac{\sigma^2}{\hat{\sigma}^2}-1&space;\right&space;\}" title="\textup{KL}\left [ q(x)||p(x)) \right ] = \frac{1}{2}\left \{ \frac{(\mu - \hat{\mu})^2+\hat{\sigma}^2}{\sigma^2} + \textup{ln}\frac{\sigma^2}{\hat{\sigma}^2}-1 \right \}" /></a>

![fig_2_11](https://github.com/triwave33/julia_bayes_ml_suyama/blob/master/ch2/fig_2_11.png)

__________________________________________________________________

## Fig 2.12
### 2.3.2 Multivariate Gaussian distribution


#### Multivariate Gaussian distribution

<a href="https://www.codecogs.com/eqnedit.php?latex=\mathcal{N}(x|\mu,\Sigma)=\frac{1}{\sqrt{(2\pi)^D\left&space;|&space;\Sigma&space;\right&space;|}}\textup{exp}\left&space;\{&space;-\frac{1}{2}(x-\mu)^\top&space;\Sigma^{-1}(x-\mu)&space;\right&space;\}" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\mathcal{N}(x|\mu,\Sigma)=\frac{1}{\sqrt{(2\pi)^D\left&space;|&space;\Sigma&space;\right&space;|}}\textup{exp}\left&space;\{&space;-\frac{1}{2}(x-\mu)^\top&space;\Sigma^{-1}(x-\mu)&space;\right&space;\}" title="\mathcal{N}(x|\mu,\Sigma)=\frac{1}{\sqrt{(2\pi)^D\left | \Sigma \right |}}\textup{exp}\left \{ -\frac{1}{2}(x-\mu)^\top \Sigma^{-1}(x-\mu) \right \}" /></a>

![fig_2_12](https://github.com/triwave33/julia_bayes_ml_suyama/blob/master/ch2/fig_2_12.png)


## Fig 2.13
### 2.3.6 Wishart distribution

#### Wishart distribution

<a href="https://www.codecogs.com/eqnedit.php?latex=\mathcal{W}(\Lambda|\nu,&space;\textbf{W})=C_\mathcal{W}(\nu,\textbf{W})\left&space;|&space;\Lambda&space;\right&space;|^\frac{\nu-D-1}{2}\textup{exp}\left&space;\{&space;-\frac{1}{2}\textup{Tr}(\textbf{W}^{-1}\Lambda&space;)&space;\right&space;\}" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\mathcal{W}(\Lambda|\nu,&space;\textbf{W})=C_\mathcal{W}(\nu,\textbf{W})\left&space;|&space;\Lambda&space;\right&space;|^\frac{\nu-D-1}{2}\textup{exp}\left&space;\{&space;-\frac{1}{2}\textup{Tr}(\textbf{W}^{-1}\Lambda&space;)&space;\right&space;\}" title="\mathcal{W}(\Lambda|\nu, \textbf{W})=C_\mathcal{W}(\nu,\textbf{W})\left | \Lambda \right |^\frac{\nu-D-1}{2}\textup{exp}\left \{ -\frac{1}{2}\textup{Tr}(\textbf{W}^{-1}\Lambda ) \right \}" /></a>

![fig_2_13](https://github.com/triwave33/julia_bayes_ml_suyama/blob/master/ch2/fig_2_13.png)

_______________________________________________________________

## Fig.3.3
### 3.2 Learning and prediction of descrete probability distribution
#### 3.2.1 Learning and prediction of Bernouli distribution

Consider Bernouli destribution on a binary variablble x.

<a href="https://www.codecogs.com/eqnedit.php?latex=x&space;\in&space;\{0,1\}" target="_blank"><img src="https://latex.codecogs.com/gif.latex?x&space;\in&space;\{0,1\}" title="x \in \{0,1\}" /></a>

<a href="https://www.codecogs.com/eqnedit.php?latex=p(x|\mu)=\textup{Bern}(x|\mu)" target="_blank"><img src="https://latex.codecogs.com/gif.latex?p(x|\mu)=\textup{Bern}(x|\mu)" title="p(x|\mu)=\textup{Bern}(x|\mu)" /></a>

Here, we want to learn the parameter µ. Thus we set Beta distribution as a prior distribution over µ.

<a href="https://www.codecogs.com/eqnedit.php?latex=p(\mu)=\textup{Beta}(\mu|a,b)" target="_blank"><img src="https://latex.codecogs.com/gif.latex?p(\mu)=\textup{Beta}(\mu|a,b)" title="p(\mu)=\textup{Beta}(\mu|a,b)" /></a>

According to sampling (observation of N data points),  posterior distribution about the parameter (µ) can be expressed as a beta distribution with new hyperparameters.

<a href="https://www.codecogs.com/eqnedit.php?latex=p(\mu|\mathbf{X})=\textup{Beta}(\mu|\hat{a},\hat{b})" target="_blank"><img src="https://latex.codecogs.com/gif.latex?p(\mu|\mathbf{X})=\textup{Beta}(\mu|\hat{a},\hat{b})" title="p(\mu|\mathbf{X})=\textup{Beta}(\mu|\hat{a},\hat{b})" /></a>

where

<a href="https://www.codecogs.com/eqnedit.php?latex=\hat{a}&space;=&space;\sum_{n=1}^{N}x_n&plus;a" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\hat{a}&space;=&space;\sum_{n=1}^{N}x_n&plus;a" title="\hat{a} = \sum_{n=1}^{N}x_n+a" /></a>

<a href="https://www.codecogs.com/eqnedit.php?latex=\hat{b}&space;=&space;N&space;-&space;\sum_{n=1}^{N}x_n&plus;b" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\hat{b}&space;=&space;N&space;-&space;\sum_{n=1}^{N}x_n&plus;b" title="\hat{b} = N - \sum_{n=1}^{N}x_n+b" /></a>

![fig_3_03](https://github.com/triwave33/julia_bayes_ml_suyama/blob/master/ch3/fig_3_03.png)


_________________________________________________________

## Fig.3.4
### Learning and prediction of 1-D Gaussian distribution

Precision (lambda) is unknown.

<a href="https://www.codecogs.com/eqnedit.php?latex=p(\lambda|x_*)=&space;\textup{Gam}(\lambda|\frac{1}{2}&plus;a,b(x_*))" target="_blank"><img src="https://latex.codecogs.com/gif.latex?p(\lambda|x_*)=&space;\textup{Gam}(\lambda|\frac{1}{2}&plus;a,b(x_*))" title="p(\lambda|x_*)= \textup{Gam}(\lambda|\frac{1}{2}+a,b(x_*))" /></a>

where

<a href="https://www.codecogs.com/eqnedit.php?latex=b(x_*)=\frac{1}{2}(x_*-\mu)^2&plus;b" target="_blank"><img src="https://latex.codecogs.com/gif.latex?b(x_*)=\frac{1}{2}(x_*-\mu)^2&plus;b" title="b(x_*)=\frac{1}{2}(x_*-\mu)^2+b" /></a>

Logarithmic form of predictive distribution is expressed below,

<a href="https://www.codecogs.com/eqnedit.php?latex=\textup{ln}\,p(x_*)=-\frac{2a&plus;1}{2}\textup{ln}\{1&plus;\frac{1}{2b}(x_*-\mu)^2\}&plus;&space;\textup{const.}" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\textup{ln}\,p(x_*)=-\frac{2a&plus;1}{2}\textup{ln}\{1&plus;\frac{1}{2b}(x_*-\mu)^2\}&plus;&space;\textup{const.}" title="\textup{ln}\,p(x_*)=-\frac{2a+1}{2}\textup{ln}\{1+\frac{1}{2b}(x_*-\mu)^2\}+ \textup{const.}" /></a>

and alike to (logarithmic form of) **Student's t distribution**

![fig_3_04](https://github.com/triwave33/julia_bayes_ml_suyama/blob/master/ch3/fig_3_04.png)

## Fig.3.6 & 3.7

### 3.5 Linear Regression
#### 3.5.1 model creation

<a href="https://www.codecogs.com/eqnedit.php?latex=y_n=\textbf{w}^\top&space;\textbf{x}_{n}&plus;\epsilon_n" target="_blank"><img src="https://latex.codecogs.com/gif.latex?y_n=\textbf{w}^\top&space;\textbf{x}_{n}&plus;\epsilon_n" title="y_n=\textbf{w}^\top \textbf{x}_{n}+\epsilon_n" /></a>

<a href="https://www.codecogs.com/eqnedit.php?latex=\epsilon_n\sim&space;\mathcal{N}(\epsilon_n|0,\lambda^{-1})" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\epsilon_n\sim&space;\mathcal{N}(\epsilon_n|0,\lambda^{-1})" title="\epsilon_n\sim \mathcal{N}(\epsilon_n|0,\lambda^{-1})" /></a>

<a href="https://www.codecogs.com/eqnedit.php?latex=p(y_n|\textbf{x}_n,\textbf{w})=\mathcal{N}(y_n|\textbf{w}^\top\textbf{x}_n,\lambda^{-1})" target="_blank"><img src="https://latex.codecogs.com/gif.latex?p(y_n|\textbf{x}_n,\textbf{w})=\mathcal{N}(y_n|\textbf{w}^\top\textbf{x}_n,\lambda^{-1})" title="p(y_n|\textbf{x}_n,\textbf{w})=\mathcal{N}(y_n|\textbf{w}^\top\textbf{x}_n,\lambda^{-1})" /></a>

<a href="https://www.codecogs.com/eqnedit.php?latex=p(\textbf{w})=\mathcal{N}(\textbf{w}|\textbf{m},&space;\mathbf{\Lambda}^{-1})" target="_blank"><img src="https://latex.codecogs.com/gif.latex?p(\textbf{w})=\mathcal{N}(\textbf{w}|\textbf{m},&space;\mathbf{\Lambda}^{-1})" title="p(\textbf{w})=\mathcal{N}(\textbf{w}|\textbf{m}, \mathbf{\Lambda}^{-1})" /></a>

![fig_3_06](https://github.com/triwave33/julia_bayes_ml_suyama/blob/master/ch3/fig_3_06.png)

Fig.3.6 sampling of 3rd order function from pre-trained model

![fig_3_07](https://github.com/triwave33/julia_bayes_ml_suyama/blob/master/ch3/fig_3_07.png)

Fig 3.7 sampling of synthesized data (y_n) from the function.
