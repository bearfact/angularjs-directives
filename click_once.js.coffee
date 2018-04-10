angular.module("jd.common.directives").directive 'clickOnce', ($timeout) ->
  {
    restrict: 'A'
    link: (scope, element, attrs) ->
      replacementText = attrs.clickOnce
      element.bind 'click', ->
        $timeout (->
          if replacementText
            element.html replacementText
          element.attr 'disabled', true
          return
        ), 0
        return
      return

  }
