import React from 'react'
import { render } from 'react-dom'
import Editor from './editor'

// init Swiper:
const swiper = new Swiper('.swiper-container ');

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
