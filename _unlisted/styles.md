---
title: Style Expo
layout: clear
---

<div class="sheet padder" markdown="1">
### Kramdown

We're rendering with Jekyll's *Kramdown* engine, full docs [here](http://kramdown.gettalong.org/syntax.html)

</div>


# YAML Front Matter

    ---
    title: Post Title
    layout: {basic, default, clear, post}
    columnar: {false:default, true}
    author: JR Hacker
    author_avatar: http://s.gravatar.com/avatar/8c54ddeaeca4f852c1d522c83780ced1?s=160
    author_url: http://gravatar.com
    date: 1970-01-01T00:00:00
    excerpt_only: {false:default, true}
    excerpt_separator: <!--more--> {default: none}
    wide: {false:default, true}
    ---

Layouts are successively more styled, with basic giving an empty body, default giving 
just header and navigation and the post layout giving tile, authorship and hero if supplied,
which is best for most posts. The posts layout will also be used in the posts feed. Clear gives
the same styling and `<article>` as post, withouyt the navigation bar or header.

`excerpt_only` will suppress rendering of any HTML and truncate the post to an excerpt in the 
posts stream page; This may be useful in conjunction with the `basic` layout. Similarly, 
`wide` gives the post a wider container - this needs to be used in conjunction with the 
`post` layout, otherwise it'll only affect how wide the post's excerpt is in the posts stream.

The `excerpt_separator` isn't mandatory, as Jekyll will assign the first content block
in the file to the excerpt by default.

The attributes `columnar`, `author`, `author_avatar`, `author_url`, `excerpt_only` and `date` 
are optional. The authorial attributes change the content of the chip at the top of the page. The 
default for columnar and excerpt_only are `false`. The columnar layout uses a variable number of 
CSS columns up to 3, and is best suitied to continuous prose only. Columns can 
be accessed through the `.columnar` CSS class also:

<figure class="sheet">
    <p class="columnar padder smaller">
    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque dignissim arcu mauris, sed 
    tincidunt nisi egestas sed. Nullam et lectus consectetur, pretium metus et, dictum mauris. 
    Donec aliquam elit augue, quis egestas elit egestas sed. Proin auctor quam sed rhoncus 
    ornare. Nulla ante purus, vulputate sit amet laoreet ac, commodo at sem. Sed bibendum 
    sem mauris, eu condimentum ligula faucibus sed. Quisque dictum sodales dolor a tristique. 
    Nulla dignissim nibh mauris, eget tempus elit mattis id. Proin ut dolor justo.
    </p>
    <figcaption>
        Shows CSS columns on a paragraph. Note the number of columns will change responsively 
        with screen size.
    </figcaption>
</figure>

The class `.colspan` will set an element's `column-span` to `all`, effectively turning off columns
for it. Headers won't span columns by default, so to prevent a reader having to scroll back up a 
mile, use a `<hr>` or add `{: .collspan }` to a heading.

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

Headings have relative (`em` based) padding and absolute (`rem`) margin-tops, to add negative space.

The `subhead` class is provided to style subheadings, using the Kramdown extended markdown syntax like so:

    # Main Header
    ## Subheading, strapline, whatever.
    {: .subhead}
    
<figure class="sheet padder">
    <h1>Main Header</h1>
    <h2 class="subhead">Subheading, strapline, whatever.</h2>
</figure>

The `subhead` font size is fixed, so the choice of which heading tag to use should be the successive number to comply with HTML's semantic specs. Subhead's font size is larger than h4, h5 and h6.

<br>
<br>
<br>
<br>

## Alignment

The classes `.right` and `.center` change from the default alignment to the left.

> Blockquotes will behave differently with `.right`, displaying a border on the right instead of left.
{:.right}

> This gives a more conversational quotation style.

This is centered text.
{:.center}

## Fonts

Currently the fonts *Montserrat*, *Crimson Text*, *Pacifico*, *Yeseva One*, *FontAwesome* Icons and *Source Code Pro* are provided. A Helvetica based font stack for small uses (e.g. chips) is also provided.

    Paragraph in Crimson Text
    {: .serif}
    
    Paragraph in Montserrat
    {: .sans-serif}
    
    Paragraph in Pacifico
    {: .script}
    
    Paragraph in Yeseva One
    {: .fancy}
    
    Paragraph in Source Code Pro
    {: .tt}
    
    Paragraph in small font
    {: .small-font}

<figure class="sheet padder" id="font-demo">
    <style scoped>
        #font-demo { font-size: 1.2em; }
        #font-demo p {
            color: #000;
        }
    </style>
    <p class="serif">Paragraph in Crimson Text</p>
    <p class="sans-serif">Paragraph in Montserrat</p>
    <p class="script">Paragraph in Pacifico</p>
    <p class="fancy">Paragraph in Yeseva One</p>
    <p class="tt">Paragraph in Source Code Pro</p>
    <p class="small-font halfx">Paragraph in small font</p>
