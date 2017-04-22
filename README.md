Just some simple examples to learn the basics of Elm. 

[Install Elm here](https://guide.elm-lang.org/install.html), then in the command line, run:

```shell
elm-reactor
```

to use built-in dev server. 
Note: elm-reactor does not seem to work well with README.md. As a temp fix, can delete README.md before starting server or 
just ensure you are in examples directory.

Other options: 

```shell
elm-make Filename.elm --output=main.html
```

That creates a pretty gnarly inline script, so you may want to compile to a JS file instead like so:

```shell
elm-make Filename.elm --output=main.js
```

If using second option, you'll want to put something like this in your HTML file:

```html
<div id="main"></div>
<script src="elm.js"></script>
<script>
    var node = document.getElementById('main');
    var app = Elm.Main.embed(node);
    // Note: if your Elm module is named "MyThing.Root" you
    // would call "Elm.MyThing.Root.embed(node)" instead.
</script>
```

That means you could also just plug some Elm into an existing project to try it out. 