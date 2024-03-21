# Requirment and How-to's

This is a simple template of digital garden made with Soupault.
For further customization, you should check `soupault.toml`.

To run this garden you need these softwares :

- Soupault, to compile this stuff.
- Cmark, to render markdown thing.
    - Ascidoctor, if you prefer adoc rather md.
- Browser.
- Python3 (for simple server, `make serve`)
- Text editor.
- GNU make, for running `make` command.

Put your content in `site` folder, literally everything:
md, html, css, png or webm. It will copy it to build folder
when building your site.

For some reason if the markup is too big, I put some widget HTML
into file in templates. 

## How to run

Clone or download template code from [multidecay/soupault-digital-garden](https://github.com/multidecay/soupault-digital-garden), then extract it if you download as zip.


Run command (written in `monospace`) below in terminal in same working directory with the template:

- Build : `make build`

- Serve: `make serve`, then open your browser at address shown.

Little tips if your first with soupault, it works as selector and mutator
 HTML document rather subtitute symbol inside templates. It like CRUD
 but for HTML document.


<seed-meta
    field="soupault"
    type="documentation"
    tags="soupault,digital garden"
    audience="you"
 />