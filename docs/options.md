
### Options

#### patterns
Type: `Object {Key: RegExp}`
Default: none

Reference RegExp patterns are matched in source files. The first matched group is checked if it matches ending of any key in [`grunt.filerev.summary`](https://github.com/yeoman/grunt-filerev#summary). The key names are used to log processing of matched patterns.

#### hash
Type: `RegExp`
Default: none

If specified, the RegExp pattern is matched against matched references and the first matched group (the hash in filename) is removed. This allows to update the references in source files multiple times without need to regenerate them.
