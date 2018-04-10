angular.module('jd.common.directives').directive "checkbox", ->
  restrict: "E"
  replace: true
  template: "<label class=\"checkbox rj-checkbox\" ng-click=\"fire_callback()\"><i class=\"fa fa-fw\" ng-class=\"{'fa-square-o': !checked, 'fa-check-square-o': checked}\"></i>&nbsp;<span>{{label}}</span></label>"
  scope:
    checked: "="
    label: "@"
    callback: "&"
    ngDisabled: "=?"
    ngChecked: "&"

  link: (scope, element, attrs) ->
    scope.fire_callback = ->
      if(not scope.ngDisabled)
        scope.checked = not scope.checked
      return

    # scope.fire_check = ->
    #   true
    #   # if(not scope.ngDisabled)
    #   #   scope.ngChecked()

    scope.$watch "checked", (new_val, old_val) ->
      scope.callback()  unless new_val is old_val
      return

    scope.$watch "ngChecked", () ->
      scope.ngChecked()
      return

    return
