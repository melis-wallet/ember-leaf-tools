
`import Ember from 'ember'`
`import { storageFor } from 'ember-local-storage'`

AppStateService = Ember.Service.extend(

  media: Ember.inject.service('responsive-media')

  store: storageFor('leaf-app-state')

  #
  #
  #
  theme: 'theme-default'

  #
  # the main menu is currently expanded
  #
  menuExpanded: Ember.computed.alias('store.menuExpanded')

  #
  # menu is fixed or scrolling
  #
  menuFixed: true

  #
  # navbar is fixed or scrolling
  #
  navbarFixed: true


  #
  #
  #
  mediaHasChanged: (->
    if (@get('media.isMobile') || @get('media.isTablet'))
      @set('menuExpanded', false)
    else
      @set('menuExpanded', true)
  ).observes('media.isMobile', 'media.isTablet').on('init')


  routingStateChanged:(->
    if (@get('media.isMobile'))
      @set('menuExpanded', false)
  )


)
`export default AppStateService`
