angular.module('jd.common.directives').directive 'formErrors', ->
  {
    restrict: 'A'
    scope:
      errors: '=formErrors'
    link: (scope, element) ->
      scope.$watch "errors", (new_val, old_val) ->
        form = $(element)
        form.find(".has-error").removeClass("has-error")
        form.find(".error-messages").html("")
        _.each scope.errors, (values, key) ->
          input_control = form.find('[name="' + key + '"]')
          input_control = form.find('[ng-model="' + key + '"]') unless input_control.length > 0

          fg = form.find('[error-key="' + key + '"]')
          fg = input_control.closest(".form-group") if input_control.length < 0

          if fg
            fg.addClass("has-error")
            message_container = fg.find(".error-messages")
            if(message_container)
              message_container.html("")
              if _.isArray(values)
                _.each values, (value) ->
                  message_container.append("<div>#{value}</div>")
              else
                message_container.append("<div>#{values}</div>")

        summary = form.find(".error-summary")
        if summary
          summary.html("")
          summary.append("<div class='alert alert-danger'></div>")
          _.each scope.errors, (values, key) ->
            _.each values, (value) ->
              summary.find(".alert").append("<p>#{value}</p>")
        return
      return

  }
