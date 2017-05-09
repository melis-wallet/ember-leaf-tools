`import Ember from 'ember'`
`import layout from 'ember-leaf-tools/templates/components/leaf-multiple-toggler'`
`import SizeSupport from 'ember-leaf-core/mixins/leaf-size-support'`


MultipleToggler = Ember.Component.extend(SizeSupport,
  layout: layout

  dropdown: false

  tagName: 'button'
  classNames: ['btn']
  classNameBindings: ['labeled:btn-labeled']
  classTypePrefix: 'btn'

  attributeBindings: ['btype:type']
  btype: 'button'

  icon: null

  options: []
  value: null

  currentValue: Ember.computed.oneWay('value')

  labeled: Ember.computed.notEmpty('icon')

  initalize: false

  setup: (->
    if @get('initalize')
      @set('value', @get('options.firstObject'))

  ).on('didInsertElement')


  nextValue: ->
    { currentValue,
      options } = @getProperties('currentValue', 'options')

    i = options.indexOf(currentValue)
    options[ if ( i == options.length - 1) then 0 else ( i + 1 )]


  select: (value) ->
    @sendAction('on-change', value)

  selectNext: ->
    @select(@nextValue())

  click: (e) ->
    unless @get('dropdown')
      @selectNext()
)


`export default MultipleToggler`