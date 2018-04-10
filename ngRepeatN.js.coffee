angular.module('jd.common.directives').directive 'ngRepeatN', [
  '$parse'
  ($parse) ->
    {
      isolate: true
      restrict: 'A'
      transclude: 'element'
      replace: true
      link: (scope, element, attrs, ctrl, $transclude) ->
        # the element to insert after
        scope.last = element
        # the parent element
        scope.parentElem = element.parent()
        # list of elements in the repeater
        scope.elems = [ element ]
        # a getter function to resolve the parameter
        getter = $parse(attrs.ngRepeatN)
        scope.$watch (->
          parseInt(attrs.ngRepeatN) or getter(scope)
        ), (newValue, oldValue) ->
          newInt = parseInt(newValue)
          oldInt = parseInt(oldValue)
          bothValues = !isNaN(newInt) and !isNaN(oldInt)
          childScope = undefined
          i = undefined
          limit = undefined
          # decrease number of repeated elements
          if isNaN(newInt) or bothValues and newInt < oldInt
            limit = if bothValues then newInt else 0
            scope.last = scope.elems[limit]
            i = scope.elems.length - 1
            while i > limit
              scope.elems[i].remove()
              scope.elems.pop()
              i -= 1
          else
            i = scope.elems.length - 1
            i
            while i < newInt
              childScope = scope.$new()
              childScope.$index = i
              $transclude childScope, (clone) ->
                scope.last.after clone
                scope.last = clone
                scope.elems.push clone
                return
              i += 1
          return
        return

    }
]

# ---
# generated by js2coffee 2.0.4
