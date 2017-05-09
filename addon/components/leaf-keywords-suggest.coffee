`import Ember from 'ember'`
`import layout from 'ember-leaf-tools/templates/components/leaf-keywords-suggest'`


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

LeafKeywordsSuggestions = Ember.Component.extend(
  layout: layout


  tagName: 'ul'
  classNames: ['suggestions', 'help-block']
  classNameBindings: ['active', 'hidden']

  attributeBindings: [
    'role'
    'ariaMultiselectable:aria-multiselectable'
    'ariaExpanded:aria-expanded'
    'tabindex'
    'value'
  ],


  role: 'listbox'
  ariaMultiselectable: 'false'
  ariaExpanded: Ember.computed.alias('active')

  tabindex: 0

  suggestions: []
  current: null

  active: false
  hidden: Ember.computed.empty('suggestions')


  onActivation: ( ->
    if @get('active')
      @set('current', @get('suggestions.firstObject'))
      Ember.run.scheduleOnce('afterRender', this, ( -> @.$().focus()))
    else
      @set('current', null)
  ).observes('active', 'suggestions')


  nextSuggestion: ( ->
    { current,
      suggestions } = @getProperties('current', 'suggestions')

    i = suggestions.indexOf(current)
    suggestions[ if ( i == suggestions.length - 1) then 0 else ( i + 1 )]
  ).property('current', 'suggestions')

  prevSuggestion: ( ->
    { current,
      suggestions } = @getProperties('current', 'suggestions')

    i = suggestions.indexOf(current)
    suggestions[ if ( i == 0) then (suggestions.length - 1) else ( i - 1 )]

  ).property('current', 'suggestions')


  handleKey: ((ev) ->
    handled = false
    switch ev.keyCode
      when KEYS.ARROW_RIGHT, KEYS.ARROW_DOWN
        @set('current', @get('nextSuggestion'))
        handled = true

      when KEYS.ARROW_LEFT, KEYS.ARROW_UP
        @set('current', @get('prevSuggestion'))
        handled = true

      when KEYS.ENTER, KEYS.SPACE
        @sendAction('on-add', @get('current'))
        handled = true

      when KEYS.ESC, KEYS.TAB
        @sendAction('on-escape', @get('current'))
        handled = true

    if handled
      ev.preventDefault()

  ).on('keyDown')


  handleBlur: ((ev) ->
    @sendAction('on-blur', @get('current'))
  ).on('focusOut')

  setup: ( ->

  ).on('didInsertElement')

  actions:
    addSuggestion: (tag) ->
      @sendAction('on-add', tag)

)

`export default LeafKeywordsSuggestions`
