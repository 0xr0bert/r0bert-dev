---
title: Stop using p=0.05
author: Robert Greener
date: 2020-08-06
description: "Stop using arbitrary statistical significance cut-offs"
tags: ["statistics"]
---

How many of you use p=0.05 as an absolute cut off? p ≥ 0.05 means not significant. No evidence. Nada. And then p < 0.05 great it’s significant. This is a crude way of using p-values, and hopefully I will convince you of this.

# What is a p-value?

A lot of us use p-values following this arbitrary cut off but don’t actually know the theoretical background of a p-value. A p-value is the probability, under the null hypothesis, of observing data at least as extreme as the observed data. It is not, for example, the probability that some population parameter x = 0. x either equals 0 or it does not (in a frequentist setting).

So, the smaller the p-value, the more unlikely it is that this data would have been observed under the null hypothesis. In essence, the smaller the p-value, the stronger the evidence against the null hypothesis.

# What affects p-values?

Two things mainly. The first is the strength of effect. The greater the difference from the null hypothesis. The smaller the p-value will be.

The second is the sample size. The larger the sample, the smaller the p-value will be (if in fact the null hypothesis is false).

So, this means that if p ≥ 0.05, it could be because the effect isn’t that strong (or doesn’t exist) or that our sample is too small, resulting in our test being _underpowered_ to detect a difference.

# Some examples

## A deadly drug

Suppose we were looking at adverse events of a new drug. Now suppose p=0.051 for evidence that the drug increases the rate of deaths. Now, if we used p=0.05 as a cut-off then it’s great. No evidence that the drug increases the rate of deaths — let’s put it into production. Now imagine that p=0.049 of an increase in the rate of deaths. Oh no! There’s evidence that the drug is harmful. Let’s not put it into production.

Mathematically, there’s not really a difference between the two. They are essentially the same. But by using this arbitrary cut off we reach very different conclusions.

## Does this drug work

Now imagine another drug. We’ve got a very large sample (n=10,000) and we want to know whether this drug cures cancer. So we get p=0.049 that it cures cancer. Great! Significant evidence this drug cures cancer. Let’s give it to everyone.

Though, it’s a large sample. Wouldn’t we expect p to be smaller? It’s not that strong evidence against the null hypothesis. There’s approximately a one in twenty chance that our results are down to chance. Now suppose this drug is really expensive. Do we really want to start giving it out to everyone based on some fairly weak evidence? Probably not.

Now of course if p=0.001 this would be a one in a hundred chance that our results our down to chance. This would be much stronger evidence that the drug works.

# So how should we interpret p-values?

As a continuous scale. The smaller the p-value is, the stronger the evidence is. But, you should take the sample size and effect size into account. You should also consider whether you are looking at something positive or negative. If looking at something like our deadly drug example, we should be concerned even if the evidence is very weak. However, with something like wanting to know whether a drug works, we can afford to be much more sceptical about our result.

So, hopefully in the future, you’ll stop using p=0.05 as some threshold picked out of threshold and consider it as what it truly is — the weight of evidence against the null hypothesis. And, of course, if you don’t have the evidence you need that isn’t necessarily because it doesn’t exist it could be that you lack statistical power to detect an effect.

