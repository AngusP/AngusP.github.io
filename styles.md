---
title: Style Expo
layout: post
---

# YAML Front Matter

    ---
    title: Post Title
    layout: {basic, default, post}
    columnar: {true, false}
    author: JR Hacker
    author_avatar: http://s.gravatar.com/avatar/8c54ddeaeca4f852c1d522c83780ced1?s=160
    author_url: http://gravatar.com
    date: 1970-01-01T00:00:00
    ---

Layouts are successively more styled, with basic giving an empty body, default giving 
just header and navigation and the post layout which is best for Markdown files.

The attributes `columnar`, `author`, `author_avatar`, `author_url` and `date` are optional. The 
authorial attributes change the content of the chip at the top of the page. The 
default for columnar is `false`. The columnar layout uses a variable number of 
CSS columns up to 3, and is best suitied to continuous prose only. Columns can 
be accessed through the `.columnar` CSS class also:

<figure class="sheet">
    <p class="columnar padder smaller">
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque dignissim arcu mauris, sed tincidunt nisi egestas sed. Nullam et lectus consectetur, pretium metus et, dictum mauris. Donec aliquam elit augue, quis egestas elit egestas sed. Proin auctor quam sed rhoncus ornare. Nulla ante purus, vulputate sit amet laoreet ac, commodo at sem. Sed bibendum sem mauris, eu condimentum ligula faucibus sed. Quisque dictum sodales dolor a tristique. Nulla dignissim nibh mauris, eget tempus elit mattis id. Proin ut dolor justo.
    </p>
    <figcaption>
        Shows CSS columns on a paragraph. Note the number of columns will change responsively with screen size.
    </figcaption>
</figure>

<br>
<br>
<br>
<br>

# Typography 

## Headings

Two syntaxes exist for markdown headings:

    Heading 1
    =========
    
    Heading 2
    ---------

Which shows on the page as:

<figure class="sheet padder">
    <h1>Heading 1</h1>
    <h2>Heading 2</h2>
</figure>

They can also follow the alternate syntax: 
Headings from `h1` through `h6` can be written with a `#` for each level of heading:

    # h1 Heading
    ## h2 Heading
    ### h3 Heading
    #### h4 Heading
    ##### h5 Heading
    ###### h6 Heading

<figure class="sheet padder">
    <h1>h1 Heading</h1>
    <h2>h2 Heading</h2>
    <h3>h3 Heading</h3>
    <h4>h4 Heading</h4>
    <h5>h5 Heading</h5>
    <h6>h6 Heading</h6>
</figure>

The `subhead` class is provided to style subheadings, using the Kramdown extended markdown syntax like so:

    # Main Header
    ## Subheading, strapline, whatever.
    {: .subhead}
    
<figure class="sheet padder">
    <h1>Main Header</h1>
    <h2 class="subhead">Subheading, strapline, whatever.</h2>
</figure>

The `subhead` font size is fixed, so the choice of which heading tag to use should be the successive number to comply with HTML's semantics. Also the Subhead will be larger than h4, h5 and h6.

<br>
<br>
<br>
<br>


## Stylistic Elements

