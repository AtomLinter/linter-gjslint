linter-gjslint
=========================

This linter plugin for [Linter](https://github.com/AtomLinter/Linter) provides an interface to [gjslint](https://developers.google.com/closure/utilities/). It will be used with files that have the “JavaScript” syntax.

## Installation
Linter package must be installed in order to use this plugin. If Linter is not installed, please follow the instructions [here](https://github.com/AtomLinter/Linter).

### gjslint installation
Before using this plugin, you must ensure that `gjslint` is installed on your system. To install `gjslint`, read [this](https://developers.google.com/closure/utilities/docs/linter_howto).

### Plugin installation
```
$ apm install linter-gjslint
```

## Settings
You can configure linter-gjslint by editing ~/.atom/config.cson (choose Open Your Config in Atom menu):
```
'linter-gjslint':
  'gjslintExecutablePath': '' #gjslint path. run 'which gjslint' to find the path
  'gjslintIgnoreList': [] #gjslint ignore codes from http://goo.gl/OhYHYl
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


## Donation
[![Share the love!](https://chewbacco-stuff.s3.amazonaws.com/donate.png)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=KXUYS4ARNHCN8)
