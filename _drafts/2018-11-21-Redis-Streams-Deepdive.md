---
title: Redis Streams Deepdive
layout: post
excerpt_separator: <!--more-->
---

[Redis Streams](https://redis.io/topics/streams-intro) have landed in Redis 5, and bridge the gap
between Redis' Lists and Pub/Sub structures that came before them.
{: .feature}

Redis Lists provide fast pushing, popping and range queries, and are similar to
the fundamental double-ended-stack datastructure. On the other, Redis Pub/Sub provides "fire and
forget" messaging amongst different channels. Messages in PubSub are *ephemeral* - once gone, they're
gone. Your client has to be listening when the server publishes if you're going to get the message.

If you wanted a way to pass messages between producers and consumers, but it was important that no
messages got dropped, then you can see Pub/Sub in Redis is a no-go. So, many people turned to Lists
(or even [sorted sets](https://redis.io/topics/data-types-intro#redis-sorted-sets), if order is
more important than atomicity, and you can deal with its set traits) to implement producer and
consumer queues.

[^celerybrokers]: Celery offers a choice of broker between Redis, RabbitMQ and a couple others

[Celery](http://www.celeryproject.org/) and [Huey](https://huey.readthedocs.io/en/latest/), two popular
Python task queue libraries both implement Redis lists as their backend broker[^celerybrokers].
But as with PubSub, Lists are also a trade-off in the *message queue* or *timeseries* patterns,
and arguably Sorted Sets more so. Clearly, Redis has an appetite for some new data type that tries
to address this middle-ground between Lists, Pub/Sub and Sorted Sets - *Streams* enter the scene:

> In some way, you can think of streams as a supercharged version of Redis lists. Streams elements
> are not just a single string, they are more objects composed of fields and values. Range queries
> are possible and fast. Each entry in a stream has an ID, which is a logical offset. Different
> clients can blocking-wait for elements with IDs greater than a specified one.
>
> <cite>Antirez</cite>
{:.mid}


<!--more-->


I'll leave it to [Antirez](http://antirez.com/news/114) and
[Redis' Streams Intro](https://redis.io/topics/streams-intro) to introduce you to the Streams API,
and move on to how Streams are implemented. As with many of Redis' existing data types, having
an understanding of how the underlying structure is laid out, and what advantages and disadvantages
that affords can be an invaluable tool for anyone implementing an application on-top of Redis.
Redis is powerful, and powerful enough that abusing its datastructures can seriously bite you as
your application scales.



### Say hello to rax

<figure class="sheet redge" style="max-width: 400px;">
  <a href="https://upload.wikimedia.org/wikipedia/commons/a/ae/Patricia_trie.svg">
  <img src="https://upload.wikimedia.org/wikipedia/commons/a/ae/Patricia_trie.svg" width="400px" class="img-responsive littlepadder">
  </a>
  <figcaption>
  Example of a Radix Tree
  </figcaption>
</figure>

The underlying structure that enables all this streamy goodness is the
[Radix Tree](https://en.wikipedia.org/wiki/Radix_tree) (aka radix trie,
compact prefix tree). If you recall [trees](https://en.wikipedia.org/wiki/Tree_(data_structure))
from that CS 101 course you slept through in fisrt-year university, the radix tree is a type
of search tree, where we can store some object by a reference and find it by working our way
through the reference and following nodes with matching prefixes down the tree.

Using these Radix Trees with monotonically increasing IDs (basically, if you added it later, the ID is
*always* greater than all previous IDs) as the prefix keys into the tree, and that Redis will
auto-generate UNIX timestamp IDs if you don't otheriwse specify what ID you want, we are given
time-series capabilities in Streams basically for free!

TODO: explain Radix trees briefly, explain rax's implementation, how this fits the Streams API
TODO: Streams API worst-case asymptotic perf. and why


### Gotcha!

This particular quote took me by surprise:

> **Removing single items from a stream**
> 
> The command is called `XDEL`, and will just get the name of the stream followed by the IDs to delete.
> However in the current implementation, *memory is not really reclaimed until a macro node is
> completely empty, so you should not abuse this feature.*

Huh?

What's a macro node - how do I empty one?!

This somewhat cryptic warning to not abuse `XDEL` *"or else!"* is a result of how Streams
implement those `key : value` pairs: a representation called *Listpack*. As Antirez says,
<q>This library is just the successor of ziplist.c, that is, a data structure that can
represent a list of string elements inside a single allocation. It’s just a very specialized
serialization format</q>

TODO: Explain listpack why this upsets the radix tree.

