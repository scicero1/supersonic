SuperModalShowPrototype = Object.create HTMLElement.prototype
###
 # @namespace components
 # @name super-modal-show
 # @component
 # @description
 # Shows a modal. Uses `supersonic.ui.modal.show` internally.
 # @attribute location The route or URL for the view to be shown.
 # @attribute action="click" The action used to trigger the transition.
 # @usageHtml
 # <super-modal-show location="cars#edit" action="click">Edit Car</super-modal-show>
 # @exampleHtml
 # <!-- The action attribute is optional -->
 # <super-modal-show location="cars#edit">Edit Car</super-modal-show>
 #
 # <!-- External URLs work too -->
 # <super-modal-show location="http://google.com">Open Google</super-modal-show>
 #
 # <!-- The default action can be overridden -->
 # <super-modal-show location="meeting#details" action="touchmove">Show meeting details</super-modal-show>
###
SuperModalShowPrototype.createdCallback = ->
  action = @getAttribute("action") || "click"

  @addEventListener action, =>
    viewId = @getAttribute "view-id"
    if viewId
      return supersonic.ui.views.find(viewId)
        .then (view) ->
          supersonic.ui.modal.show(view)
        .catch (error) ->
          throw new Error "Failed to push view: #{error}"

    location = @getAttribute "location"
    if location
      view = supersonic.ui.view location
      return supersonic.ui.modal.show(view)
        .catch (error) ->
          throw new Error "Failed to push view: #{error}"

    throw new Error "Either view-id or location must be set"

document.registerElement "super-modal-show",
  prototype: SuperModalShowPrototype