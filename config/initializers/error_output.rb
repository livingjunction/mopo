ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
  html = %(<div class="field_with_errors">#{html_tag}</div>).html_safe
  
  form_fields = [
    'textarea',
    'input',
    'select'
  ]
 
  elements = Nokogiri::HTML::DocumentFragment.parse(html_tag).css form_fields.join(', ')
  
  elements.each do |e|
    if form_fields.include? e.node_name
      if instance.error_message.kind_of?(Array)
        html = %(<div class="field_with_errors">#{html_tag}<span class="help-inline">&nbsp;#{instance.error_message.join(',')}</span></div>).html_safe
      else
        html = %(<div class="field_with_errors">#{html_tag}<span class="help-inline">&nbsp;#{instance.error_message}</span></div>).html_safe
      end
    end
  end
  html
end