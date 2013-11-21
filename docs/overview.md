
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
