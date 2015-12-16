linter-gjslint
=========================

This linter plugin for [Linter](https://github.com/AtomLinter/Linter) provides an interface to [gjslint](https://developers.google.com/closure/utilities/). It will be used with files that have the “JavaScript” syntax.


### gjslint installation
Before using this plugin, you must ensure that `gjslint` is installed on your system. To install `gjslint`, read [this](https://developers.google.com/closure/utilities/docs/linter_howto).

## Installation
Run `amp install linter-gjslint` or search for `linter-gjslint` in Atom package manager.

## Settings
You can configure linter-gjslint by accessing the options in File > Settings > Packages.<br>
Or by editing ~/.atom/config.cson (choose Open Your Config in Atom menu):
```
"linter-gjslint":
   executablePath: "" #gjslint path. run 'which gjslint' to find the path
   gjslintIgnoreList: [
    "110"
  ] # gjslint ignore codes from http://goo.gl/OhYHYl
  "flags": [
    "--flagfile=.gjslintrc"
    "--strict"
  ]
]
```

## Contributing
If you would like to contribute enhancements or fixes, please do the following:

1. Fork the plugin repository.
1. Hack on a separate topic branch created from the latest `master`.
1. Commit and push the topic branch.
1. Make a pull request.
1. welcome to the club

Please note that modifications should follow these coding guidelines:

- Indent is 2 spaces.
- Code should pass coffeelint linter.
- Vertical whitespace helps readability, don’t be afraid to use it.

Thank you for helping out!


## Changelog
See all notable changes in [here](https://github.com/AtomLinter/linter-gjslint/releases).
