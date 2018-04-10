#to disable the way that scrolling changes the data for a <input type="number" /> you need to blur on mousewheel
angular.module("jd.common.directives").directive "scrollBlur", [
  () ->
    return {
      link: ($scope, element, attributes) ->
        element.on('mousewheel', (e) ->
          $(this).blur()
          return
        )
    }
]
