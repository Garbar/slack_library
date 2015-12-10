jQuery ->
	$("#new_review")
	    .on "ajax:success", (evt, data, status, xhr) ->
	      # console.log(data)
	      # $('#add_success').modal({show:true})
	      $('#new_review')[0].reset()
