`import Ember from 'ember'`

Scheduler = Ember.Object.extend(

  interval: 5000
  timer: null

  reSchedule: (fn) ->
    Ember.run.later( this, (->
      fn.apply(this)
      @set('timer', @reSchedule(fn))
    ), @get('interval'))

  stop: ->
    if timer = @get('timer')
      Ember.run.cancel(timer)
      @set('timer', null)

  schedule: (fn, interval) ->
    unless @get('timer')
      @set('interval', interval) if !Ember.isBlank(interval)
      @set('timer', @reSchedule(fn))
)

`export default Scheduler`
