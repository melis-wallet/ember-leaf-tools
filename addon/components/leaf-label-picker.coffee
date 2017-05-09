`import Ember from 'ember'`
`import layout from 'ember-leaf-tools/templates/components/leaf-label-picker'`

LabelPicker = Ember.Component.extend(
  layout: layout

  classNames: ['form-group']

  maxItems: '6'
  allLabels: null


  actions:

    setNewLabel: (text) ->
      @get('newLabels').pushObject(text)

    gotFocus: (select) ->
      console.error "gotFocus"


    lostFocus: (select) ->
      console.error "lostfocus"
      return
      #selection = @get('selection')
      #waitIdle().then( => @sendAction('on-finish', @get('selection')))

    updateLabels: ->
      selection = @get('selection')
      @updateLabels()
      @sendAction('on-finish', @get('selection'))

    createOnEnter: (select, e) ->
      if ((e.keyCode == 13) && select.isOpen && !select.highlighted && !Ember.isBlank(select.searchText))
        selection = @get('selection')
        if (!selection.includes(select.searchText))
          this.get('newLabels').pushObject(select.searchText)
          select.actions.choose(select.searchText)

)

`export default LabelPicker`