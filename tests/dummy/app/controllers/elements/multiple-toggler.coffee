import Controller from '@ember/controller'
import wordlist_IT from '../../utils/wordlists/it'


MultipleToggler = Controller.extend(

  options: [
    {value: 'one', label: 'one', icon: 'fa fa-code'}
    {value: 'two', label: 'two', icon: 'fa fa-vcard'}
    {value: 'three', label: 'three', icon: 'fa fa-share-square'}
  ]


  optionsLabels: [
    {value: 'it', label: 'IT'}
    {value: 'en', label: 'EN'}
    {value: 'de', label: 'DE'}
    {value: 'cn', label: 'CN'}
  ]

  selected: null
  selectedLabels: null

)

export default MultipleToggler
