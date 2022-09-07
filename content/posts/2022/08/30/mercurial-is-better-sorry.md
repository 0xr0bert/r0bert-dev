---
title: Mercurial is better than git – sorry!
author: Robert Greener
date: 2022-08-30
description: "Git is an example of the inferior technology becoming the most prevalent"
tags: ["vcs", "mercurial", "git"]
categories: ["mercurial"]
---

I preface this post by saying that its going make me seem like a fucking luddite and is more of a rant about git's shocking UI than anything substantial -- sorry!

Throughout the late 70s and 80s there was the famous format war of Betamax vs. VHS.
Despite Betamax having superior video and audio quality[^1], VHS tapes won the battle.

Following this, throughout the mid 00s and 10s, there was a format war between two distributed version control systems: git and mercurial (hg)[^2].
Git has very clearly won this battle, commanding the entire space.
This is despite git being, frankly, a bit shit.

So, for some history, around the time git was created the main version control systems were centralised ones such as CVS and SVN.
These required a central server.
Linux was being developed using BitKeeper a proprietary system that decided to prevent free usage by the Linux project.
So, Linus Torvalds created git as a response to this.
The same incident also caused the creation of our protagonist: mercurial.

Subversion (SVN), which was the open-source version control system primarily used before git was incredibly simple. You made changes to files, committed them, and that was it.
You'd update your working copy, make more changes, and commit.
So on and so forth.

Git and mercurial are designed to support a distributed model[^3] where people can email patches to each other and so on.
This is great and this is a really useful feature.
It makes it easier for untrusted people to contribute and allows a range of working styles.

So then, what is the problem with git?
It's UI is **totally fucking awful**.
It's totally unintuitive.
To get some changes on to the central server, you first have to "stage" your changes to some staging area, then commit.
Why not just commit?
It makes no sense.
For ages to delete a remote branch you had to do `git push origin :branch`.
It's so unintuitive.
Then there's commands like `git rerere`[^4] -- wtf!?
Why can't it nicely order commits with numbers, e.g., checkout the 5th commit, instead of using SHA-1 checksums to identify them.

Mercurial on the other hand has a much more intuitive UI.
Make some changes `hg commit` then `hg push`.
No concept of a staging area.
Ordered, numbered commits.
Want to revert local changes to a file `hg revert <file>` (in git `git checkout <file>`).

That's without considering the *amazing* work done to mercurial recently.
In particular the evolve extension is just great.
It's a way of having draft / public commits, where public commits are immutable.
For draft commits we can make changes, drop them, reorder them, all while sharing them with others in a safe way.
This just isn't possible in git.

Mercurial also supposedly works better with windows, but I could care less.

I'd genuinely like to use mercurial, but frankly, the world has just moved on 😔.
I'm intending from now on to use mercurial (with hosting on [sourcehut](https://hg.sr.ht)) as it's just better.
In the long-run, I'd quite like to use [pijul](https://pijul.org/) a distributed version control system based upon a theory of patches -- a modern-day DARCS.
However, right now it's too early.
Also, until there is the option to self-host repos with a web UI, I'm not going to consider it.
What if [nest.pjul.com](https://nest.pijul.com) closes down?

[^1]: <https://en.wikipedia.org/wiki/Betamax>
[^2]: I know other alternatives like bazaar and fossil exist, but they're not really worth mentioning -- sorry!
[^3]: Even though, these days how many people are using it distributed! GitHub may as well be modern subversion but whatever.
[^4]: <https://www.git-scm.com/book/en/v2/Git-Tools-Rerere>