</figure>

<figure class="sheet">
    <style scoped>
        @media(min-width: 600px){
            #font-demo-design { 
                font-size: 1.5em;
            }
            #font-demo-2 .demo-head {
                margin: 0 1em;
            }
        }
        @media(min-width: 1600px){
            #font-demo-design { 
                font-size: 2em;
            }
            #font-demo-2 .demo-head {
                margin: 0 2em;
            }
        }
        #font-demo-design {
            padding: 1em;
        }
        #font-demo-2 .demo-quote {
            display: block;
            font-size: 2em;
            height: 0.65em;
        }
        #font-demo-2 .demo-head {
            padding: 0 1em;
            font-size: 1.5em;
            padding-bottom: 0.2em;
            margin-bottom: 0.5em;
            border-bottom: 0.07em solid #000;
        }
        #font-demo-3 {
            font-size: 0.8em;
            line-height: 1.5em;
        }
        #font-demo-4 {
            font-size: 0.6em;
            letter-spacing: 1em;
            font-weight: bold;
            line-height: 3em;
        }
    </style>
    <div id="font-demo-design">
        <div class="center" id="font-demo-2">
            <div class="fancy demo-head">
                <span class="demo-quote">&ldquo;</span>
                Lorem Ipsum Dolor sit Amet
                <span class="demo-quote">&rdquo;</span>
            </div>
        </div>
        <div class="center" id="font-demo-3">
            <span class="script">
            Vivamus porttitor metus
            </span>
        </div>
        <div class="center sans-serif" id="font-demo-4">
            &nbsp;&middot; LTD &middot;
        </div>
    </div>
    <figcaption>
        Demonstration of a mixed-face design
    </figcaption>
</figure>

<br>
<br>
<br>
<br>

### Bold
For emphasizing a snippet of text with a heavier font-weight.

The following snippet of text is **rendered as bold text**.

    **this is bold text in Markdown**

Will appear as:

**this is as bold text in Markdown**

The class `.strong` is also available.

### Italics
For emphasizing a snippet of text with italics.

The following snippet of text is _rendered as italicized text_.

    _rendered as italicized text_

Appears as:

_rendered as italicized text_

The class `.em` is also available.


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


### Size

A bunch of `em` based scaling classes exist, that'll relatively (with cascading) scale
an entity they're applied to:

~~~
.halfx   { font-size: 0.5em; }
.smaller { font-size: 0.8em; }
.bigger  { font-size: 1.5em; }
.twox    { font-size: 2em;   }
.threex  { font-size: 3em;   }
.fourx   { font-size: 4em;   }
.fivex   { font-size: 5em;   }
~~~

<figure id="scaleclassdemo" class="sheet padder" markdown="1">
<style scoped>
    #scaleclassdemo p {
        margin: 0;
        text-align: center;
    }
</style>

Halfx
{: .halfx}

Smaller
{: .smaller}

*(Normal)*

Bigger
{: .bigger}

Two &times;
{: .twox}

Three &times;
{: .threex}

Four &times;
{: .fourx}

Five &times;
{: .fivex}
</figure>

<br>
<br>
<br>
<br>



## Stylistic Elements

