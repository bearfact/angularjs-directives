angular.module('jd.common.directives').directive "toggle", ->
  restrict: "E"
  replace: true
  template: "<label class=\"toggle rj-toggle clickable\" ng-click=\"fire_change_event()\"><i class=\"fa fa-fw fa-2x\" ng-class=\"{'fa-toggle-off': !ngModel, 'fa-toggle-on': ngModel}\"></i>&nbsp;<span style='vertical-align: top;'>{{label}}</span></label>"
  scope:
    ngModel: "="
    label: "@"
    ngChange: "&"

  link: (scope, element, attrs) ->
    scope.fire_change_event = ->
      scope.ngModel = not scope.ngModel
      return

    scope.$watch "ngModel", (new_val, old_val) ->
      scope.ngChange()  unless new_val is old_val
      return

    return
