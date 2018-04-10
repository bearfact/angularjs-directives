angular.module("jd.common.directives").directive "ifUserCan", [
  'currentUser'
  (currentUser) ->
    return (
      scope:
        model: '@ifUserCan'

      link: (scope, element) ->
        unless _.contains currentUser.clearance_levels, scope.model
          element.remove()
        return
    )
]
