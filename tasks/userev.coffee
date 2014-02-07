path = require('path')
_ = require('lodash')

module.exports = (grunt) ->

  reEscape = (str) ->
    # http://stackoverflow.com/a/18620139/899047
    str.replace /[$-\/?[-^{|}]/g, '\\$&'

  endsWith = (str, suffix) ->
    #http://stackoverflow.com/a/2548133/899047
    str.indexOf(suffix, str.length - suffix.length) isnt -1

  replaceFirstGroup = (str, pattern, replacement) ->
    match = pattern.exec(str)
    if match
      replacement = match[0].replace(match[1] || match[0], replacement)
      str.replace pattern, replacement
    else
      str

  fixPaths = (paths, requiredSep) ->
    re = new RegExp reEscape(path.sep), 'g'

    for own fromPath, toPath of paths
      if fromPath.indexOf "\\"
        delete paths[fromPath]
        fromPath = fromPath.replace(re, requiredSep)
        paths[fromPath] = toPath

      if toPath.indexOf "\\"
        toPath = toPath.replace(re, requiredSep);
        paths[fromPath] = toPath

    paths

  excludeMissingFiles = (filepath) ->
    if !grunt.file.exists filepath
      grunt.log.warn 'Source file "' + filepath + '" not found.'
      false
    else
      true

  userev = () ->
    options = @options()
    requiredSep = '/'
    isSepIncorrect = path.sep isnt requiredSep
    hasVersionedPaths = grunt.filerev && grunt.filerev.summary
    versionedPaths = grunt.filerev.summary

    if (hasVersionedPaths && isSepIncorrect)
      grunt.log.debug "Fixing incorrect path separator"
      versionedPaths = fixPaths(versionedPaths, requiredSep)

    jsonStringFiles = JSON.stringify this.files, null, 4
    jsonStringOptions = JSON.stringify options, null, 4
    jsonStringVersionedFiles = JSON.stringify versionedPaths, null, 4

    grunt.log.debug @nameArgs + ': ' + jsonStringFiles + jsonStringOptions
    grunt.log.debug 'filerev.summary: ' + jsonStringVersionedFiles

    if hasVersionedPaths && versionedPaths

      @files.forEach (file) ->

        filteredFiles = file.src.filter excludeMissingFiles
        filteredFiles.forEach (filepath) ->

          updated = 0
          content = grunt.file.read filepath

          destination = '.'
          if file.dest
             destination = ' -> ' + file.dest.cyan

          grunt.log.writeln 'Open -> ' + filepath.cyan + destination

          for own label, pattern of options.patterns
            # let's find all the things that match this patter.
            while match = pattern.exec content
              replacement = match[0]

              grunt.log.writeln "Pattern "+label+" captured: " + replacement

              lastLink = match[1] || match[0]
              baseLink = lastLink

              if options.hash
                baseLink = replaceFirstGroup lastLink, options.hash, ''

              grunt.log.writeln " > Checking for hashed file: " + baseLink

              found = null
              _.forIn versionedPaths, (value, key) ->
                if endsWith key, baseLink
                  found =
                    original: key
                    hashed: value
                  return false

              break unless found

              hashLink = found.hashed.slice found.original.length - baseLink.length;

              if lastLink isnt hashLink
                thing = ""
                if lastLink isnt baseLink
                  thing = ' -> ' + baseLink

              replacement = replacement.replace lastLink, hashLink
              content = content.replace pattern, replacement

              grunt.log.writeln ' > Linked ' + label + ': ' + lastLink + thing + ' -> ' + hashLink + "\n\n"
              updated++


          if updated > 0
            target = file.dest || filepath
            grunt.log.writeln 'Updated '.yellow + target.cyan
            grunt.file.write target, content


  grunt.task.registerMultiTask 'userev', 'Update versioned assets references.', userev
