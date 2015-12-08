jQuery.validator.addMethod "phone", ((phone_number, element) ->
  phone_number = phone_number.replace(/\s+/g, "")
  @optional(element) or phone_number.match(/^(\(?\d{3}\)?[\- ]?)?[\d\- ]{6,10}$/)
), "Пожалуйста, введите корректный номер телефона."
jQuery.validator.addMethod "usermail", ((user_email, element) ->
  # user_email = user_email.replace(/\s+/g, "")
  @optional(element) or user_email.match(/^(("[\w-\s]+")|([\w-]+(?:\.[\w-]+)*)|("[\w-\s]+")([\w-]+(?:\.[\w-]+)*))(@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$)|(@\[?((25[0-5]\.|2[0-4][0-9]\.|1[0-9]{2}\.|[0-9]{1,2}\.))((25[0-5]|2[0-4][0-9]|1[0-9]{2}|[0-9]{1,2})\.){2}(25[0-5]|2[0-4][0-9]|1[0-9]{2}|[0-9]{1,2})\]?$)/i)
  # @optional(element) or user_email.match([\w-\.]+)@((?:[\w]+\.)+)([a-zA-Z]{2,4})
), "Please specify a valid email"
jQuery.validator.addMethod "fieldPresent",  ((value, element, options) ->
  targetEl = jQuery('input[name="'+options.data+'"]')
  bothEmpty = (value == targetEl.val() == '')
  # (bothEmpty) ? targetEl.addClass('error') : targetEl.removeClass('error')
  if bothEmpty then targetEl.addClass('error') else targetEl.removeClass('error')
  return !bothEmpty
), "Заполните одно из полей для связи."



user1 = {
      'user_sign_in_service[password]': {required: true, minlength: 8}
      "user_sign_in_service[email]": { required: true, usermail: true}
}


jQuery ($) ->
  # ==========================================================================
  #     forms
  #     ==========================================================================

  $('#new_user').validate
    ignore: 'hidden'
    errorElement: "div"
    errorClass: 'error'

    errorPlacement: (error, element) ->
      element.addClass('error')
      element.parent().append(error.addClass('error-mess'))
    rules: user1



