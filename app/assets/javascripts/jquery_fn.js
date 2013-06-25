/*Credits: http://stackoverflow.com/questions/946534/insert-text-into-textarea-with-jquery*/
/*global jQuery, document */
jQuery.fn.extend({
  insertAtCaret: function (myValue) {
    return this.each(function (i) {
      var sel, startPos, endPos, scrollTop;

      if (document.selection) {
        //For browsers like Internet Explorer
        this.focus();
        sel = document.selection.createRange();
        sel.text = myValue;
        this.focus();
      } else if (this.selectionStart || this.selectionStart === '0') {
        //For browsers like Firefox and Webkit based
        startPos = this.selectionStart;
        endPos = this.selectionEnd;
        scrollTop = this.scrollTop;

        this.focus();
        this.value = this.value.substring(0, startPos) + myValue + this.value.substring(endPos, this.value.length);
        this.selectionStart = startPos + myValue.length;
        this.selectionEnd = startPos + myValue.length;
        this.scrollTop = scrollTop;
      } else {
        //Setting the focus before setting the value is the key to get it work in Chrome.
        this.focus();
        this.value += myValue;
      }
    });
  }
});
