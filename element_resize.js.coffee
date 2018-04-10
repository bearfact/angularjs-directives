angular.module('jd.common.directives').directive "elementResize", [
	"$window"
	($window) ->
		restrict: "A"
		link: (scope, element, attrs) ->
			scope.onResize = ->
				element.css('max-height', $window.innerHeight - parseInt(attrs.elementResize))
				return
			scope.onResize()
			angular.element($window).bind "resize", ->
				scope.onResize()
]