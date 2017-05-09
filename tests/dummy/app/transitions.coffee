
Transitions = ->

  @transition(
    @toRoute 'notifications'
    @use 'toLeft'
  )

  @transition(
    @toRoute 'index'
    @use 'toRight'
  )


  @transition(
    @hasClass('ll-down-up')
    @toValue(true)
    @use('toDown')
    @reverse('toUp')
  )


`export default Transitions`