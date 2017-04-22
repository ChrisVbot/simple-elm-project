# Install

Install Elm by following the directions [here](https://guide.elm-lang.org/install.html), then in the command line:

```bash
git clone https://github.com/ChrisVbot/simple-elm-project.git
cd simple-elm-project
elm-reactor
```

## Other options

```bash
elm-make Filename.elm --output=main.html
```

This generates your HTML file, but with a pretty gnarly inline script, so you may want to compile to a JS file instead like so:

```bash
elm-make Filename.elm --output=main.js
```

If using second option, you'll want to put something like this in your HTML file, followed by a script tag pointing to the JS file:

```html
<div id="main"></div>
```

Then in another set of script tags, you'd put something like:

```javascript
var node = document.getElementById('main');
var app = Elm.Main.embed(node);
// Note: if your Elm module is named "MyThing.Root" you
// would call "Elm.MyThing.Root.embed(node)" instead.
```
**Note**: This must go after your initial script tag linking to main.js (or whatever you called it).