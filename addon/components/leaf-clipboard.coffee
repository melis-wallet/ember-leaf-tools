`import Ember from 'ember'`
`import TypeSupport from 'ember-leaf-core/mixins/leaf-type-support'`
`import SizeSupport from 'ember-leaf-core/mixins/leaf-size-support'`
`import TooltipSupport from 'ember-leaf-core/mixins/leaf-tooltip-support'`
`import { storageFor } from 'ember-local-storage'`
`import layout from 'ember-leaf-tools/templates/components/leaf-clipboard'`

LeafClipboard = Ember.Component.extend(TypeSupport, SizeSupport, TooltipSupport,
  layout: layout

  tagName: 'button'

  attributeBindings: [
    'content:data-clipboard-text',
    'target:data-clipboard-target',
    'action:data-clipboard-action',
    'type:type',
    'disabled'
  ]

  classNames: ['btn', 'clipboard']
  classNameBindings: ['block:btn-block', 'outline:btn-outline', 'hadSuccess:success']
  classTypePrefix: 'btn'

  copyIcon: 'fa fa-copy'
  pasteIcon: 'fa fa-clipboard'

  content: null

  receiver: false
  native: true

  appstate: storageFor('leaf-app-state')
  appClip: Ember.computed.alias('appstate.clipboard')

  clipboardEvents: ['success', 'error']

  icon: (->
    if @get('receiver') then @get('pasteIcon')
    else @get('copyIcon')
  ).property()


  onClick: (->
    @set('hadSuccess', false)
    if @get('receiver')
      if data = @get('appClip')
        @set('content', data)
    else
      if content = @get('content')
        @set('appClip', content)

  ).on('click', 'touchEnd')


  setupNativeClip: ->
    el= @get('elementId')
    clipboard = new Clipboard("##{el}")
    @set('clipboard', clipboard)

    @get('clipboardEvents').forEach((action) =>
      clipboard.on(action, Ember.run.bind(this, (e) ->
        try
          @trigger(action)
          @sendAction(action, e)
        catch error
          Ember.Logger.debug(error.message)
      ))
    )

  setSuccess: ( ->
    @set('hadSuccess', true)
  ).on('success')

  clearSuccess: ( ->
    @set('hadSuccess', false)
  ).observes('content', 'target')

  setup: ( ->
    @setupNativeClip() if @get('native') && !@get('receiver')
  ).on('didInsertElement')

  teardown: (->
    clipboard.destroy if (clipboard = @get('clipboard'))
  ).on('willDestroyElement')
)

`export default LeafClipboard`
