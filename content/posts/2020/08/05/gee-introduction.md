---
title: An introduction to Generalized Estimating Equations
author: Robert Greener
date: 2020-08-05
description: "How to assess the population average effect for longitudinal data"
tags: ["statistics", "R"]
---

A key assumption underpinning _generalized linear models_ (which linear regression is a type of) is the independence of observations. In longitudinal data this will simply not hold. Observations within an individual (between time points) are likely to be more similar than those between individuals.

So, how do you deal with this? One option is to fit a generalized linear mixed model in which there are random intercept and slope terms for each individual. This will tell you for a specific individual (i.e. conditional on the random intercept and slope) what is the effect of a variable on an outcome. However, this isn’t very useful if you are concerned with the _marginal_ effect, i.e. what is the effect of a variable on an outcome _on average_ in the population.

If you want to answer these population questions you need to fit a generalized linear model using _generalized estimating equations_ (GEE). This is an approach that obtains the population average effect accounting for the fact that observations within individuals are likely to be more similar than those between individuals.

# An example

Suppose we have our _outcome_ — all-cause mortality. Now suppose we record this every month for 10 months for every person. Now suppose our exposure, which is just time. We can now define a logistic regression model, with the sole independent variable being time (in months) and the dependent variable being death at that time. “Okay, great” I hear you say “but these observations are _obviously_ not independent!”. Spot on, but we’ll come to that.

# Working correlation structures

To use GEE we must first define how time points are related. However, by using [Huber-White standard errors](https://en.wikipedia.org/wiki/Heteroscedasticity-consistent_standard_errors) our results will be _consistent_ even if we misspecify this relationship! So we have some choices.

## Independent

This working correlation structure assumes that time points are independent of each other. This is probably an unreasonable assumption in practice.

## Exchangeable

This is where the correlation between observations at two time points is equal for any two time points. This is commonly used as it requires just one additional parameter α to be estimated.

## Autoregressive

This is where the correlation between observations follows an autoregressive structure. Suppose we were using an AR-1 correlation matrix. This would mean that the correlation between month 1 and 2 of a person would be expected to be α and the correlation between month 1 and 3 of a person would be expected to be α², between month 1 and 4 would be α³ and so on.

This is most appropriate when you think closer together time points are more similar than further apart time points.

## Unstructured

This is where we estimate a separate α for each possible combination of time points. This is the most general case. Though you need a lot of data to be able to estimate all of the α used.

## Other choices

There do exist some other choices, but these aren’t widely used.

## How to choose what one to use?

It’s simple. Either choose the most general one your data can support (depending on sample size) or you can choose one you think suits the data best. Either way, don’t sweat it! This approach is consistent even if you misspecify this.

# How to fit the model

Fitting the model is simple. We just fit a GLM using GEE with our specified working correlation matrix:

$$
\begin{split}
Y\_{ij} &= \operatorname{Bernoulli}\(p\_{ij}\) \\\\
\operatorname{logit}\(p\_{ij}\) &= \\beta\_0 + \\beta\_1 T\_{ij}
\end{split}
$$

Where:

-   Yij is 1 if participant i died at time j
-   pij is the probability of death for participant i at time j
-   β0 is the population average log odds of death at time 0. This can be exponentiated to obtain the odds of death at time 0.
-   β1 is the population average difference in log odds of death associated with a one-month increase in time. This can be exponentiated to obtain the odds ratio associated with a one-month increase in time.
-   Tij is the time of the j’th measurement for participant i in months.

That’s it. Our population average effect of a one-month increase on time increases the odds of death by an odds ratio of exp(β1).

## Fitting a model in R

We can do this in R using [geepack](https://rdrr.io/cran/geepack/man/geeglm.html). Suppose our dataframe already existed with three columns `death` `time` and `person.id` all we have to do is:

```{r}
library(geepack)  
mod <- geeglm(
    death ~ time,
    id = person.id,
    waves = time,
    family=binomial,
    corstr="exchangeable"
)
```

You can then just call `summary(mod)` as normal and get your results!

And of course, you could add covariates to the model by just adding them to the formula. They can be time-varying or constant — either is fine!

# Conclusion

Hopefully you’ve come away from reading this with a basic idea of GEE. They should be a tool in the toolbox of any data scientist working with longitudinal data.

