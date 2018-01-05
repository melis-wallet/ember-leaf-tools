`import Ember from 'ember'`
`import config from './config/environment'`

Router = Ember.Router.extend(
  location: config.locationType
)

Router.map ->
  @route 'elements', ->
    @route 'tabs'
    @route 'editvalue'
    @route 'keywordinput'
    @route 'multiple-toggler'
    @route 'labels'
    @route 'treeview'


`export default Router`
