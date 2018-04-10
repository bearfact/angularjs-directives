angular.module('jd.common.directives').filter 'humanizeConstant', ->
  (text) ->
    if text
      string = text.split('_').join(' ').toLowerCase()
      string = string.charAt(0).toUpperCase() + string.slice(1)
      return string
    return
