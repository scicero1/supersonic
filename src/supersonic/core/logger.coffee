module.exports =
  log: (type, message)->
    if !(message)
      message = type
      type = 'silly'
    
    steroids.logger.log message

  info: (message)->
    @log('info', message)

  warn: (message)->
    @log('warn', message)

  error: (message)->
    @log('error', message)
