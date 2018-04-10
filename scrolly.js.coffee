angular.module('jd.common.directives').directive "scrolly", ->
  restrict: "A"
  scope:
    downcallback: "&"
    upcallback: "&"
  link: (scope, element, attrs) ->
    scroll_dist = parseInt(attrs.scrolly) || 300
    scope['is_active'] = false
    $(document).bind "scroll", ->
      if ((element.offset().top - window.scrollY) < scroll_dist)
        if !scope.is_active
          scope.$apply () ->
            scope.downcallback() unless scope.is_active
          scope.is_active = true
      else if ((element.offset().top - window.scrollY) > scroll_dist)
        if scope.is_active
          scope.$apply () ->
            scope.upcallback() if scope.is_active
          scope.is_active = false
      return

    return


angular.module('jd.common.directives').directive "onElementScroll", ($rootScope, $document) ->
  restrict: 'A',
  link: (scope,elem,attrs) ->
    elem.on 'scroll', (e) ->
      $rootScope.$broadcast(attrs.onElementScroll, {})
      return

    # this is a hacky bullshit solution because I don't want to make a dedicated directive and I can't place the attr declarition on the body
    $document.bind 'scroll', (e) ->
      $rootScope.$broadcast("librayScrollEvent", {})
      return
    return
