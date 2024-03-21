# Soupault Digital Garden

Status: WIP.

Template for making digital garden using soupault. 

Digital garden quite intersection of blog and wikis/notebooks/zettelkasten, if you like scattered notes then this appreach may fit with you. 

More about digital garden you can [read here](https://maggieappleton.com/garden-history).

## Concept

**Seed** in digital garden could you can imagine it as blog post or wikis. It have field (i.e category), tags, type (i.e idea, thougts, summary) and audience (i.e developer, freethinker) field to 
connecting each other.

To create a seed, you just create a `markdown` or `asciidoc` (untested) inside `site` folder. Then add `seed-meta` tags to
set microformat of your seed like this:

```html
<seed-meta
    field="soupault"
    type="documentation"
    date="15 Mar 2024"
    tags="soupault,digital garden"
    audience="you"
 />
```

## How to run this

I have simplify with Makefile command (you could read it for manual command).

- Build the garden : `make build`

- Test the garden : `make serve`

[Required Software](site/readme.md)

### License

[UNLICENSE](./LICENSE)

It's fine to delete the license and put your own.