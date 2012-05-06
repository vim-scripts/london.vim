" Vim syntax file
" Language:	London template
" Maintainer:	Thiago Avelino <thiagoavelinoster@gmail.com>
" Last Change:	2012 May 06

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

if !exists("main_syntax")
    let main_syntax = 'html'
endif

syntax case match

" Mark illegal characters
syn match londonError "%}\|}}\|#}"

" london template built-in tags and parameters
" 'comment' doesn't appear here because it gets special treatment
syn keyword londonStatement contained autoescape csrf_token empty
" FIXME ==, !=, <, >, <=, and >= should be londonStatements:
" syn keyword londonStatement contained == != < > <= >=
syn keyword londonStatement contained and as block endblock by cycle debug else elif
syn keyword londonStatement contained extends filter endfilter firstof for
syn keyword londonStatement contained endfor if endif ifchanged endifchanged
syn keyword londonStatement contained ifequal endifequal ifnotequal
syn keyword londonStatement contained endifnotequal in include load not now or
syn keyword londonStatement contained parsed regroup reversed spaceless
syn keyword londonStatement contained endspaceless ssi templatetag openblock
syn keyword londonStatement contained closeblock openvariable closevariable
syn keyword londonStatement contained openbrace closebrace opencomment
syn keyword londonStatement contained closecomment widthratio url with endwith
syn keyword londonStatement contained get_current_language trans noop blocktrans
syn keyword londonStatement contained endblocktrans get_available_languages
syn keyword londonStatement contained get_current_language_bidi plural

" london templete built-in filters
syn keyword londonFilter contained add addslashes capfirst center cut date
syn keyword londonFilter contained default default_if_none dictsort
syn keyword londonFilter contained dictsortreversed divisibleby escape escapejs
syn keyword londonFilter contained filesizeformat first fix_ampersands
syn keyword londonFilter contained floatformat get_digit join last length length_is
syn keyword londonFilter contained linebreaks linebreaksbr linenumbers ljust
syn keyword londonFilter contained lower make_list phone2numeric pluralize
syn keyword londonFilter contained pprint random removetags rjust slice slugify
syn keyword londonFilter contained safe safeseq stringformat striptags
syn keyword londonFilter contained time timesince timeuntil title truncatechars
syn keyword londonFilter contained truncatewords truncatewords_html unordered_list upper urlencode
syn keyword londonFilter contained urlize urlizetrunc wordcount wordwrap yesno

" Keywords to highlight within comments
syn keyword londonTodo contained TODO FIXME XXX

" Keywords to highlight within London Themplate
syn keyword londonThemplate contained base piece container mirroring 

" london template constants (always surrounded by double quotes)
syn region londonArgument contained start=/"/ skip=/\\"/ end=/"/

" Mark illegal characters within tag and variables blocks
syn match londonTagError contained "#}\|{{\|[^%]}}\|[&#]"
syn match londonVarError contained "#}\|{%\|%}\|[<>!&#%]"

" london template tag and variable blocks
syn region londonTagBlock start="{%" end="%}" contains=londonStatement,londonThemplate,londonFilter,londonArgument,londonTagError display
syn region londonVarBlock start="{{" end="}}" contains=londonFilter,londonArgument,londonVarError display

" london template 'comment' tag and comment block
syn region londonComment start="{%\s*comment\s*%}" end="{%\s*endcomment\s*%}" contains=londonTodo
syn region londonComBlock start="{#" end="#}" contains=londonTodo

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_london_syn_inits")
  if version < 508
    let did_london_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink londonTagBlock PreProc
  HiLink londonVarBlock PreProc
  HiLink londonStatement Statement
  HiLink londonFilter Identifier
  HiLink londonArgument Constant
  HiLink londonTagError Error
  HiLink londonVarError Error
  HiLink londonError Error
  HiLink londonComment Comment
  HiLink londonComBlock Comment
  HiLink londonTodo Todo

  delcommand HiLink
endif

let b:current_syntax = "london"
