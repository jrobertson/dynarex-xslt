#!/usr/bin/env ruby

# file: recordx-xslt.rb

require 'rexle-builder'
require 'rexle'

class DynarexXSLT
  
  attr_accessor :schema, :xslt_schema

  def initialize(options={})
    o = {schema: '', xslt_schema: ''}.merge(options)
    @schema, @xslt_schema = o.values
  end

  def to_xslt()

    a_element = @schema.split('/').map{|x| x[/\w+/]}

    a_html = @xslt_schema.split('/').map do |x|
        
      name = x[/\w+/]
      children = ($')[/^[\(\[]([^\)\]]+)[\)\]]$/,1]
      list = children.split(',').map {|y| y.split(':') } if children

      [name, list]
    end

    a = a_element.zip(a_html)

    xml = RexleBuilder.new
    raw_a = xml.xsl_stylesheet(xmlns_xsl: "http://www.w3.org/1999/XSL/Transform", version: "1.0") do
      xml.xsl_output(method: "xml", indent: "yes")

      xml.xsl_template(match: a[0][0]) do
        xml.send a[0][1][0].to_sym do
          xml.xsl_apply_templates(select: 'summary')
          xml.xsl_apply_templates(select: 'records/' + a[1][0])
        end 
      end

      xml.xsl_template(match: a[0][0] + '/summary') do
        summary_fields = a[0][1][1] || []
        summary_fields.each do |element, field|
          xml.send (element.strip).to_sym do
            xml.xsl_value_of(select: field)
          end
        end
      end

      xml.xsl_template(match: 'records/' + a[1][0]) do
        xml.send a[1][1][0].to_sym do
          a[1][1][1].each do |element, field|
            xml.send element.to_sym do
              xml.xsl_value_of(select: field)
            end
          end      
        end
      end

    end
    
    Rexle.new(raw_a).xml(pretty: true).gsub('xsl_apply_templates',\
        'xsl:apply-templates').gsub('xsl_value_of','xsl:value-of').\
        gsub('xsl_template','xsl:template').gsub('xsl_','xsl:').\
        gsub('xmlns_xsl','xmlns:xsl')

  end
  
end
