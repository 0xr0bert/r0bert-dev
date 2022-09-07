---
title: Thinking causally
author: Robert Greener
date: 2020-08-03
description: "How to answer counterfactual questions -- what would happen if we changed something?"
tags: ["statistics", "causality"]
---

There are three types of data science tasks: description, prediction and causal inference. Most of the focus in our work goes on prediction and rightly so — it’s usually where the money is. However causal inference is important. Particularly so for those of us in a research context. However, in order to predict the counterfactual, what would happen if we changed something, we _must_ become more formal in our statistics.

# Confounders

First, we must understand what a _confounder_ is. A confounder is a third variable that influences our independent and dependent variable and does not lie on the causal pathway between the independent and dependent variable, creating a _spurious association_. So if we were to consider three variables, smoking, heart disease and death, heart diesease would lie on the causal pathway between smoking and death so it is _not_ a confounder.

However, if we were to consider three variables, smoking, age and death, age would affect the probability of taking up smoking and age would also affect the probability of death. Finally, smoking does not lie on the causal pathway between smoking and death (i.e. smoking does not cause age so age isn’t in the middle). Therefore, age is a _confounder_.

What does this mean? This means that if age is our only confounder and we do not make efforts to _adjust_ for age, our estimate for the causal effect of smoking on death will be biased.

There are two main ways to deal with confounders. The first is at the _design_ stage. Here we can use randomisation. This would mean a 50% chance (actually it doesn’t have to be 50% but this is usually easier) of taking up smoking and then look at how death differs between the non-smoking and smoking group. This is our _causal effect_. This controls for both known and unknown confounders. However, it’s not always practical or ethical to perform randomisation.

The second way is at the _analysis_ stage. Here we can adjust for confounders by adding them to our regression models. This will allow us to interpret our coefficient for smoking as the causal effect of smoking on death holding the confounders constant. We can also use more complex [_propensity score methods_](https://en.wikipedia.org/wiki/Propensity_score_matching). This controls _only_ for known confounders.

But, you cannot just throw in every variable you think is association with the outcome. If you do this you may get _collider bias_ which we’ll look at later on. You can only and you must only adjust for variables associated with both the _exposure_ and the _outcome_ which do not lie on the causal pathway between exposure and outcome.

# Directed Acyclic Graphs

How do we document our causal assumptions? In advance. We must specify what we think is a confounder _before_ we look at our data, to avoid data-snooping bias. You do this by looking at what other people have done and by using common sense about the problem.

![A causal directed acylic graph showing smoking causing death with heart disease on the causal pathway between smoking and death.](causal-dag.png "A directed acyclic graph. (Image by author)")

We can then draw out a _directed acyclic graph_ (DAG). This is a graph where the variables are our nodes and a directed edge between two vertices _A → B_ means that _A_ causes _B_.

# Obtaining our causal estimate

Assuming that we specified our causal DAG correctly, we can now obtain our causal estimate. If it is just the three variable case, we can simply add our confounder to our regression model. The estimate for smoking in our example is now the _causal_ effect of smoking on death. However, if there are more than 3 variables it can be confusing to see what we should adjust for. In particular, we may _introduce_ bias by adjusting for incorrect things.

To determine what we should adjust for, we can apply the _d-separation_ algorithm. This is an algorithm which looks for the minimal set of variables which we can adjust for such that our exposure and outcome would be conditionally independent if there were no true relationship between the two. This is a very tedious algorithm to apply by hand. However, we can use some software such as [DAGitty](http://www.dagitty.net/) to do this.

{{< rawhtml >}}
<figure>
	<img src="polzer.png">
	<figcaption><a href="https://link.springer.com/article/10.1007/s00784-011-0625-9"><emph>Source: Polzer et al. 2012.</emph></a>. Fair use for commentry.</figcaption>
</figure>
{{< /rawhtml >}}

Suppose we had this very complicated DAG. d-seperation shows that we must adjust for Age, Alcohol, Diabetes, Obesity, Psychosocial, Sex, Smoking, Sport in order to obtain the causal effect of ToothLoss on Mortality (assuming the DAG is correct of course!).

# Conclusion

Hopefully this has given you a bit of an insight into thinking causally. There are some _excellent_ books out there such as The Book of Why by Judea Pearl, who has done amazing work in the field, if you want to read more. The key points from this are that it _is_ possible to obtain causal estimates in the absence of randomisation. It requires careful specification of a causal model with a DAG, and it requires that you specify your model correctly. This is beyond the scope of this post, but it is key that in addition to identifying your confounders correctly, you must specify your model correctly. This means using things such as a Poisson regression model for count data, testing whether there are interactions between your confounders, testing whether the effect of the exposure / confounders on the outcome is linear, and if not including polynomial terms.

Once you have done all of that, you then have your causal estimate. Be careful to present this with the assumptions you have made. It can only be interpreted as causal if your assumptions are correct, and people may disagree with your assumptions.

Of course, you should consider whether you want to perform causal inference or just prediction. IF you are just interested in prediction you likely do not need this level of formality. However, if you care about the counterfactual, what happens if you change something, then you should care about this.

Also, it may be worth challenging your causal assumptions. See how stable your causal effect of _A_ on _B_ is if you change the structure of your DAG to another plausible DAG.

