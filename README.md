# linter-gjslint

This linter plugin for [Linter](https://github.com/AtomLinter/Linter) provides
an interface to [gjslint](https://developers.google.com/closure/utilities/). It
will be used with files that have the "JavaScript" syntax.

## Installation

### gjslint installation

Before using this plugin, you must ensure that `gjslint` is installed on your
system. To install `gjslint`, read [this](https://developers.google.com/closure/utilities/docs/linter_howto).

### Plugin installation

Run `apm install linter-gjslint` or search for `linter-gjslint` in Atom package
manager.

## Settings

You can configure linter-gjslint by accessing the options in File > Settings >
Packages.

Or by editing `~/.atom/config.cson` (choose Open Your Config in Atom menu):

```coffeescript
"linter-gjslint":
  executablePath: "" #gjslint path. run 'which gjslint' to find the path
  gjslintIgnoreList: [] # gjslint ignore codes from https://goo.gl/VAdwHE
  flags: [
    "--flagfile=.gjslintrc"
    "--strict"
  ]
]
```
