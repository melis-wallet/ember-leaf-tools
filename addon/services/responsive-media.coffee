import Service from '@ember/service'
import { later } from '@ember/runloop'
import { A } from '@ember/array'
import { dasherize, classify } from '@ember/string'
import { run } from '@ember/runloop'

ResponsiveMediaService = Service.extend(


  breakpoints:
    mobile:  '(max-width: 768px)'
    tablet:  '(min-width: 769px) and (max-width: 992px)'
    desktop: '(min-width: 993px) and (max-width: 1200px)'
    jumbo:   '(min-width: 1201px)'

  listeners: {}

  setup: (->
    for name of @breakpoints
      @match name, @breakpoints[name]


  ).on('init')

  matches: (-> A()).property()

  mql: window.matchMedia

  classNames: (->
    @get('matches').map( ->
      'media-' + dasherize(name)
    ).join(' ')
  ).property('matches.length')

  match: (name, query)->
    matcher =  (this.get('mql') || window.matchMedia)(query)
    isser = 'is' + classify(name)

    listener = (matcher) =>
      @set(name, matcher)
      @set(isser, matcher.matches)

      if matcher.matches
        @get('matches').pushObject(name)
      else
        @get('matches').removeObject(name)

    @get('listeners')[name] = listener

    if(matcher.addListener)
      matcher.addListener( ->
        run(null, listener, matcher)
      )

    listener(matcher)


)

export default ResponsiveMediaService
