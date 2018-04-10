angular.module('jd.common.directives').controller 'percentScalerCtrl',
  (
    $scope
  ) ->
    init = ->
      setPercent()
      if vm.config?
        useConfig()
        return
      vm.breaks = _.sortBy(vm.breaks) if vm.breaks?
      if vm.direction == 'negative'
        setNegativeClass()
      else if vm.direction == 'positive'
        setPositiveClass()
      else if vm.direction == 'neutral'
        vm.percent_class = ''

    setPercent = ->
      unless vm.percent?
        if vm.numerator == 0 && vm.denominator > 0
          vm.percent = 0
        else if vm.numerator == 0 && vm.denominator <= 0
          vm.percent = 0
        else
          vm.percent = (vm.numerator / vm.denominator) * 100


    useConfig = ->
      vm.success_class = $scope.config.success_class
      vm.failure_class = $scope.config.failure_class
      if vm.direction == 'positive'
        setPositiveClassByConfig()
      else if vm.direction == 'negative'
        setNegativeClassByConfig()

    setPositiveClassByConfig = ->
      vm.percent_class = _.chain(vm.config.breakpoints)
                          .map((bp, i) -> 
                            if i == 0
                              if vm.percent >= bp.point
                                return vm.success_class
                              else if vm.percent < bp.point && vm.percent >= vm.config.breakpoints[i + 1].point
                                return bp.class
                            else if i > 0 && i < vm.config.breakpoints.length && i + 1 < vm.config.breakpoints.length
                              if vm.percent < bp.point
                                return bp.class
                              else if vm.percent >= bp.point && vm.percent < vm.config.breakpoints[i - 1].point
                                return vm.config.breakpoints[i - 1].class
                            else if (i + 1) == vm.config.breakpoints.length
                              if vm.percent > bp.point && vm.percent < vm.config.breakpoints[i].point
                                return vm.config.breakpoints[i - 1].class
                              if vm.percent < bp.point
                                return bp.class
                          )
                          .compact()
                          .value()

    setNegativeClassByConfig = ->
      vm.percent_class = _.chain(vm.config.breakpoints)
                          .map((bp, i) ->
                            if i == 0
                              if vm.percent > bp.point
                                return vm.failure_class
                            else if i > 0 && i + 1 < vm.config.breakpoints.length
                              if vm.percent > bp.point && vm.percent <= vm.config.breakpoints[i - 1].point
                                return vm.config.breakpoints[i - 1].class
                            else if i + 1 == vm.config.breakpoints.length && i != 0
                              if vm.percent >= bp.point
                                return vm.config.breakpoints[i - 1].class
                              else if vm.percent < bp.point
                                return bp.class
                          )
                          .compact()
                          .value()

    setNegativeClass = ->
      vm.percent_class = switch
        when vm.percent <= vm.breaks[0] then 'text-success'
        when vm.percent > vm.breaks[1] and vm.percent <= vm.breaks[2] then 'text-warning'
        when vm.percent > vm.breaks[2] then 'text-danger'

    setPositiveClass = ->
      vm.percent_class = switch
        when vm.percent >= vm.breaks[0] then 'text-success'
        when vm.percent < vm.breaks[0] and vm.percent >= vm.breaks[1] then 'text-warning'
        when vm.percent < vm.breaks[1] then 'text-danger'

    vm = {
      percent_class: ''
      percent: $scope.percent
      decimals: $scope.decimals || 0
      direction: $scope.direction || 'positive'
      breaks: $scope.breaks || [90,50,10]
      numerator: $scope.numerator || 0
      denominator: $scope.denominator || 0
      config: $scope.config if $scope.config
    }
    $scope.vm = vm
    init()
    return

angular.module('jd.common.directives').directive 'percentScaler', ->
  {
    restrict: 'EA'
    transclude: true
    scope:
      breaks: '='
      direction: '='
      percent: '='
      numerator: '='
      denominator: '='
      decimals: '='
      config: '='
    templateUrl: '/partials/recruiting_blasts/percent_scaler.html'
    controller: 'percentScalerCtrl'
  }