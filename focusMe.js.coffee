angular.module("jd.common.directives").directive "focusMe2", ($timeout, $parse) ->
  link: (scope, element, attrs) ->
    model = $parse(attrs.focusMe2)
    scope.$watch model, (value) ->
      if value is true
        $timeout ->
          element[0].focus()
          return
      return

    return


angular.module("jd.common.directives").directive "focusMe", [
  "$timeout"
  ($timeout) ->
    return (
      scope:
        trigger: "=focusMe"
        focusedIndex: "="
        currentIndex: "="

      link: ($scope, element) ->
        if $scope.trigger
          element[0].focus()

        $scope.$watch "trigger", (value) ->
          if value is true
            $timeout(->
              $(element[0]).select()
              element[0].focus()
              $scope.trigger = false
              return
            , 10)
          return

        $scope.$watch "focusedIndex", (value) ->
          if value && value == $scope.currentIndex
            $timeout(->
              $(element[0]).select()
              element[0].focus()
              $scope.focusedIndex = null
              return
            , 10)
          return

        return
    )
]
