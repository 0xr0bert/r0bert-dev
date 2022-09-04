---
title: Lots of R code is illegal
author: Robert Greener
date: 2022-09-04
description: "The R ecosystem has appeared to completely ignore free-software licensing"
tags: ["licensing", "R"]
---

**Disclaimer: I am not a lawyer, this is just my opinion as lay-person with experience with free-software.**

The R ecosystem appears to completely disregard the restrictions imposed by common free-software licenses, in particular the [GNU General Public License](https://www.gnu.org/licenses/licenses.html) (GPL).
Briefly, the GPL is a copyleft license that requires derivative works to also be licensed under the GPL.
This means that if I use a GPL-licensed library in my code, it *must* also be released under the GPL.
In legal wording, from the GPL version 3, it says:

> You may convey a work based on the Program, or the modifications to produce it from the Program, in the form of source code under the terms of section 4, provided that you also meet all of these conditions:
>
> a) The work must carry prominent notices stating that you modified it, and giving a relevant date.
>
> b) The work must carry prominent notices stating that it is released under this License and any conditions added under section 7. This requirement modifies the requirement in section 4 to “keep intact all notices”.
>
> c) You must license the entire work, as a whole, under this License to anyone who comes into possession of a copy. This License will therefore apply, along with any applicable section 7 additional terms, to the whole of the work, and all its parts, regardless of how they are packaged. This License gives no permission to license the work in any other way, but it does not invalidate such permission if you have separately received it.
>
> d) If the work has interactive user interfaces, each must display Appropriate Legal Notices; however, if the Program has interactive interfaces that do not display Appropriate Legal Notices, your work need not make them do so.

The important part here is part c.
You must license the entire work under the GPL.
The R ecosystem appears to wilfully ignore this requirement, to the detriment of its users.

Take tidyverse, a group of packages.
The meta-package is licensed under the MIT license (basically free to do anything).
This is used by loads of professional R developers.
This imports dplyr, also MIT licensed.
dplyr imports pillar, also MIT licensed.
pillar imports fansi, GPL licensed -- uh oh.
As pillar is a derivative work of fansi, pillar should be GPL licensed.
Therefore, dplyr should be GPL licensed.
That means, tidyverse should be also!
That means that nearly all R code written should be GPL licensed.

This isn't even the only case.
tidyverse depends on broom which depends on backports (GPL), dplyr (should be GPL), purrr (GPL), stringr (GPL), tibble (depends on fansi (GPL) and pillar (should be GPL)), etc.
It's GPL all over!

Even more mental is that tidyverse depends on purrr (GPL version 3) and stringr (GPL version 2 only).
GPLv2 and GPLv3 are incompatible[^2]!
So there is literally no way that any code using tidyverse is compliant with its license.

Now, that would be fine, if users knew that.
I have no issue with the GPL, if you installed tidyverse and it was clear that the code was GPL-licensed, and therefore your code would be GPL-licensed, that's fine -- you know what you're agreeing too.
However, all users see is that they import tidyverse and it's MIT licensed, so they assume are not bound by the GPL.
But they are, their code depends on GPL licensed code transitively -- it still applies to them.
I have not seen such a mess in any other ecosystem, though if you know of any feel free to leave a comment.

Perhaps the issue is so prevalent in R as most of the packages have been developed by statisticians, rather than software developers.
Free software developers are used to dealing with these issues and generally know when it is okay, and when it is not okay, to use code given its license.

To be thorough, there is some debate as to whether dynamically-linked code, as is the case with R, is protected under the GPL.
However, the Free Software Foundation, the authors of the GPL, state "if you distribute modules meant to be linked together by the user, you have made them into a combined work, and you must release the entire combined work under the GNU GPL.
In other words: dynamic vs. static linking never makes any difference on the outcome of the analysis. The FSF has been advised by several US lawyers on this matter over the years, and the answer is always this one.".

It gets even worse.
[generics](https://github.com/r-lib/generics) is an R package that is depended on as part of many of the tidyverse packages and is developed by RStudio.
On the 2nd of September 2020, it was relicensed from the GPL version 2 to the permissive MIT license.
It is not clear to me what authority they had to do that.
For example, take the first pull-request from an external contributor in June 2018[^1].
The contributor Alex Hayes, contributed some functions to add generics for broom.
We must assume that by contributing that Alex was content to release his code under the terms of the GPL version 2, the project license.
We cannot assume that he would also be happy to release it under the more permissive MIT license, he has not given us the right.
Now, Alex may not, and I'd suggest probably doesn't, care; however, we cannot make that assumption.
If Alex wanted to enforce his rights he could require that generics be returned to the GPL and any of its reverse dependencies also.
This is not the only example of it in this repository.

So, what is the solution, if people involved with R even want to fix it?
Option 1 is to relicense anything that depends on GPL-licensed code as being licensed under the GPL.
Option 2 is to remove any GPL-licensed code from tidyverse.
**There is no option to relicense existing GPL code as MIT licensed code unless ALL contributors agree**.
It would be great if R package developers could take a more careful view on software licensing in future.

What's the solution if people involved with R don't fix it?
Use Python or Julia.

[^1]: <https://github.com/r-lib/generics/pull/1>
[^2]: <https://www.gnu.org/licenses/license-list.en.html#GPLv2> 
