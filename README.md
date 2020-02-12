# julia_bayes_ml_suyama
reproducing figures using JuliaLang in "Introduction to Machine Learning by Bayesian Inference" written by Suyama, Atsushi.

![image](https://user-images.githubusercontent.com/36175603/74348688-6d580500-4df6-11ea-8883-780d44352897.png)

(ISBN 9784061538320)

## Fig 2_1
### 2.1.5 Approximate calculation of expectation by sampling

![fig_2_1](https://user-images.githubusercontent.com/36175603/74021931-e105a680-49df-11ea-8746-c4f9843dba23.png)

________________________________________

## Fig 2_2
### 2.2.1 Bernoulli distribution
 
![Fig 2_2.png](https://user-images.githubusercontent.com/36175603/74019791-8b2eff80-49db-11ea-9ea1-80810041f79d.png)

________________________________________


## Fig 2_3
### 2.2.2 Binomial distribution

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

