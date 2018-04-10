angular.module('jd.common.directives').directive 'elastic',
  (
    $timeout
  ) ->

    return (
      restrict: "A"
      link: ($scope, element) ->
        resize = ->
          element[0].style.height = "" + element[0].scrollHeight + "px"

        element.on "blur keyup change", resize
        $timeout resize, 0
        return
    )
