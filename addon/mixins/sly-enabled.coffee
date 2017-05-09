`import Ember from 'ember'`

SlyEnabled = Ember.Mixin.create(Ember.Evented,

  #
  #
  #
  sly_default_options: {
      smart: true,
      scrollBy: 100
      speed: 300,
      mouseDragging: true
      touchDragging: true
      releaseSwing: true
      elasticBounds: true
      dragHandle: true
      dynamicHandle: true
    }

  sly_options: Ember.computed -> Ember.Object.create(@sly_default_options)


  #
  #
  #
  shown: true

  #
  #
  #
  height: null

  #
  #
  'max-height': null

  #
  #
  'fill-container': false


  #
  # stay
  #
  'follow-bottom': false

  _handleDebouncedResizeEvent: ->
    @.$('.frame').height( @.$().height() )
    @reloadSly()


  initializeSly: (->
    if @get('shown')
      Ember.run.scheduleOnce 'afterRender', this, @_initializeSly
  ).on('didInsertElement')

  refresh: (->
    if @get('shown') && Ember.isBlank(@_slyFrame)
      Ember.run.scheduleOnce 'afterRender', this, @_initializeSly
  ).observes('shown')

  _initializeSly: ->

    self = @

    @get('resizeService').on('debouncedDidResize', this, @_handleDebouncedResizeEvent)

    elem = @.$('.sly')

    @slyResizeToHeight()
    if @get('fill-container')
      @.$('.frame').height( @.$().height() )

    options = @get('sly_options')

    options.scrollBar ||= elem.find('.scrollbar')
    frame = new Sly(elem, options)

    @_slyFrame = frame

    frame.on('load moveEnd', ->
      $(@frame).find('.scrollbar').stop().fadeOut(600)
    )

    frame.on('moveStart', (ev)->
      if (@pos.dest != @pos.cur)
        $(@frame).find('.scrollbar').stop().fadeIn(200)
    )

    frame.on('change', (ev) ->
      self.trigger('changed', ev, @pos)
      if (@pos.dest > @pos.end - 200)
        self.trigger('bottom-scroll', @pos)
      else if (@pos.dest < @pos.start + 30)
        self.trigger('top-scroll', @pos)
    )

    frame.init()

  reloadSly: (->
    Ember.run.scheduleOnce 'afterRender', this, @_reloadSly
  ).observes('height')

  _slyResizeToHeight: (->
    if h = @get('max-height')
      if (slidee_h = @.$('.slidee')?.height()) <= h
        @.$('.sly')?.height(slidee_h)
      else
        @.$('.sly')?.height(h)
    else if h = @get('height')
      @.$('.sly')?.height(h)
  )

  _reloadSly: ->
    if @_slyFrame
      @_slyFrame.reload()
  #    @_slyFrame.slideTo(0)

  slyResizeToHeight: ->
    Ember.run.scheduleOnce 'afterRender', this, @_slyResizeToHeight


  slyContentChanged: ->
    @slyResizeToHeight()
    @reloadSly()
    Ember.run.scheduleOnce 'afterRender', this, @_slideToEnd

  _slideToEnd: ->
    @_slyFrame.toEnd() if @get('follow-bottom')

  slyCleanUp: (->
    @get('resizeService').off('debouncedDidResize', this, @_handleDebouncedResizeEvent)
    @_slyFrame.destroy() if @_slyFrame
  ).on('willDestroyElement')


)

`export default SlyEnabled`
