---
title: Operating Systems Notes
layout: clear
author: J.Friel, A.Pearson, B.Shaw
---

OS Architecture {#os-architecture}
===============

Different architectures dictate the way that an operating system may
conduct its business.

As different architecture platforms have different instruction sets and
ASPLOS features, it determines what are viable methods for accomplishing
tasks such as *memory protection* and *control interrupts*.

The OS acts as an intermediary between software and hardware. It allows
mediation of access and gives developers a consistent API to access
hardware and low-level operations. This abstraction is achieved via
*traps* and *exceptions*. Similarly, devices can gain attention via the
use of *interrupts*.

An OS is intended to be a good balance between *user needs* and *system
needs*.

A user wants an OS to be *fast, reliable and safe*; an OS developer
wants it to be *efficient, error-free, and easy to maintain and
implement*.

The design of an operating systems makes a distinction between two
underlying principles:

**Policy**, which is *what* will be done; **Mechanism**, which his *how*
to do it.

Structure of an OS {#structure-of-an-os}
------------------

A capable operating system is home to a multitude of components: memory
management, I/O, file systems, command interpreters and so on. There are
multiple ways to link to structure how all these components are
connected to each other.

### Monolithic {#monolithic}

An early type of design for an OS, where the *entire* operating system
would function in *kernel mode* (see the *Privileged Instructions*
section). However, this design carried many issues with maintainability
and reliability, and was hard to make sense of.

### Layering {#layering}

As opposed to monolithic, this method implemented the OS as a *set of
layers* instead, where a layer could present itself to the corresponding
layer above.

|  5  |   **Job Managers**  | Execute a user’s programs                      |
|  4  | **Device Managers** | Handle devices, provide buffering              |
|  3  | **Console Manager** | Provide virtual consoles                       |
|  2  |   **Page Manager**  | Implement virtual memories for each process    |
|  1  |      **Kernel**     | Implement a virtual processor for each process |
|  0  |     **Hardware**    |                                                |

Layering provides a *hierarchical* structure but provides performance
issues as the overhead increases with the addition of each layer.
Systems can be modelled as layers, but tend not to be implemented in
such a way.

### Hardware Abstraction Layer {#hardware-abstraction-layer}

More common in modern OSs. The idea is to have a *core OS*, components
such as the file system and scheduler, which don’t depend on hardware.
Then, you have the *hardware abstraction layer* which specifically deals
with the hardware through *drivers* and *assembly routines*.

This allows for more portability, as the layer deals with translation
between the core and the specifics of the hardware; developers don’t
have to worry about specific traits of some hardware and can instead
deal with specifics of the core.

### Microkernel {#microkernel}

This concept aims to minimise what the *kernel* is responsible for, and
have the rest dealt with by processes at the user level. The Windows
Kernel (NT) is a good example.

This isolation allowed isolation between the components, but provides
poor performance as the number of user/kernel crossings greatly
increases.

### Loadable Kernel Modules {#loadable-kernel-modules}

Utilised by the \*NIXes (Linux, BSD, other UNIXes, Solaris), this
concept has core services within the kernel code itself, and then other
modules can be loaded in *dynamically*.

This style avoids some of the issues that come with layering, as it can
call any other module. As the loading is dynamic, there is no need for
reboots.

Privileged Instructions {#privileged-instructions}
-----------------------

These instructions are restricted to use by the OS *only*, and includes
direct access to *I/O devices* and *memory state management*.

This is achieved by the implementation of two *modes of operation*;
*user* and *kernel* modes.

Privileged instructions can only be executed in kernel mode.

<figure class="redge sheet"
        style="max-width: 400px;">
    <img src="https://upload.wikimedia.org/wikipedia/commons/2/2f/Priv_rings.svg"
        class="padder">
    <figcaption>
        x86 Architecture privelage levels.
        <br>
        <em>Courtesy of Hertzsprung of English Wikipedia</em>
    </figcaption>
</figure>

### System Calls {#system-calls}

If code running from within user mode tries to execute a privileged
instruction, it will trigger the *illegal execution trap*, which allows
for such code to gain access to privileged instructions and resources.
These are called *system calls*.

An OS will define a set of system calls that makes it possible for such
an interaction to take place.

*Caller*: The user mode process invoking the system call  
*Callee*: The OS handling the system code  

-   The caller places arguments, especially the *type* of system call,
    in a specified location
-   The callee saves the caller’s state
-   The callee verifies the arguments
-   If valid, the code is run
-   When the system call has been satisfied, the program counter is set
    to the return address
-   Execution is returned to user mode

Exception Handling {#exception-handling}
------------------

A *trap* is a synchronised, intended transition that is initiated by the
OS. The OS takes control as the result of a system call.

An *exception* is also synchronised, however it is an *unexpected*
problem with some instruction.

An *interrupt* is *a*synchronous on the other hand, and is caused by
some external device.

Processes {#processes}
---------

<figure class="redge sheet">
    <img src="/media/addressspace.jpg"
        class="padder img-responsive">
    <figcaption>An idealised address spaaaaaace given for a process</figcaption>
</figure>

A *process* is a program that is being executed.

A process must have a few key aspects for it to work:

**Address Space**

Contains the *instructions* of the running program, and the *data* for
running the program.


**CPU State**

Contains the *program counter* which indicates the next instruction, the
*stack pointer* and other register values.

**OS Resources**

Contains items that the OS gives the process access to, such as files,
network connections and so on.

A process can spawn another process, which are respectively called the
*parent* and *child* of each other. When the parent spawns its child, it
can choose to either *wait for the child to terminate*, or *run in
parallel with the child*.

Spawning of a child makes use of the `fork()` process. It returns `0` to
the child, and its process ID to the parent.

PCB: Process Control Block {#pcb-process-control-block}
--------------------------

The operating system needs a way to keep a track of all processes that
are running.

A data structure, called the *process control block*, or *process
descriptor*, aims to do this.

This name space includes all the *process IDs* of the processes that are
currently present. A process ID is a *unique integer*.

A process is called by the `fork()` function, and can be *killed*
(`kill()`), *paused* (`wait()`), and *limited* (`nice()`).

The PCB keeps: the process’s *execution state* when the process isn’t
active; the parent’s PID; program counter; and so on. Linux’s PCB has
over 95 fields for *each* entry.

|  **Ready**  |                Waiting to be assigned by the CPU                |
| **Running** |         The process that is currently running in the CPU        |
| **Waiting** | Cannot progress until some event happens, e.g. *I/O completion* |

When a process is returned to the *running* state, the values of
registers are transferred from the PCB to hardware registers. This is
called a *context switch*. These occur many, many times per second. The
decision of which process to run next is *scheduling*.

State Queues {#state-queues}
------------

A set of queues contains a queue for a process within each respective
state. These are implemented as a set of *linked lists*.

Sequential Process {#sequential-process}
------------------

The most simple style of process.

A *sequential process* is given some *address space* and a *thread of
execution*. The process will then be executed.

Memory Management Unit (MMU) {#memory-management-unit-mmu}
----------------------------

Effectively is a hash function from logical address to physical address.

A MMU prevents the need for swapped out processes to be swapped back
into the same physical addresses.

Swapping is not typically supported on mobile devices, more likely to to
overwrite least used data.

Partitioning {#partitioning}
------------

Main memory is usually broken up into two partitions; The OS and user
process.

Each process is contained within a single contiguous section on memory.

Reallocation registers are used to protect users processes from one
another and from changing the OS code.

Some old techniques include:

-   Fixed Partitions - simple but causes fragmentation often
-   Variable Partitions - no internal fragmentation, but can leave holes
    in the physical memory

Dynamic Storage-Allocation is possible using First-fit, Best-fit and
Worst-fit in terms of hole filling.

Threading {#threading}
=========

Instead of using multiple processes for concurrency, we can use threads,
which share the same address space and OS resources. This smaller
overhead usually results in threads being more performant than the same
number of separate processes.

With threads, we want the same program code, data, privileges and
resources (open files, sockets...) but we need multiple execution states
(each thread has it’s own registers and stack)

From the perspective of the parent process to a set of threads, the
*heap* is shared, and each thread has it’s own *stack pointer* and *PC*.

Kernel Threading {#kernel-threading}
----------------

The kernel presents it’s own threading library, with the kernel managing
both the process and threads memory. Kernel threads are more performant
than just processes, but because they are handled through **system
calls** there’s still a sizeable overhead.

User-Level Threading {#user-level-threading}
--------------------

User threads are built completely transparently to the underlying OS,
which only sees the parent processes. User threads can be very
performant, though if one thread is blocked due to IO etc., the entire
process will also be blocked as there is no way for the kernel to
schedule other threads as it isn’t aware of them.

User threads can be 10 to 100 times faster than kernel threads.

A combination of kernel threading and user-space threading can be used
to get the best performance.

Mutual Exclusion & Locking {#mutual-exclusion-locking}
==========================

<figure class="sheet redge" style="max-width: 500px;">
    <img src="/media/correctConcurrency.jpg"
        class="img-responsive">
    <figcaption>Concurrency Dependencies</figcaption>
</figure>

A *critical section* is a sequence of code that may result in incorrect
or undefined behaviour if executed simultaneously or pre-empted.
Similarly, race conditions occur when the order of execution is unknown
and behaviour can be unpredictable.

Mutual Exclusion (MutEx) and locking prevent these problems.

To be safe and operate correctly, a critical section must satisfy the
following requirements:

Mutual Exclusion
:   At most one thread is in the critical section

Progress
:   If a thread is outside the critical section, it cannot prevent
    another from entering

Bounded Waiting & No Starvation
:   If a thread is waiting to enter the critical section, it is
    guaranteed to eventually do so
    
Performance
:   The overhead of entering and exiting the critical section is small
    relative to the runtime of the section.


Deadlocks {#deadlocks}
---------

We obviously want to avoid deadlocking (and livelocking). For a deadlock
to occur, the following four conditions must exist:

1.  Mutual Exclusion
2.  Hold and Wait (Prevent a process that needs two or more locks from
    holding one and waiting for the other indefinitely - see the
    Philosopher’s Spaghetti problem)
3.  No Preemption i.e. we can’t stop a process/thread from running that
    may be causing a lockup
4.  Circular waiting e.g. a process busy waiting on a lock it won’t ever
    get

We can see if a deadlock is possible if there is an *irreducible* cycle
in the dependency/resource graph for a set of processes or threads.

Peterson’s Algorithm {#petersons-algorithm}
--------------------

        flag[i] = True;
        turn = 1-i;

        while (flag[1-i] && turn == 1-i); // spin

        /* critical section code */

        flag[i] = False;

Avoids both *deadlock* and *livelock* for two threads, using `i` and
`i-1` as signals. It works but can be tricky to implement.

Spinlocks {#spinlocks}
---------

A **spinlock** is a locking primitive, used to build more complex
locking mechanisms. The name comes from the behaviour; It ‘spins’ on a
condition until it is satisfied, so will acquire the lock as soon as it
is available.

        // do not have lock
        while(some_condition);
        // have lock

Acquiring and releasing locks *must* be an atomic operation, so no
context switching occurs during acquisition which could lead to a crash
or undefined state. **Test and Set** is an atomic instruction we can use
to achieve this.

        struct spinlock{
            int held;
        };

        struct spinlock lock;
        lock.held = 0;

        int test_and_set(int* flag){
            int old = *flag;
            flag = 1;
            return old;
        }

        void acquire(struct lock* lock)
        {
            /* This is the `spinning' */
            while(test_and_set(&lock->held));
        }

        void release(struct lock* lock)
        {
            lock->held = 0;
        }

Spinlocks are simple to implement, but can be slow and *block* whilst
waiting for the lock, wasting CPU time.

Semaphores {#semaphores}
----------

Similar to a spinlock, having the two operations `wait(semaphore)` and
`signal(semaphore)`, sometimes given as `P(semaphore)` and
`V(semaphore)`. Semaphores can use integer signals, or a boolean - the
boolean semaphore has the same behaviour as a lock.

        void wait(semaphore s)
        {
            while(s <= 0); // Busy wait
            s--;
        }

        void signal(semaphore s)
        {
            s++;
        }

This simple implementation uses *busy waiting*. We can use a wait queue
instead, placing ourselves onto the queue and yielding until the
semaphore is available.

        void wait(semaphore* s)
        {
            s->value--;
            if(s->value < 0){
                enqueue_process();
                /* Add self to the wait queue and block/sleep */
            }
        }

        void signal(semaphore* s)
        {
            s->value++;
            if(s->value <= 0){
                dequeue_process();
                /* Remove a process from the wait queue and wake it */
            }
        }

### Bounded Buffer Problem {#bounded-buffer-problem}

In a **producer and consumer** model, we can have many threads wishing
to consume some data, and many that produce it. The handover of data can
be done with a *bounded buffer*

<figure class="sheet center" style="max-width: 800px;">
    <img src="/media/produceConsume.jpg"
        class="padder img-responsive">
    <figcaption>Producer-Consumer model</figcaption>
</figure>

We can use three semaphores to ensure safety around this bounded buffer:

| mutex |  1  | Mutual exclusion on shared data (head & tail…)                            |
| empty |  n  | Number of empty / available slots in the buffer. Initially all available. |
| full  |  0  | Number of taken slots in the buffer. Initially none are taken.            |

    producer:
        wait(empty)
        wait(mutex)
            add item to buffer
        signal(mutex)
        signal(full)

    consumer:
        wait(full)
        wait(mutex)
            remove item from buffer
        signal(mutex)
        signal(empty)

### Pub Sub {#pub-sub}

The constraints on **publishers** (aka writers) and **subscribers** (aka
readers) are different:

1.  We *can* allow multiple subscribers to concurrently access
2.  We *cannot* allow publishers and subscribers to concurrently access
3.  We *cannot* have more than one publisher concurrently writing

This is because subscribers make the promise to not mutate the data,
while publishers do not.

| semaphore: mutex     |  1  | Mutual exclusion on shared data             |
| semaphore: writing   |  1  | Lock on mutation/writing to the data        |
| integer: read\_count |  0  | The number of subscribers currently reading |

    writer:
        wait(writing)
            perform writes // Satisfies requirement 3
        signal(writing)
        
    reader:
        wait(mutex)
            reader_count++;
            if (reader_count == 1) wait(writing); // Satisfy requirement 2
        signal(mutex)
        
        do reading
        
        wait(mutex)
            reader_count--;
            if (reader_count == 0) signal(writing); // Release lock on writers if no further readers
        signal(mutex)

Condition Variables {#condition-variables}
-------------------

Has similar operations to Semaphores: `wait()` and `signal()`.

Wait
:   Wait until another thread has signalled and released the lock

Signal
:   Wake a thread from the wait queue

Signals aren’t remembered if there are no threads in the wait queue like
they are with semaphores.

### Bounded Buffer {#bounded-buffer}

| lock: mutex         |  1  | Mutual exclusion on shared data (head & tail…) |
| condition: freeslot |  n  | There is at least one slot free                |
| condition: fullslot |  0  | There is at least one slot taken               |

    producer:
        lock(mutex)
        if [no slots available] wait(freeslot);
            Add item...
        signal(fullslot)
        unlock(mutex)

    consumer:
        lock(mutex)
        if [no slots have data] wait(fullslot);
            Pop item from shared buffer
        signal(freeslot)
        unlock(mutex)
        Use item...

Possible Bugs {#possible-bugs}
-------------

Most locking mechanisms are prone to bugs; They’re shared data
structures, and there’s never a guarantee a lock will ever be released
or acquired when it should be.

The lock is also not strictly associated with the data it protects; Have
we got the right lock? Should we have more than one lock? Programming
language structures such as classes with built in locking mechanisms go
some way to protect against these errors.

Monitors {#monitors}
--------

A higher level programming language structure, requires some notion of
objects (so would be tricky in C, much easier in C++). Each method in
the class automatically acquires a lock on entry, releasing it on exit.
This is transparent to the implementer of the API exposed by the class.
Safeties that come from using classes, such as protected/private methods
and structures help protect data.

Implementation of a monitor class in C++. `invariant` is asserted over
the life of a class, throwing an error if the condition is broken.
Similarly `precondition` asserts a condition before method execution is
allowed.

    class Account {
      private lock myLock;

      private int balance := 0
      invariant balance >= 0

      public method boolean withdraw(int amount)
         precondition amount >= 0
      {
        myLock.acquire();
        try:
          if balance < amount then return false
          else { balance := balance - amount ; return true }
        finally:
          myLock.release();
      }

      public method deposit(int amount)
         precondition amount >= 0
      {
        myLock.acquire();
        try:
          balance := balance + amount
        finally:
          myLock.release();
      }
    }


*Hoiked from [wikipedia](https://en.m.wikipedia.org/wiki/Monitor_(synchronization))*
{: .smaller .muted}

Secondary Storage {#secondary-storage}
=================

Disk Performance {#disk-performance}
----------------

-   Seek : moving the disk arm to the correct cylinder
-   Rotation(latency): waiting for the sector to rotate under the head
-   Transfer: transferring data from surface to disk controller

Seeks are very expensive, so the OS tries to schedule disk requests that
are queued waiting for the disk

-   FCFS - okay when load is low
-   Shortest Seek Time First (SSTF) - minimizes arm movement, unfairly
    picks middle blocks
-   SCAN(elevator algorithm) - service one direction till done,
    then reverse. Skews wait time non-uniformly
-   C-SCAN - like SCAN, but only goes in one direction (typewriter)
-   C-LOOK - similar to C-SCAN, arm only goes as far as final request in
    each direction

Paging {#paging}
------

Paging is a *memory management scheme* that an operating system utilises
to move information from secondary memory to main memory. A *page* is a
fixed-size block that resides in secondary storage.

This scheme is found in many modern operating systems as it allows for
programs to exceed the size of physically available memory.

Pages are stored in the *page table* which is stored in main memory. An
address is generated by the CPU which states the *page number* which
acts as a *base index* of the page table, and offset that provides the
physical address when combined with the page number.

With a pure page table, we need *two* accesses to retrieve a page, once
to the table to get the location of the page, and then to get the actual
contents of the page. We can implement a buffer however to speed this
up, the *translation look-aside buffer*, or *associative memory*.

The buffer stores identifiers that uniquely identify each process, but
keeps the number of entries quite low, usually with only 64 to 1024
entries.

If a request is made for some page but is no in the buffer, referred to
as a *miss*, the value will be loaded in for next time.

Physical Address
:   Same as a physical memory address in a simpler page-less system

Logical Address
:   Is the concatenation of a Page Number and Page Offset, and is the
    addressing scheme exposed to programs.

Page Table
:   Holds the translations from a *page number* to the base address
    (starting memory address) of a page. Each process has it’s own
    page table.

Page Offset
:   How far into a page the word of memory we’re addressing is.

Page Frame
:   The divisions of physical memory that can hold a page; A page frame
    is the same size as a page, but may or may not contain a (valid)
    page.

PTBR
:   Page Table Base Register - holds the physical address of the start
    of the page table

PTLR
:   Page Table Length Register

TLB
:   Translation Look-aside Buffer - effectively a fast cache of mappings
    from Logical to Physical addresses

<makr class="noir">WORDS.</mark>

The size of a page is usually OS specific, sometimes architecture
specific. Sizes in the range 4KiB to 8MiB or more are not unusual; Very
small pages, however, are undesirable as the page table itself takes
memory to keep track of all pages.

Pages can be shared between processes, in a similar way to shared memory
amongst threads. The mechanism for this is simple, as two processes
sharing a page will simply have two different (though not necessarily
different) logical addresses resolve to the same physical address.
Standard concurrency problems can occur.


<figure class="sheet center"
        style="max-width: 600px;">
    <img src="/media/tlbPaging.jpg"
        class="padder">
    <figcaption>
        Paging datapath with a TLB
    </figcaption>
</figure>

*Note that the lookup concurrently runs through the TLB and page table;
This is a race but the TLB is significantly faster, so if a hit occurs
the Page Table lookup is cancelled.*
{: .muted .smaller}

Memory Protection Within Pages {#memory-protection-within-pages}
------------------------------

Protection is implemented, to preserve the applicable level of access,
such as read-only.

A page also has a *valid/invalid* bit. It states if the page is within
the *logical* address space of some process. If *valid*, it is,
otherwise it is *invalid*.

Benefits of Page Tables {#benefits-of-page-tables}
-----------------------

-   There is memory protection between processes as each address space
    is unique to the process
-   Common libraries have a shared copy in physical memory instead of
    one-per-process, which is faster than making a system call
-   Different entries per process, so two different processes get
    different access rights.

Paging Table Size {#paging-table-size}
-----------------

If we were to implement a pure page table, the structure can be very
large which would make it rather inefficient.

However, we can use other methods to keep this size down.

### Hierarchical Paging {#hierarchical-paging}

Breaks the logical address space into *multiple page tables*.

The page number portion of the address would then be split further, into
another page table and offset value.

This quickly gets silly. A page number in a three level paging system
for a 64 bit address space is as follows:


        | 2nd Outer Page | Outer Page | Inner Page | Offset |
        |----------------|------------|------------|--------|
        | 63          32 | 31      22 | 21      12 | 11   0 |

### Hashed Page Table {#hashed-page-table}

Where the page number is hashed into a page table, where each element
has the virtual page number,r value of the page frame and a pointer to
the next element.

This reduces the amount of entries as each entry in a hashed page table
refers to *multiple pages* rather than one page.

### Inverted Page Table {#inverted-page-table}

Rather than each process having a page table, we track all physical
pages.

There is one entry in the table for each real page of memory, which
contains the virtual address of the page stored in that real location,
and information about the process that owns that page.

This reduces the amount of space that is required to store the table but
it takes longer to search the table when a page is referenced.

Memory Management {#memory-management}
=================

Programs must be brought from disk into memory and then placed into a
process.

The CPU can only access data from memory, not disk.

Register access takes at most 1 CPU cycle, but Main Memory can take many
cycles, causing a *Stall*.

Base and Limit Registers {#base-and-limit-registers}
------------------------

A set of *base* and *limit registers* define the logical address space.
The CPU must check every memory access is valid between the base and the
limit for that user. Failure causes a trap in the OS, and usually
results in a program being killed (e.g. a *Segmentation Fault*)

Virtual Address Space {#virtual-address-space}
---------------------

Logical/Virtual addresses are independent of physical memory.

Hardware translates virtual addresses into physical ones.

Logical/Virtual addresses a process can reference is called the address
space.

Virtual Memory {#virtual-memory}
==============

Page Fault {#page-fault}
----------

If there is a reference to a page that isn’t stored in memory, then
there will be a trap to the OS, a page fault.

The OS then finds a free frame, swaps page into frame via a scheduled
disk operation then resets the tables for validity.

Pages are only brought into memory when referenced, this is called
demand paging.

Page Replacement {#page-replacement}
----------------

There are a couple ways to pick which page to replace.

-   Pick a page that won’t be needed any time soon
-   Pick a page that hasn’t been used in a while

The goal of all of this to reduce the fault rate by selecting the best
victim page to remove. Best being one that will never be touched again.

Belady’s proof: “evicting the page that won’t be used for the longest
period of time minimizes page fault rate”

*Thrashing* is when the system spends most of its time serving page
faults, and little time doing useful things.

This could mean that there is not enough memory or that the memory is
over-committed.

<figure class="sheet center"
        style="max-width: 600px;">
    <img src="/media/pageFaultGraph.png"
        class="padder img-responsive">
    <figcaption>Page Faults vs Number of Frames</figcaption>
</figure>

### Replacement Algorithms {#replacement-algorithms}

-   First-In-First-Out
-   Belady’s Optimal Algorithm - Replace frame that will not be used for
    the longest time. (Not possible as we can’t see into the future)
-   Least Recently Used(LRU)
-   Replace a page that is ’old enough’ - logically, place all pages in
    a circle and rotate round

FIFO and LRU can each be implemented locally or globally.

Local :- Each process has a limited number of frames and operates within
them.

Global :- the victim is chosen from all page frames in the system,
regardless of owner:

File Systems {#file-systems}
============

The OS acts as an intermediary between the FS and an Disk. It should
hide hardware specifics and allocate disk blocks for the FS.

The file system is responsible for the organisation of files.

For example, Windows’ file system NTFS relies on the OS making distinct
difference between what disk it is reading from, such as the hard disk
or a connected USB thumb drive: `C:`, `D:`, etc.

On the other hand, Linux makes no distinction and instead maintains a
sole *root*, `/`, where everything is seen as a ’file’, such as a hard
disk (`/dev/sda`), or a media file you may have
(`/home/user/swedgefulBasslines.mp3`). A file is a *collection* of data;
its *contents*, *size*, *owner*, and so on.

Access Methods {#access-methods}
--------------

There are a few types of *access methods* that an FS can utilise:

Sequential Access
: read byte by byte

Direct Access
: random access given to block/byte

Record Access
: file is array of records

Indexed Access
: one file contains an index of a record in another file

Directories {#directories}
-----------

*Directories*, which can also be referred to as folders, are *nodes* of
the file system tree.

A directory contains a unordered list of all files and their attributes
within itself. Sorting is usually done by some other utility, such as
`ls`.

One way to find files within these directories, is via *path name
translation*.

A file system finds a file when given some *path*, such as
`/home/proper/legit/filepath/ooooo.sh` by walking through the path,
directory by directory. At the root, it would first look for `home`, get
its location, then look for `proper`, get its location, and so on.

File Protection {#file-protection}
---------------

The file system is responsible for checking of permissions that users
have for some given file.

Depending on what the user wants to do to the file, the file system
needs to check *which* kind of way it wants to access it, e.g. *read*,
*write* or *execute* it. Then, it must check has the rights to perform
said action.

This is represented via the *access control matrix*, that lists what
users have what access to what files.

|         | `/home/hiroshi` | `/home/boris` |
|:-------:|:---------------:|:-------------:|
| Hiroshi |        rw       |       -       |
|  Boris  |        r        |       rw      |
|   Root  |        rw       |       rw      |

*Access control matrices* are stored as *lists*, which are easier to
manage, but grow in size depending on the number of users, or collection
of users (*groups*).

UNIX inodes {#unix-inodes}
-----------

Stands for index node. An inode contains a file’s metadata and the
location of it’s first blocks on disk. An **indirect block** is a block
that itself contains pointers to further blocks; With this an inode can
represent larger files. Similarly a **double indirect** block contains
pointers to indirect blocks that then poing to data blocks.

So for a filesystem with 512B blocks, and inodes with 12 blocks, 1
indirect and one double indirect block, the maximum filesize an inode
can represent is
12 × 512*B* + 512 × 512*B* + 512<sup>2</sup> × 512*B* = 128.3*M**i**B*

Organising Blocks {#organising-blocks}
-----------------

A file on a disk is stored as a series of *linked blocks*.
