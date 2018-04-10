angular.module("jd.common.directives").directive "variableReplacer", ->
  replace = (value, variables, element) ->
    if value
      value = value.replace(/(?:\r\n|\r|\n)/g, '<br />');
      angular.forEach value.match(var_pattern), (matched_var) ->
        idx = value.indexOf(matched_var)
        if idx > -1
          value_for_replace = variables[matched_var.replace(/#|{{|}}/g, "")]
          value = value.replace(new RegExp(matched_var, "g"), value_for_replace) if value_for_replace?# and value_for_replace?
        return

    else
      value = ""
    element.html value
    return
  var_pattern = /(#[A-Za-z0-9_]+#)|({{[A-Za-z0-9_]+}})/g
  restrict: "A"
  require: "ngModel"
  replace: true
  scope:
    variables: "=variableReplacer"
    ngModel: "=ngModel"

  link: compile = (scope, element, attrs, controller) ->
    scope.$watch "variables", ((value) ->
      replace scope.ngModel, scope.variables, element
      return
    ), true
    scope.$watch "ngModel", (value) ->
      replace value, scope.variables, element
      return

    return
