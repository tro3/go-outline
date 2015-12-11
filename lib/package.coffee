path = require 'path'
_ = require 'underscore-plus'
# {CompositeDisposable, Emitter} = require 'event-kit'

#PathWatcher = require 'pathwatcher'
#File = require './file'
# {repoForPath} = require './helpers'
#realpathCache = {}

EntryElement = require './entry'

#module.exports =
class Package extends HTMLElement

  initialize: (@packageName) ->

    #@name = @path.replace(/^.*[\\\/]/, '')
    @classList.add('entry',  'list-nested-item')#,  'collapsed')
    @header = document.createElement('div')
    @packageNameElem = document.createElement('span')
    @packageNameElem.classList.add('name', 'icon', 'icon-file-directory')
    @packageNameElem.title=@packageName
    packageNameTextNode = document.createTextNode(@packageName)
    @packageNameElem.appendChild(packageNameTextNode)
    @header.appendChild(@packageNameElem)

    @appendChild(@header)

    @entries = document.createElement('ol')
    @entries.classList.add('entries', 'list-tree')
    @appendChild(@entries)

    @children = {}

  updateFileEntries: (fileName, entries) ->
    for entryName, entryValues of entries
      console.log entryName, entryValues
      if !@children[entryName]?
        child = new EntryElement().initialize(entryName)
        @children[entryName] = child
        @entries.appendChild(child)
      console.log entryValues.children
      @children[entryName].updateFileEntries(fileName, entryValues?.children)





PackageElement = document.registerElement('outline-package', prototype: Package.prototype, extends: 'div')
module.exports = PackageElement
