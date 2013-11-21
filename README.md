# grunt-userev <a href='https://github.com/salsita'><img align='right' title='Salsita' src='https://www.google.com/a/cpanel/salsitasoft.com/images/logo.gif?alpha=1' _src='https://1.gravatar.com/avatar/d413290a5fe1385efcf5a344d4a0b588?s=50' /></a>

> Update references to assets versioned with [grunt-filerev](https://github.com/yeoman/grunt-filerev). Leaner and faster than [grunt-usemin](https://github.com/yeoman/grunt-usemin), and able to update already versioned references.

<a href='https://npmjs.org/package/grunt-userev'><img align='right' alt='npm' title='npm info' src='https://nodei.co/npm/grunt-userev.png?compact=true' /></a>&nbsp;[![build](https://secure.travis-ci.org/salsita/grunt-userev.png?branch=master)](https://travis-ci.org/salsita/grunt-userev) [![dependencies](https://david-dm.org/salsita/grunt-userev.png)](https://david-dm.org/salsita/grunt-userev) [![dev-dependencies](https://david-dm.org/salsita/grunt-userev/dev-status.png)](https://david-dm.org/salsita/grunt-userev#info=devDependencies)



## Getting Started

This plugin requires [Grunt](http://gruntjs.com).

If you haven't used Grunt before, be sure to check out the [Getting Started](http://gruntjs.com/getting-started) guide, as it explains how to create a [Gruntfile](http://gruntjs.com/sample-gruntfile) as well as install and use Grunt plugins. Once you're familiar with that process, you may install this plugin with this command:

```shell
npm install grunt-userev --save-dev
```

Once the plugin has been installed, it may be enabled inside your Gruntfile with this line of JavaScript:

```js
grunt.loadNpmTasks('grunt-userev');
```


## The "userev" task

### Overview

In your project's Gruntfile, configure `userev` to update references to assets versioned by [grunt-filerev](https://github.com/yeoman/grunt-filerev). It will automatically use [`grunt.filerev.summary`](https://github.com/yeoman/grunt-filerev#summary).


```js
grunt.initConfig({
  filerev: {
    options: {
      encoding: 'utf8',
      algorithm: 'md5',
      length: 8
    },
    sourcemaps: {        // Rename sourcemaps.
      src: ['build/css/*.map.css', 'build/js/*.map.js'],
    },
    assets: {            // Rename minified js/css.
      src: ['build/css/*.css', 'build/js/*.js', '!build/css/*.map.css', '!build/js/*.map.js'],
    },
  },

  userev: {
    options: {
      hash: /(\.[a-f0-9]{8})\.[a-z]+$/,
    },
    assets: {            // Link to sourcemaps in minified js/css.
      src: ['build/css/*.css', 'build/js/*.js', '!build/css/*.map.css', '!build/js/*.map.js'],
      options: {
        patterns: {
          'Linking versioned source maps': /sourceMappingURL=([a-z0-9.]*\.map)/,
        },
      },
    },
    index: {             // Link to minified js/css in index html.
      src: 'build/index.html',
      options: {
        patterns: {
          'Linking versioned assets': /(css\/[a-z0-9.]*\.css)/,
        },
      },
    },
  },
});

grunt.registerTask( 'rev', [
  'filerev:sourcemaps',  // Rename sourcemaps.
  'userev:assets',       // Link to sourcemaps in minified js/css.
  'filerev:assets',      // Rename minified js/css.
  'userev:index',        // Link to minified js/css in index html.
]);

```


### Options

#### patterns
Type: `Object {Key: RegExp}`
Default: none

Reference RegExp patterns are matched in source files. The first matched group is checked if it matches ending of any key in [`grunt.filerev.summary`](https://github.com/yeoman/grunt-filerev#summary). The key names are used to log processing of matched patterns.

#### hash
Type: `RegExp`
Default: none

If specified, the RegExp pattern is matched against matched references and the first matched group (the hash in filename) is removed. This allows to update the references in source files multiple times without need to regenerate them.


## Contributing

Welcome to the project. Choose a way that suits you. You'll need a [GitHub account](https://github.com/signup/free).

### Submit a bug, or feature request

* Search [existing issues](https://github.com/salsita/grunt-userev/issues) to avoid duplicities.
* [Submit an issue](https://github.com/salsita/grunt-userev/issues/new) with label `bug`, or `enhancement`.
* For a bug, include any relevant information, e.g. task output, installed OS/Node.js/Grunt/grunt-userev versions, and steps to reproduce.

### Submit a pull request

* [Fork the repository](https://github.com/salsita/grunt-userev/fork) ([help](https://help.github.com/articles/fork-a-repo)) and checkout new branch with `<type>-` prefix in name, where type may be feature, fix, docs, or chore.
* [Use](https://github.com/salsita/grunt-userev/blob/master/.jshintrc) the [popular JavaScript style convention](http://sideeffect.kr/popularconvention#javascript) and [winning JavaScript style](http://seravo.fi/2013/javascript-the-winning-style) with exception of 100 characters per line. In short, use 2 spaces indent, camelCase names, trailing comma, single quotes, semicolons, sparse spacing, and no trailing whitespace.
* For bugfix, write a test that exposes the bug and fails without the fix. Submit the test alongside.
* For a new feature, add tests that cover the feature.
* Lint and test your code with `grunt`, or `grunt watch` to watch sources and run tests on any change.
* Use commit messages that follow [Karma/Angular commit message convention](https://github.com/karma-runner/karma/blob/master/docs/dev/04-git-commit-msg.md) ([docs](https://docs.google.com/document/d/1QrDFcIiPjSLDn3EL15IJygNPiHORgU1_OOAqWjiDU5Y/edit#)). In short, use `<type>(<scope>): <subject>` header in imperative present tense, message body describing motivation/differences, and footer referencing related issues and breaking changes.
* [Create a pull request](https://github.com/salsita/grunt-userev/compare) to [grunt-userev](https://github.com/salsita/grunt-userev) [master](https://github.com/salsita/grunt-userev/branches) branch ([help](https://help.github.com/articles/creating-a-pull-request)).


## Roadmap

- Add tests


<a name="changelog"></a>
## Changelog

<a name="v0.0.2"></a>
### v0.0.2 (2013-11-21)


#### Features

* **changelog:**
  * add changelog to README ([0c70f8d2](https://github.com/salsita/grunt-userev/commit/0c70f8d2569534215575dfef037936018d26a70e))
  * add changelog ([3617bb0a](https://github.com/salsita/grunt-userev/commit/3617bb0af7bb733857cc3fdf391bb20a92631df7))

<a name="v0.0.1"></a>
### v0.0.1 (2013-11-21)


#### Features

* **task:** create grunt userev task ([d9f515c4](https://github.com/salsita/grunt-userev/commit/d9f515c4b74c980231f006dfdaaf4727ccd42aae))


## License

Copyright 2013 [Salsita Software](http://salsitasoft.com). Licensed under the [MIT License](http://en.wikipedia.org/wiki/MIT_License).
