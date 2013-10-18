module Redmine
  module SyntaxHighlighting
    module JsSyntaxHighlighter
      SETTING_KEY_THEME = "JsSyntaxHighlighter Theme"
      DEFAULT_THEME = "Default"
      THEMES = %w[
        Default
        Django
        Eclipse
        Emacs
        FadeToGrey
        Midnight
        RDark
      ]
      
      class << self     
        def highlight_by_filename(text, filename)
          # I don't see a way how to use JavaScript highlighter
          Redmine::SyntaxHighlighting::CodeRay.highlight_by_filename(text, filename)
          #language = File.extname(filename)			
          # "<pre class=\"brush: " + language[1..-1] + "\">" + text.gsub("<", "&lt;") + ""
        end
        
        def highlight_by_language(text, language)
          # TODO how to select by brush class, so we don't need jsh
          "<pre class=\"jsh brush: " + language + "\">" + text.gsub("<", "&lt;") + "</pre>"
          #"</code></pre><pre class=\"brush: " + language + "\">" + text.gsub("<", "&lt;") + "</pre><pre><code>"			
        end
        
        def theme
          # return user setting for theme
          user_theme = User.current.custom_value_for(CustomField.first(:conditions => {:name => Redmine::SyntaxHighlighting::JsSyntaxHighlighter::SETTING_KEY_THEME}))
          user_theme || self::DEFAULT_THEME
        end
      end
      
      class Assets < Redmine::Hook::ViewListener
        def view_layouts_base_html_head(context)
          js = "SyntaxHighlighter.all();"

          o = ""
          o << javascript_include_tag("shCore.js", :plugin => "redmine_js_syntax_highlighter")
          # o << javascript_include_tag("javascriopt/shAutoloader.js")
          o << javascript_include_tag("shBrushAS3.js", :plugin => "redmine_js_syntax_highlighter")
          o << javascript_include_tag("shBrushAppleScript.js", :plugin => "redmine_js_syntax_highlighter")
          o << javascript_include_tag("shBrushBash.js", :plugin => "redmine_js_syntax_highlighter")
          o << javascript_include_tag("shBrushCSharp.js", :plugin => "redmine_js_syntax_highlighter")
          o << javascript_include_tag("shBrushColdFusion.js", :plugin => "redmine_js_syntax_highlighter")
          o << javascript_include_tag("shBrushCpp.js", :plugin => "redmine_js_syntax_highlighter")
          o << javascript_include_tag("shBrushCss.js", :plugin => "redmine_js_syntax_highlighter")
          o << javascript_include_tag("shBrushDelphi.js", :plugin => "redmine_js_syntax_highlighter")
          o << javascript_include_tag("shBrushDiff.js", :plugin => "redmine_js_syntax_highlighter")
          o << javascript_include_tag("shBrushErlang.js", :plugin => "redmine_js_syntax_highlighter")
          o << javascript_include_tag("shBrushGroovy.js", :plugin => "redmine_js_syntax_highlighter")
          o << javascript_include_tag("shBrushJScript.js", :plugin => "redmine_js_syntax_highlighter")
          o << javascript_include_tag("shBrushJava.js", :plugin => "redmine_js_syntax_highlighter")
          o << javascript_include_tag("shBrushJavaFX.js", :plugin => "redmine_js_syntax_highlighter")
          o << javascript_include_tag("shBrushPerl.js", :plugin => "redmine_js_syntax_highlighter")
          o << javascript_include_tag("shBrushPhp.js", :plugin => "redmine_js_syntax_highlighter")
          o << javascript_include_tag("shBrushPlain.js", :plugin => "redmine_js_syntax_highlighter")
          o << javascript_include_tag("shBrushPowerShell.js", :plugin => "redmine_js_syntax_highlighter")
          o << javascript_include_tag("shBrushPython.js", :plugin => "redmine_js_syntax_highlighter")
          o << javascript_include_tag("shBrushRuby.js", :plugin => "redmine_js_syntax_highlighter")
          o << javascript_include_tag("shBrushSass.js", :plugin => "redmine_js_syntax_highlighter")
          o << javascript_include_tag("shBrushScala.js", :plugin => "redmine_js_syntax_highlighter")
          o << javascript_include_tag("shBrushSql.js", :plugin => "redmine_js_syntax_highlighter")
          o << javascript_include_tag("shBrushVb.js", :plugin => "redmine_js_syntax_highlighter")
          o << javascript_include_tag("shBrushXml.js", :plugin => "redmine_js_syntax_highlighter")
          o << stylesheet_link_tag("shCore#{Redmine::SyntaxHighlighting::JsSyntaxHighlighter.theme}.css", :plugin => "redmine_js_syntax_highlighter")
          o << javascript_tag(js)
          o
        end
      end
    end
  end
end
