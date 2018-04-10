angular.module('jd.common.directives').directive 'stopPropagate', ->
  {
    restrict: 'C'
    link: (scope, element) ->
      element.on 'click', (event) ->
        event.stopPropagation()
        return
      return

  }

angular.module('jd.common.directives').directive 'aPrevent', ->
  {
    restrict: 'C'
    link: (scope, element) ->
      element.on 'click', (event) ->
        event.preventDefault()
        return
      return

  }