Kramdown allows CSS classes and IDs to be applied to Markdown objects with the postfix notation

    {: .some_class}
    {: #some_id}

For articles (requires the `post` layout in the YAML Front Matter) a bunch of elements have styles.
Figures are particularly useful, though need to be plain HTML as there is no Markdown Syntax for them.

    <figure class="...">
        ...
        <figcaption>
        Some Caption
        </figcaption>
    </figure>

The `<figcaption>` is optional, and are numbered automatically with some CSS magic. 
The `figure` itself has minimal styling to keep it flexible. Many of the below
classes are particularly effective on `figure`s:

### Super Simple Grid System

Uses table layouts to develop a simple grid system without murdering semantics.

    <div class="row">
        <div class="col">
            ...
        </div>
        ...
    </div>
    
The row has the optional `.sep` and `.padd` classes that add a border between columns and padding to the columns. The columns below use both `sep` and `padd`. Grids in `<article>`s have a small padding applied to them too, which isn't the case elsewhere. Sep borders responively switch edge.

<div class="row sep padd">
    <p class="col">
        Quisque ac tristique nisi. Fusce eget augue vel dui pharetra blandit. Proin eu ex arcu. Nulla facilisi. In tempus vel enim quis suscipit. Proin eleifend fringilla lacus id vehicula.
    </p>
    <p class="col">
        Etiam hendrerit dolor accumsan, fringilla augue id, molestie arcu. Duis cursus felis eget ante gravida hendrerit. Vivamus tempus risus ut sapien elementum interdum.
    </p>
    <p class="col">
        Maecenas eget scelerisque dui. Etiam lobortis, nisi eget molestie rutrum, eros magna scelerisque magna, in commodo eros sem mollis urna. Morbi imperdiet dui vel nulla maximus.
    </p>
</div>
<br>

### Classes

padder
: Applies a fair amount of padding to the object it is applied to; Best used on a `<div>` within the figure.

vspace
: Similar to `padder`, only applies padding vertically and more of it.

sheet
: Adds a Material Design drop shadow to the element.

hoverable
: Extends `sheet` with a drop shadow that grows on hover.

redge, ledge
: Floats off to the right or left edge. Won't float on small displays, responsively pulls itself further out of the content box.

halfx, smaller, bigger, twox, threex, fourx, fivex
: Apply em scales on an element, smaller and bigger are respectively `0.8em` and `1.5em

muted
: Sets the opacity to about 75%

feature
: Bumps the font size, spans all columns and adds padding. Good for beginning an article.

mark
: Does the same as `<mark></mark> and higlights text.

bg-theme, bg-theme-complement
: Sets background to the theme colour.

bg-d-grey, bg-l-grey
: Various shades of grey background.

b-top-grey
: Applies a grey border to the top of the element.

columnar
: Applies CSS columns to the element, responsively

truncate
: Sets overflow hidden, white-space no wrap and adds a trailing hellipsis.

<figure class="ledge" style="max-width: 400px;">
    <blockquote>
    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque semper est sit amet velit accumsan, vel efficitur elit suscipit.
    <cite>Lorem Ipsum</cite>
    </blockquote>
    <figcaption>
    Demonstrating ledge with a blockquote inside a figure.
    </figcaption>
</figure>

<figure class="redge sheet hoverable" style="max-width: 400px;">
    <img src="https://octodex.github.com/images/privateinvestocat.jpg"
    alt="GitHub Octodex num 122 Private Investigocat"
    class="img-responsive" >
    <figcaption>
        A figure with an image, and the sheet and hoverable classes.
    </figcaption>
</figure>

Marking and <mark>highlighting like this is Medium or something</mark> `<mark>` and `.mark` behave same.

Muted looks like this:

Aenean dictum felis eget risus interdum dignissim. Etiam non nisi et orci tempus suscipit et eget diam. Cras turpis nisl, consectetur condimentum arcu sed, fermentum elementum lacus. Morbi in nunc quis felis viverra iaculis.
{: .muted}

Muted used in conjuntion with `smaller` is often effective

Quisque condimentum eu quam sit amet cursus. In eget purus at sapien vehicula malesuada. Ut elementum tempus erat, eget accumsan mi tristique a.
{: .muted .smaller}

This paragraph is apparently important, implied by the larger font size from the `feature` class.
{: .feature}

<div class="bg-theme padder">
    <span class="twox">JumboTron</span>
    <br>
    This looks a fair bit like Bootstrap's Jumbotron, using bg-theme and padder. 
    The text above has twox applied to it. The white font colour doesn't cascade too well.
</div>

<div class="bg-theme-complement padder">
    For comparison, using the theme complement background
</div>

They're not really a class, but **chips** from Material Design are included:

    <div class="chip">
        <img src="...">
        Chip Content
    </div>

<div class="chip">
    <img src="https://octodex.github.com/images/nyantocat.gif">
    Nyantocat
</div>

<div class="chip">
    The image is optional
</div>

Similarly, buttons

    <a class="btn">
        I do nothing.
    </a>
    <a class="btn danger">
        I do nothing.
    </a>

<div>
    <a class="btn">
        I do nothing.
    </a>
    <a class="btn danger">
        I do nothing.
    </a>
</div>

<div class="clearfix">&nbsp;</div>

<br>
<br>
<br>
<br>

## Fonts

Currently the fonts *Montserrat*, *PT Serif*, *Pacifico*, *FontAwesome* Icons and *Source Code Pro* are provided. A Helvetica based font stack for small uses (e.g. chips) is also provided.

    Paragraph in PT Serif
    {: .serif}
    
    Paragraph in Montserrat
    {: .sans-serif}
    
    Paragraph in Pacifico
    {: .script}
    
    Paragraph in Source Code Pro
    {: .tt}
    
    Paragraph in small font
    {: .small-font}

<figure class="sheet padder">
    <p class="serif">Paragraph in PT Serif</p>
    <p class="sans-serif">Paragraph in Montserrat</p>
    <p class="script">Paragraph in Pacifico</p>
    <p class="tt">Paragraph in Source Code Pro</p>
    <p class="small-font">Paragraph in small font</p>
</figure>

### Bold
For emphasizing a snippet of text with a heavier font-weight.

The following snippet of text is **rendered as bold text**.

    **this is bold text in Markdown**

Will appear as:

**this is as bold text in Markdown**


### Italics
For emphasizing a snippet of text with italics.

The following snippet of text is _rendered as italicized text_.

    _rendered as italicized text_

Appears as:

_rendered as italicized text_


### Caps

The classes `caps` and `small-caps` successively transform everything to upper case, 
and use the small caps variant of a font. Both increase the letter spacing to maintain readability.

<em>Serif:</em>

<div class="larger caps serif">
    Cras suscipit rhoncus nibh, id sodales eros facilisis id.
</div>

<div class="larger small-caps serif">
    Nullam non mi non mauris sodales Accumsan laoreet accumsan velit.
</div>

<em>Sans Serif:</em>

<div class="larger caps sans-serif">
    Cras suscipit rhoncus nibh, id sodales eros facilisis id.
</div>

<div class="larger small-caps sans-serif">
    Nullam non mi non mauris sodales Accumsan laoreet accumsan velit.
</div>

<em>Small Font:</em>

<div class="caps small-font smaller">
    Cras suscipit rhoncus nibh, id sodales eros facilisis id.
</div>

<div class="small-caps small-font smaller">
    Nullam non mi non mauris sodales Accumsan laoreet accumsan velit.
</div>

<br>
<br>
<br>
<br>

# Semantically Ordinal Objects

## Lists

### Unordered

A list of items in which the order of the items does not explicitly matter.

You may use any of the following symbols to denote bullets for each list item:

    * valid bullet
    - valid bullet
    + valid bullet

For example

    + Lorem ipsum dolor sit amet
    + Consectetur adipiscing elit
    + Integer molestie lorem at massa
    + Facilisis in pretium nisl aliquet
    + Nulla volutpat aliquam velit
      - Phasellus iaculis neque
      - Purus sodales ultricies
      - Vestibulum laoreet porttitor sem
      - Ac tristique libero volutpat at
    + Faucibus porta lacus fringilla vel
    + Aenean sit amet erat nunc
    + Eget porttitor lorem

Will get nicely displayed as:

+ Lorem ipsum dolor sit amet
+ Consectetur adipiscing elit
+ Integer molestie lorem at massa
+ Facilisis in pretium nisl aliquet
+ Nulla volutpat aliquam velit
  - Phasellus iaculis neque
  - Purus sodales ultricies
  - Vestibulum laoreet porttitor sem
  - Ac tristique libero volutpat at
+ Faucibus porta lacus fringilla vel
+ Aenean sit amet erat nunc
+ Eget porttitor lorem


### Ordered (Numbered Lists)

A list of items in which the order of items does explicitly matter.
_Be careful_ to ensure that the indentation of nested lists is the same as the indentation
of the text above it

    1. Lorem ipsum dolor sit amet
    2. Consectetur adipiscing elit
       1. Integer molestie lorem at massa
       2. Facilisis in pretium nisl aliquet
       3. Nulla volutpat aliquam velit
    3. Faucibus porta lacus fringilla vel
    4. Aenean sit amet erat nunc
    5. Eget porttitor lorem

Again becomes:

1. Lorem ipsum dolor sit amet
2. Consectetur adipiscing elit
   1. Integer molestie lorem at massa
   2. Facilisis in pretium nisl aliquet
   3. Nulla volutpat aliquam velit
3. Faucibus porta lacus fringilla vel
4. Aenean sit amet erat nunc
5. Eget porttitor lorem

**PROTIP**: If you just use `1.` for each number, the end product will still be a correctly
numbered list. For example:

    1. Lorem ipsum dolor sit amet
    1. Consectetur adipiscing elit
    1. Integer molestie lorem at massa
    1. Facilisis in pretium nisl aliquet
    1. Nulla volutpat aliquam velit
    1. Faucibus porta lacus fringilla vel
    1. Aenean sit amet erat nunc
    1. Eget porttitor lorem

Will get wonderfully fixed for you like this:

1. Lorem ipsum dolor sit amet
2. Consectetur adipiscing elit
3. Integer molestie lorem at massa
4. Facilisis in pretium nisl aliquet
5. Nulla volutpat aliquam velit
6. Faucibus porta lacus fringilla vel
7. Aenean sit amet erat nunc
8. Eget porttitor lorem


### Definition Lists

Useful for repeating data or funnily enough, listing definitions.

    Term
    : Definition of the term
    which can be spread over multiple lines.

    Another Term
    : Another Definintion, and `other` markdown **syntax** *works* in here.

Term
: Definition of the term
which can be spread over multiple lines.

Another Term
: Another Definintion, and `other` markdown **syntax** *works* in here.

<br>
<br>
<br>


## Tables

Tables can be a bit of a formatting nightmare, so use them sparingly. There's a compromise
between the complexity of the Markdown syntax and the features, so there aren't many options here.
Note that the line of `|---|---|---|` etc. is optional and makes the row above a header.

    | First cell | Second cell | Third cell |
    |------------|-------------|------------|
    | First      | Second      | Third      |
    | First      | Second      | Third      |

Will get turned into:

| First cell | Second cell | Third cell |
|------------|-------------|------------|
| First      | Second      | Third      |
| First      | Second      | Third      |

You can also affect the indentation of table columns with some slightly tricky syntax:

    | Tables        | Are           | Cool  |
    | ------------- |:-------------:| -----:|
    | col 3 is      | right-aligned | £1600 |
    | col 2 is      | centered      |   £12 |
    | zebra stripes | are neat      |    £1 |

Adding colons in the place of a `-` will either centre the text in that column or right-align it, based on whether you use `:-----:` or `------:`. The above example looks like this:

| Tables        | Are           | Cool  |
| ------------- |:-------------:| -----:|
| col 3 is      | right-aligned | £1600 |
| col 2 is      | centered      |   £12 |
| zebra stripes | are neat      |    £1 |


<br>
<br>
<br>

## Links

### Basic link

    [Google UK](https://google.co.uk)

Will show up as

[Google UK](https://google.co.uk)

### Linking to stuff on your site

Uses Liquid Templating tags to compile-in the generated URL

<pre>[Awesome Post](&#123;% post_url 2014-10-20-name-of-post %&#125;)</pre>

This is shown as:

[Awesome Post](http://goo.gl)

As long as the `2014-10-20-name-of-post` part matches the filename of the post you're linking
to (notice the lack of a .md extension) this will work. If the post doesn't exist, the Jekyll
compile will fail, **which is bad**.

### Add a title to a link

    [Google UK](https://google.co.uk "Visit Google UK")

Comes out as this: (hover over the link, there should be a tooltip)

[Google UK](https://google.co.uk "Visit Google UK")

### Footnote Links

Instead of placing the URL next to the link like `[Link Name](http://website.com)` you can instead
place an identifying name next to the link, as shown below. This method still supports titles.

    [Google UK][google]
    
    ... You can put anything in here ...
    
    [google]: https://www.google.co.uk "Go to Google UK"

Like so:

[Google UK][google]

[google]: https://www.google.co.uk "Go to Google UK"


### Footnotes

Kramdown adds support for footnotes, which will always be rendered at the bottom of the page.

    Some text[^footnote]
    Some other text[^1]

Some text[^footnote]
Some other text[^1]

Numbering is done programatically and the footnote text can be anywhere in the body of the page:

    [^footnote]: Hell Yeah!

[^footnote]: Hell yeah!
[^1]: Footnotes are handy

<br>
<br>
<br>


## Horizontal Rules

The HTML `<hr>` element is for creating a "thematic break" between paragraph-level elements. 
In Markdown, you can create a `<hr>` with any of the following in your Markdown document:

* `___`: three or more consecutive underscores
* `---`: three or more consecutive dashes
* `***`: three or more consecutive asterisks

Any of these would look like:

___

Additionally the class `.break` is provided for a theme colour helipsis instead of a horizontal
rule, though it isn't particularly general purpose:

    ___
    {: .break}

___
{: .break}


<br>
<br>
<br>

## Block Quotes

For quoting blocks of content from another source within your document.

Add `>` before any text you want to quote. 

    > Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer posuere erat a ante.

Will show up as:

> Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer posuere erat a ante.


Blockquotes can also be nested:

    > This is a paragraph.
    > 
    > > A nested blockquote, i.e. a blockquote inside a blockquote.
    > 
    > ## Headers work
    > 
    > * lists too
    > 
    > and all other block-level elements
    > <cite>Unfortunately, if you need a citation, that's a HTML thing</cite>

Shows on the page as:

> This is a paragraph.
> 
> > A nested blockquote, i.e. a blockquote inside a blockquote.
> 
> ## Headers work
> 
> * lists too
> 
> and all other block-level elements
> <cite>Unfortunately, if you need a citation, that's a HTML thing</cite>

<br>
<br>
<br>

## Monospaced text & Code

### Inline monospace
Wrap inline snippets of code with `` ` ``. That's the funny backtick character in the bottom
left of the keyboard next to `z` (On a Mac).

So this:

    For example, `<section></section>` should be wrapped as "inline".

Becomes this:

For example, `<section></section>` should be wrapped as "inline" and formatted.



### Monospaced blocks.

This preserves the line breaks & indentation of your text, as well as changing the
font to monospace. You'll notice these are heavily used on this page to show syntax.

Adding four spaces to the start of a line, like this:

        // Some comments
        line 1 of code
        line 2 of code
        line 3 of code

Does this:

    // Some comments
    line 1 of code
    line 2 of code
    line 3 of code


### Alternately

Use "fences"  `` ~~~ `` to block in multiple lines of code. 

    ~~~
    This is a monospace block that doesn't need to have 4 spaces in front of it
    ~~~

Comes out of the wash appearing like this:

~~~
This is a monospace block that doesn't need to have 4 spaces in front of it
~~~

Syntax hilighting is available with *Rouge*, and the liquid tags

<pre><code>&#123;% highlight [language] %&#125;
    code goes in here...
&#123;% endhighlight %&#125;</code></pre>

{% highlight haskell %}
fizz :: Int -> String
fizz n | n `mod` 15 == 0  = "FizzBuzz"
       | n `mod` 3  == 0  = "Fizz"
       | n `mod` 5  == 0  = "Buzz"
       | otherwise        = show n
 
main :: IO()
main = mapM_ putStrLn $ map fizz [1..100]
{% endhighlight %}

<br>
<br>
<br> 
<br>


## Images
Images have a similar syntax to links but start with an exclamation point.

    ![Minion](http://octodex.github.com/images/minion.png)

Gets shown as:

![Minion](http://octodex.github.com/images/minion.png)

In the same way as images, you can add alternate text that will show if the image fails to load. 
(Doing this is recommended by the people who invented the Web)

    ![Alt text](http://octodex.github.com/images/stormtroopocat.jpg "The Stormtroopocat")

Again gets shown as:

![Alt text](http://octodex.github.com/images/stormtroopocat.jpg "The Stormtroopocat")

Like links, Images also have a footnote style syntax for adding the URL later on in the document.

    ![Alt text][id]

![Alt text][id]

With a reference later in the document defining the URL location. 
Note that the reference is invisible.

    [id]: http://octodex.github.com/images/dojocat.jpg  "The Dojocat"

[id]: http://octodex.github.com/images/dojocat.jpg  "The Dojocat"

These are all way too big so images tend to work better with some direct HTML.



