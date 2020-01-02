import StorageObject from 'ember-local-storage/local/object'

AppState = StorageObject.extend()

AppState.reopenClass(
  initialState: ->
    return {
      menuExpanded: true,
      clipboard: null
    }
)

export default AppState
