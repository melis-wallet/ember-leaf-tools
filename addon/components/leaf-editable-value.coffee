import Component from '@ember/component'
import { oneWay, readOnly } from '@ember/object/computed'
import { defineProperty } from '@ember/object'
import { isBlank, isNone } from '@ember/utils'
import { scheduleOnce, debounce } from '@ember/runloop'

import layout from 'ember-leaf-tools/templates/components/leaf-editable-value'

import Logger from 'ember-leaf-core/utils/logger'

EditableValue = Component.extend(
  layout: layout

  classNames: ['editable-value']
  classNameBindings: ['hover']

  inputError: null

  editing: false

  value: null
  type: 'text'


  oldValue: null
  'text-area': false

  ident: null

  'if-empty': null
  'local-template': false
  'allow-enter': false

  additionalText: null

  autoresize: false
  maxlength: null

  size: 'sm'

  baseInputClass: "form-control animated fadeIn quick"
  inputClass: null

  #
  sizeClass: ( ->
    "input-#{@get('size')}"
  ).property('size')

  #
  fullInputClass: ( ->
    { baseInputClass, sizeClass, inputClass } = @getProperties('baseInputClass', 'sizeClass', 'inputClass')

    "#{baseInputClass} #{sizeClass} #{inputClass}"
  ).property('sizeClass', 'baseInputClass', 'fullInputClass')

  displayedError: (->
    @get('errorMessage') || @get('inputError')
  ).property('inputError', 'errorMessage')

  displayEmpty: (->
    isBlank(@get('currentValue')) && !isBlank(@get('if-empty'))
  ).property('currentValue', 'if-empty')

  displayedValue: ( ->
    if (emptyVal = @get('if-empty')) && isBlank(@get('currentValue'))
      emptyVal
    else
      @get('currentValue')
  ).property('currentValue', 'if-empty')

  mouseEnter: ->
    @set('hover', true)

  mouseLeave: ->
    @set('hover', false)

  # click is temporarily disabled because of a bug involving validations
  # which causes a stack exaustion whenever the "click" metod is overridden#
  # and a derived class has validations (wtf?)
  #
  xclick: ->
    @switchEditing()

  #
  #
  switchEditing: ->
    @setProperties
      oldValue: @get('currentValue')
      editing: true


  #
  #
  editingOn: (->
    if @get('editing')
      scheduleOnce 'afterRender', this, (-> @.$('input').focus())
  ).observes('editing')

  #
  #
  doneEdit: (value, newValue) ->
    Logger.debug("- changed new: #{newValue}, old:  #{value}")
    @sendAction('on-change', newValue, @get('ident'))
    @resetValue()

  #
  #
  #
  leaveEdit: ->
    oldValue = @get('oldValue')
    if @get('isValid')
      value = @get('currentValue')

      if (isNone(value) && !isBlank(oldValue)) || (!isNone(value) && (oldValue != value?.toString()))
        debounce(this, @doneEdit, oldValue, value, 25, true)
      @set('editing', false)
    else
      @setProperties
        currentValue: oldValue
        editing: false
      @resetValue()

  resetValue: ->
    @initValue()

  #
  #
  #
  initValue: ->
    defineProperty(this, 'currentValue', oneWay('value'))
    @set('isValid', true)

  #
  #
  #
  init: ->
    @_super(arguments...)
    @initValue()

  actions:
    clickedValue: ->
      @switchEditing()

    leaveEdit: ->
      @leaveEdit()

    leaveEditEnter: ->
      @leaveEdit() unless @get('allow-enter')

)


export default EditableValue