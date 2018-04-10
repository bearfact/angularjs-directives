angular.module('jd.common.directives').directive "rjAffix", ->
  restrict: "A"
  scope: true
  link: (scope, element, attrs) ->
    top_offset = parseInt(attrs.topOffset)
    bottom_offset = parseInt(attrs.bottomOffset)
    scope['is_active'] = false
    $(document).bind "scroll", ->
      if ((element.offset().top - window.scrollY) < top_offset && !scope.is_active)
        element.addClass("affix")
        scope.is_active = true
      else if ( window.scrollY < bottom_offset  && scope.is_active)
        element.removeClass("affix")
        scope.is_active = false

      return

    return