Kramdown allows CSS classes and IDs to be applied to Markdown objects with the postfix notation

    {: .some_class}
    {: #some_id}

For articles (requires the `post` layout in the YAML Front Matter) a bunch of elements have styles.
Figures are particularly useful, though need to be plain HTML unless you turn on markdown:

    <figure class="..." markdown="1">
        ...
        <figcaption>
        Some Caption
        </figcaption>
    </figure>

The `<figcaption>` is optional, and are numbered automatically with some CSS magic. 
The `figure` itself has minimal styling to keep it flexible. Many of the below
classes are particularly effective on `figure`s:

### Super Simple Grid System

Uses table layouts to develop a simple grid system without murdering semantics - though CSS columns
(`columnar` class) will better serve responsive columns in a prose-like context.

    <div class="row">
        <div class="col">
            ...
        </div>
        ...
    </div>
    
The row has the optional `.sep` and `.padd` classes that add a border between columns and padding to the 
columns. The columns below use both `sep` and `padd`. Grids in `<article>`s have a small padding applied 
to them too, which isn't the case elsewhere. Sep borders responively switch edge from the sides on large 
viewports to the top on smaller ones.

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

card
: Material Design card, with hoverable drop shadow.

card-head
: Header within a `card` element

hoverable
: Extends `sheet` with a drop shadow that grows on hover.

redge, ledge
: Floats off to the right or left edge. Won't float on small displays, responsively pulls itself further out of the content box.

halfx, smaller, bigger, twox, threex, fourx, fivex
: Apply em scales on an element, smaller and bigger are respectively `0.8em` and `1.5em`

muted
: Sets the opacity to about 75%

feature
: Bumps the font size, spans all columns and adds padding. Good for beginning an article.

mid
: Similar to feature, italicises and aligns centre as well.

mark
: Does the same as `<mark></mark>` and highlights text.

noir
: Same as `mark` but with white on black colouring, as opposed to theme.

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

right
: Sets text alignment to the right

center
: Sets central text alignment

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
There's the bolder and darker <mark class="noir">noir mark class also</mark> for super standy-outness.

Muted looks like this:

Aenean dictum felis eget risus interdum dignissim. Etiam non nisi et orci tempus suscipit et eget diam. Cras turpis nisl, consectetur condimentum arcu sed, fermentum elementum lacus. Morbi in nunc quis felis viverra iaculis.
{: .muted}

Muted used in conjuntion with `smaller`:

Quisque condimentum eu quam sit amet cursus. In eget purus at sapien vehicula malesuada. Ut elementum tempus erat, eget accumsan mi tristique a.
{: .muted .smaller}

This paragraph is apparently important, implied by the larger font size from the `feature` class.
{: .feature}


The `feature` class can be applied to most elements, with special styles being provided for blockquotes, adding a large quotation mark.

> Praesent odio felis, consectetur consequat vulputate ut, facilisis nec erat. Vestibulum sit amet quam pulvinar, lacinia nunc vitae, scelerisque nulla. Aliquam venenatis dui et imperdiet suscipit.
{: .feature}

Similarly, the `mid` class can be a nice vignette mid prose
{: .mid}

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
        Chips can also have anchors
        <a href="#"><i class="fa fa-share"></i></a>
        <a href="#"><i class="fa fa-close"></i></a>
    </div>

<div class="chip">
    <img src="https://octodex.github.com/images/nyantocat.gif">
    Nyantocat
</div>

<div class="chip">
    The image is optional
</div>

<div class="chip">
    <img src="https://octodex.github.com/images/daftpunktocat-guy.gif">
    <img src="https://octodex.github.com/images/daftpunktocat-thomas.gif">
    More than one Image
</div>

<div class="chip">
    Chips can also have buttons
    <a href="#"><i class="fa fa-share"></i></a>
    <a href="#"><i class="fa fa-close"></i></a>
</div>

Similarly, buttons (Use `$theme_colour` by default)

    <a class="btn">
        I do nothing.
    </a>
    <a class="btn complement">
        I do nothing.
    </a>
    <a class="btn danger">
        I do nothing.
    </a>
    <a class="btn success">
        I do nothing.
    </a>

<div>
    <a class="btn">
        I do nothing.
    </a>
    <a class="btn complement">
        I do nothing.
    </a>
    <a class="btn danger">
        I do nothing.
    </a>
    <a class="btn success">
        I do nothing.
    </a>
</div>

<div class="row">
    <div class="col">
        <div class="card">
            <a href="#">
                <img src="https://octodex.github.com/images/privateinvestocat.jpg"
                    class="img-responsive">
            </a>
            <div class="center padder">
                <strong>Material Design Card</strong>
            </div>
        </div>
    </div>
    <div class="col"></div>
</div>

<div class="clearfix">&nbsp;</div>

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
          1. Maecenas dignissim magna vitae ipsum convallis mollis.
          2. Phasellus eu neque nulla. Quisque volutpat at purus nec pulvinar.
       3. Nulla volutpat aliquam velit
    3. Faucibus porta lacus fringilla vel
    4. Aenean sit amet erat nunc
    5. Eget porttitor lorem

Again becomes:

1. Lorem ipsum dolor sit amet
2. Consectetur adipiscing elit
   1. Integer molestie lorem at massa
   2. Facilisis in pretium nisl aliquet
      1. Maecenas dignissim magna vitae ipsum convallis mollis.
      2. Phasellus eu neque nulla. Quisque volutpat at purus nec pulvinar.
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
    [^1]: Footnotes are handy

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
rule, though it isn't particularly general purpose (*note* that it's also used in the post stream,
so could be confused for a post delimiter):

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

Similarly, a `.feature` blockquote:

    > Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer posuere erat a ante.
    {: .feature}

> Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer posuere erat a ante.
{: .feature}

And a `.mid` blockquote:

    > Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer posuere erat a ante.
    {: .mid}

> Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer posuere erat a ante.
{: .mid}

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
left of the keyboard next to `z` (On a Mac), and top left of the keyboard British Layout.

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

For example:

<pre><code>&#123;% highlight haskell %&#125;
fizz :: Int -> String
fizz n | n `mod` 15 == 0  = "FizzBuzz"
       | n `mod` 3  == 0  = "Fizz"
       | n `mod` 5  == 0  = "Buzz"
       | otherwise        = show n
 
main :: IO()
main = mapM_ putStrLn $ map fizz [1..100]
&#123;% endhighlight %%&#125;</code></pre>

Becomes

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

These are all way too big so images tend to work better with some direct HTML, or with classes
as laid out further up applied to them.



