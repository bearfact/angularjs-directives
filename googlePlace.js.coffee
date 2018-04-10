# requires a google script ref
# <script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?libraries=places&sensor=false?key=AIzaSyCc7slmoHgLaXPitvOyLA2X8cwGPDvJbN4" async="true" defer="true"></script>
angular.module('jd.common.directives')
.directive "googlePlace", ->
  require: "ngModel"
  link: (scope, element, attrs, model) ->
    options =
#     types: ['street_address', 'route']
      types: ['geocode']
      componentRestrictions: {}

    scope.gPlace = new google.maps.places.Autocomplete(element[0], options)
    google.maps.event.addListener scope.gPlace, "place_changed", ->
      scope.$apply ->
        model.$setViewValue element.val()
        return

      return

    return
