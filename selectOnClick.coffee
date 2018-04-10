angular.module("jd.common.directives").directive 'selectOnClick', [
  '$window'
  ($window) ->
    {
      restrict: 'A'
      link: (scope, element, attrs) ->
        element.on 'click', ->
          if !$window.getSelection().toString()
            # Required for mobile Safari
            @setSelectionRange 0, @value.length
          return
        return

    }
]
