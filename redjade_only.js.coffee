angular.module("jd.common.directives").directive "redjadeOnly", [
  'currentUser'
  (currentUser) ->
    return (
      link: (scope, element) ->
        unless currentUser.red_jade_admin
          element.remove()
        return
    )
]
