import React from 'react'
import { render } from 'react-dom'
import Editor from './editor'
// import Swiper bundle with all modules installed
import Swiper from 'swiper/bundle';
// import styles bundle
import 'swiper/css/bundle';
// init Swiper:
const swiper = new Swiper(...);

(function ($, undefined) {
  $.fn.articleBlockEditor = function () {
    this.each((i, elm) => {
      const editorBody = elm.querySelector('.editor-body')
      const textarea = elm.querySelector('textarea')

      const onChange = value => {
        textarea.value = value
      }

      render(
        <Editor
          value={textarea.value}
          onChange={onChange}
        />,
        editorBody
      )
    })
  }
})(jQuery)
