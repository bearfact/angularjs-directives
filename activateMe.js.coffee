# http://stackoverflow.com/questions/14833326/how-to-set-focus-in-angularjs
angular.module("jd.common.directives").directive "activateMe", [
  "$timeout"
  ($timeout) ->
    return link: ($scope, element) ->
      toggle = ->
        $(this).parent().children().removeClass "active"
        $(this).addClass "active"
        return
      element.children().each (index, child) ->
        $(child).on "click", toggle
        return
      return
]
