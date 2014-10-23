Promise = require 'bluebird'
Bacon = require 'baconjs'

{deviceready} = require '../events'

module.exports = (steroids, log) ->
  bug = log.debuggable "supersonic.device.compass"

  ###
   # @category core
   # @module device
   # @name compass
   # @overview
   # @description
   # Provides access to the device's compass. The compass is a sensor that detects the direction or heading that the device is pointed, typically from the top of the device. It measures the heading in degrees from 0 to 359.99, where 0 is north.
  ###

  ###
   # @module compass
   # @name watchHeading
   # @function
   # @apiCall supersonic.device.compass.watchHeading
   # @description
   # Returns a stream of compass heading updates.
   # @type
   # supersonic.device.compass.watchHeading : (
   #   options?: {
   #     frequency?: Integer,
   #     filter?: Integer
   #   }
   # ) => Stream: {
   #   magneticHeading: Number,
   #   trueHeading: Number,
   #   headingAccuracy: Number,
   #   timestamp: Number
   # }
   # @define {Object} options={} Optional options object.
   # @define {Integer} options.frequency=100 Update interval in milliseconds.
   # @define {Integer} options.filter The change in degrees required to initiate an update. When this value is set, `options.frequency` is ignored.
   # @returnsDescription [Stream](todo) of heading objects with the following properties:
   # @define {=>Object} heading Heading object.
   # @define {=>Number} heading.magneticHeading  The heading in degrees from 0-359.99 at a single moment in time.
   # @define {=>Number} heading.trueHeading The heading relative to the geographic North Pole in degrees 0-359.99 at a single moment in time. A negative value indicates that the true heading couldn't be determined.
   # @define {=>Number} heading.headingAccuracy The deviation in degrees between the reported heading and the true heading.
   # @define {=>Number} heading.timestamp The time at which the heading was determined, in Unix Epoch time milliseconds.
   # @usageCoffeeScript
   # supersonic.device.compass.watchHeading options
   # @exampleCoffeeScript
   # supersonic.device.compass.watchHeading().onValue (heading) ->
   #   supersonic.logger.log(
   #     """
   #     Magnetic heading: #{heading.magneticHeading}
   #     True heading: #{heading.trueHeading}
   #     Heading accuracy: #{heading.headingAccuracy}
   #     Timestamp: #{heading.timestamp}
   #     """
   #   )
  ###
  watchHeading = (options = {}) ->
    compassOptions =
      frequency: options?.frequency? || 100
      filter: options?.filter? || null

    Bacon.fromPromise(deviceready).flatMap ->
      Bacon.fromBinder (sink) ->
        watchId = window.navigator.compass.watchHeading(
          (heading) -> sink new Bacon.Next heading
          (error) -> sink new Bacon.Error error
          compassOptions
        )
        ->
          window.navigator.compass.clearWatch watchId

  ###
   # @module compass
   # @name getHeading
   # @function
   # @apiCall supersonic.device.compass.getHeading
   # @description
   # Returns device's current heading.
   # @type
   # supersonic.device.compass.getHeading: () =>
   #   Promise: {
   #     magneticHeading: Number,
   #     trueHeading: Number,
   #     headingAccuracy: Number,
   #     timestamp: Number
   #   }
   # @returnsDescription [Promise](todo) is resolved to the next available heading data.
   # @define {=>Object} heading Heading object.
   # @define {=>Number} heading.magneticHeading  The heading in degrees from 0-359.99 at a single moment in time.
   # @define {=>Number} heading.trueHeading The heading relative to the geographic North Pole in degrees 0-359.99 at a single moment in time. A negative value indicates that the true heading couldn't be determined.
   # @define {=>Number} heading.headingAccuracy The deviation in degrees between the reported heading and the true heading.
   # @define {=>Number} heading.timestamp The time at which the heading was determined, in Unix Epoch time milliseconds.
   # @usageCoffeeScript
   # supersonic.device.compass.getHeading()
   # @exampleCoffeeScript
   # supersonic.device.compass.getHeading().then (heading) ->
   #   steroids.logger.log(
   #     """
   #     Magnetic heading: #{heading.magneticHeading}
   #     True heading: #{heading.trueHeading}
   #     Heading accuracy: #{heading.headingAccuracy}
   #     Timestamp: #{heading.timestamp}
   #     """
   #   )
  ###
  getHeading = ->
    new Promise (resolve) ->
      watchHeading().take(1).onValue resolve

  return {watchHeading, getHeading}
