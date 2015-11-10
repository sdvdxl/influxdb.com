---
title: Do you want to be an open source developer?
author: Cory LaNou
date: 2015-11-11
publishdate: 2015-11-11
---

Since joining the [InfluxDB](http://influxdb.org) core engineering team eleven months ago, I've been asked several times what it is like being an open source developer, and if it would be something they (the person asking) would enjoy.  The only way I have found to properly answer this question is to relate my experiences and let them draw their own conclusion.

## Who is this guy?
Normally I wouldn't start an article by talking about myself.  I don't consider myself that amazing or important, but for this topic, it is relevant to set context.

I have been a software developer most of my adult life. While I didn't always have a formal "developer" title when I first started out, it's clear when reflecting on my daily activities that I was, in fact, a developer. I started out as a quality assurance technician in 1994 for a small company building resistance welding machines.  Tracking defects and anomalies on paper was difficult.  My manager was already using a software called <a href="https://en.wikipedia.org/wiki/Paradox_(database)">Paradox</a> to track the defects. It wasn't long before I was modifying input screens and reports to enhance the usefulness of the software.  From there I fell into one software opportunity after another (If you really want the details, check out my [linked in profile](https://www.linkedin.com/in/corylanou)).  To summarize my career, I spent about fifteen years writing software on the various closed source platforms.  Anything from <a href="https://en.wikipedia.org/wiki/Delphi_(programming_language)">Borland Delphi</a> to [Microsoft .Net](https://en.wikipedia.org/wiki/.NET_Framework).

## Go!
In March 2012, [Go](http://golang.org) had it's first official 1.0 release.  It happened to coincide with a complete rewrite of our current platform, and seemed like a good technology fit.  What was unique about this for me is that there really wasn't much of a community yet.  Sure, the core team for Go was answering the mailing list, doing some talks here and there, but if you were to search Google for [Golang](http://google.com/#q=golang) or the Twitter hashtag [#golang](https://twitter.com/hashtag/golang?src=hash) you would come up pretty empty.  As I continued developing in Go, and having questions, I started interacting with their community via twitter.  I was so in love with Go, I started one of the first [Go meetups](http://www.meetup.com/Denver-Go-Language-User-Group/) in the world (only 3 months after the [GoSF meetup](http://www.meetup.com/golangsf/).  A couple of years later, [GopherCon](http://www.gophercon.com/) was hosted in Denver where I was living.  Attending GopherCon forever cemented my desire to be part of the community.  It was also where I met [Paul Dix](https://twitter.com/pauldix), the CEO of [InfluxDB](http://influxdb.com).

## Entering the Open Source world
I joined the InfluxDB team on December 29th, 2014.  I was completely new to their code base, however, because it was written in Go I was able to immediately get to work and start contributing.

This is my very first [commit](https://github.com/influxdb/influxdb/commit/e19db2b89d924b9e1d5a143746bd23bb90c96974) to the project.  Shortly after, I had my very first [Pull Request](https://github.com/influxdb/influxdb/pull/1276).  There were 80 comments and numerous additional commits as a result of the comments.  It set some expectations for me immediately.

## Lessons Learned
First, code quality was pretty important.  This isn't to say that you write elegant, beautiful code.  I write ugly code almost all of the time (and I don't always refactor like I know I should).  By code quality, it means things like:

- **Variable names** - Do they have clear context.
- **Comments** - Are they useful or just confusing?
- **Code organization** - Can someone else follow the flow of what I just wrote.

It was clear that I had been writing code solo for a long time, and nobody was telling me I got sloppy.

## Can someone take a look at this?
This was also my first experience with real code reviews.  Sure, I've had people look at my code before, but never line by line.  The comments on your code tend to be very "matter of fact", and can easily be taken as an insult or someone picking on you.  Rest assured, they are not.  I always read all feedback as if a computer analyzed my code and responded.

I think of feedback as a spell checker.  When something is surfaced, it's usually because it's wrong, or the computer didn't understand it.  Sometimes your word is spelled right and you can ignore.  However, my experience is that if there are two or more developers that comment on the same area of the code, one of two scenarios are true.  At best there is some room for improvement.  At worst you simply got it completely wrong.  These are neither good or bad, they simply are.  As a developer, you fix them, make them better, and grow.  Most importantly, I'm grateful someone on my team or the community cared enough to help me become a better developer.

Bottom line, for me, code reviews are a must. All of your team is better for them.  I'll likely never work anywhere that doesn't do them or understand their importance.

## You know everyone can see that right?
In my second [pull request](https://github.com/influxdb/influxdb/pull/1298), something else became very obvious to me. Everyone can see my code.  Now, I understood that when I started, but I was unprepared for how uncomfortable I felt about it.  What if everyone thought my code was horrible?

To add to that fear, while working on this particular PR, I came across an unexpected behavior in the Go language.  When I looked up the issue on the Go issues, I saw that [Dave Cheney](https://twitter.com/davecheney) had commented on the issue and ultimately closed it.  I knew Dave through the community, so I reached out to him about it.  Dave asked me for some context, so naturally I linked him the PR, after all, it is public.

Next, to my horror, he began reviewing the PR!  This was like having a rockstar ask you to sing one of their songs in front of them.  To add even more stress, my team members started asking in slack why Dave was reviewing our code. Did I have some bad code?  Oh yeah.  Did Dave comment on it?  He sure did. Here are a couple of his comments:


- _"I think this should go to the top of the function. Why do all this work to find that the address isn't valid?"_


- _"ResolveUDPAddr will return a better error here. One that you can inspect to see if it is temporary or not."_


In the end, it was a great experience, and I was worried for no reason. I learned a lot on that paticular topic as a result of all the extra attention.

## You have to be an expert to work full time on an open-source project.
Categorically **FALSE**! One of the very first concerns I get when people ask me about doing full-time open-source is if they are smart enough, or have enough experience.

There are a couple things I've learned about why you don't need to be an expert.  First, nobody knows everything about software development.  I really never knew much about the [Time Package](http:/golang.org/pkg/time) when I started.  Other than `time.Now()` there wasn't much need for it.  After developing on the InfluxDB core team for 8 months, I can now type `time.RFC3339Nano` in my sleep!  Second, what you don't know (or get wrong), the community will let be there to educate you.  Sometimes their feedback is very constructive and helpful. Other times, it can come off terse or rude (although I've found that a lot of times this is due to English not being their primary language). The important thing to always remember is did you learn something from their feedback (nice or rude)?  If so, then it was a positive experience.  I haven't had a single interaction to date that I would consider negative.  Overall they have been supportive and educational.

## Be fearless!
Hopefully I've given a little context to what my experience has been as an open-source developer.  I would encourage everyone to do it, if not full-time, at least find something you are passionate about and contribute.  Even the smallest contribution is very appreciated.  Seriously, PR that one word typo in their documents.  I can assure you they appreciate it! Don't have time to PR something but have identified a feature they are missing, see an area that can be improved, or... **gasp**... you spotted a bug?  Simply file an issue.  Don't assume they have thought of it or spotted it.  Every contribution, be it code or issues, make each open-source project better for everyone.

## What's Next?

If this article has motivated you to get involved in an open source project, look no further!  InfluxDB has just categorized several open issues that we are looking for help on from the community.  Check out the [blog post](https://influxdb.com/blog/2015/11/05/start_contributing.html) or go right to the [issues](https://github.com/influxdb/influxdb/labels/status%2Fhelp-wanted)!
