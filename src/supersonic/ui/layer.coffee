Promise = require 'bluebird'


module.exports = (steroids, log) ->
  # TODO: add bug later
  # bug = log.debuggable "supersonic.ui.layer"

  ###*
   * @ngdoc overview
   * @name layer
   * @module ui
   * @description
   * Provides methods to work with layers
  ###

  ###*
   * @ngdoc method
   * @name push
   * @module layer
   * @description
   * Navigates to a given view
   * @param {View} A view object
   * @returns
   * @usage
   * ```coffeescript
   * v = supersonic.ui.view("http://www.google.com")
   * supersonic.iu.layer.push(v)
   * ```
  ###
  push: (view)->
    steroids.layers.push(view.getWebView())
