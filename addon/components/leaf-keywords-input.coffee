`import Ember from 'ember'`
`import layout from 'ember-leaf-tools/templates/components/leaf-keywords-input'`

KEYS = {
  BACKSPACE: 8
  SPACE: 32
  TAB: 9
  ENTER: 13
  SHIFT: 16
  ESC: 27
  ARROW_LEFT: 37
  ARROW_UP: 38
  ARROW_RIGHT: 39
  ARROW_DOWN: 40
  COMMA: 188
}

LeafKeywordsInput = Ember.Component.extend(
  layout: layout

  source: []
  value: []

  error: null
  valid: false

  valueAsString: ( ->  @get('value').join(' ')).property('value')

  active: true
  suggestActive: false

  classNames: ['kw-widget', 'form-group']
  classNameBindings: ['active', 'has-error', 'has-feedback', 'has-success', 'valid']


  'has-feedback': Ember.computed.notEmpty('error')
  'has-success': Ember.computed.not('has-error')

  'has-error': ( ->
    !Ember.isBlank(@get('error')) && !@get('hasSuggestions')
  ).property('error', 'hasSuggestions')

  placeholder: 'Enter keywords....'

  hasSuggestions: Ember.computed.notEmpty('suggestions')

  containerId: ( ->
    @get('elementId') + '-input'
  ).property('elementId')

  updateValue: ( ->
    tags = @get('input').getTags()
    values = @set('value', Ember.get(tags, 'values'))
    @sendAction('on-value-change', values, @get('valueAsString'))
  )

  onTagAdd: (event, tag) ->
    @updateValue()

  onTagRemove: (event, tag) ->
    @updateValue()


  needle: null
  maxSuggestions: 5

  suggestions: (->
    if (source = @get('source')) && (needle = @get('needle'))
      source.filter((item, index, enumerable) =>
        item.startsWith(needle.toLowerCase())
      )
    else
      []
  ).property('source', 'needle')

  firstSuggestions: (->
    @get('suggestions')?.slice(0, @get('maxSuggestions'))
  ).property('suggestions.[]', 'maxSuggestions')

  insertTag: (tag) ->
    input = @get('input')
    input.add(tag)
    input.getInput().focus()
    @set('needle', null)
    @updateValue()

  insertTopSuggestion: (needle) ->
    if (tag = @get('firstSuggestions.firstObject')) && !Ember.isBlank(needle)
      @insertTag(tag)

  sourceHasChanged: ( -> @reset()).observes('source.[]')

  reset: ->
    @setProperties
      needle: null
      #value: null
    @deactivateSub()
    input = @get('input')
    input.settings.allowedTags = @get('source')
    input.input.value = ''
    input.removeAll()
    @updateValue()


  setup: ( ->

    { containerId,
      source,
      placeholder } = @getProperties('containerId', 'source', 'placeholder')

    input = new Taggle(containerId,
      allowedTags: source
      allowDuplicates: true
      delimeter: ' '
      placeholder: placeholder
      clearOnBlur: false
      submitKeys: [KEYS.COMMA, KEYS.TAB, KEYS.ENTER, KEYS.SPACE]
      onTagAdd: ((event, tag) => @onTagAdd(event, tag))
      onTagRemove: ((event, tag) => @onTagRemove(event, tag))
    )
    @set('input', input)

    inputEl = input.getInput()

    self = @
    $(inputEl).keyup((event) ->
      current = $(@).val()
      self.keyHandler(event, current)
    )
  ).on('didInsertElement')


  activateSub: ->
    if @get('active') && @get('hasSuggestions')
      @setProperties
        active: false
        suggestActive: true
      @get('input').getInput().blur()

  deactivateSub: ->
    unless @get('active')
      @setProperties
        active: true
        suggestActive: false
      @get('input').getInput().focus()

  keyHandler: (event, current) ->
    return unless @get('active')
    switch event.keyCode
      when KEYS.SPACE
        @insertTopSuggestion(current)
        @deactivateSub()
        @set('needle', null)

      when KEYS.ARROW_DOWN, KEYS.TAB
        @activateSub()

      else
        @set('needle', current)

  actions:
    addSuggestion: (tag) ->
      @insertTag(tag)
      @deactivateSub()

    suggestClosed: (value) ->
      @deactivateSub()

)

`export default LeafKeywordsInput`
