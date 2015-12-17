jQuery ->
  format = (item) -> item.title
  format2 = (item) -> item.name

  $('#book_author_ids').select2
    data:
      results: $('#book_author_ids').data "authors"
      text: 'name'
    formatSelection: format2
    formatResult: format2
    multiple: true
    separator: '%%$$%%'
    createSearchChoice: (term) ->
      id: term,
      name: term + ' (new)'

  $('.cat-select2').select2()
  # $('#book_tag_list').select2({tags:[]})
  $( ".tags" ).select2
    theme: "bootstrap",
    tokenSeparators: [',']
