`import Ember from 'ember'`
`import wordlist_IT from '../../utils/wordlists/it'`


METAKEYS = [
  'foo'
  'bar'
  'baz'
  'box'
  'qaz'
]


KeywordInputController = Ember.Controller.extend(


  keys: [
    { value: 'meta', label: 'meta', payload: METAKEYS }
    { value: 'memonics', label: 'mnemonics', payload: wordlist_IT }
  ]

  currentKeys: null

  allKeys: ( -> (@get('currentKeys.payload') || METAKEYS)).property('currentKeys')

  selectedKeys: []


  actions:
    keysChanged: (array, string) ->
      console.log "Changed: ", string

)
`export default KeywordInputController`
