" Aditional syntax conceal
syntax match HeaderHide '^#\{1,6}\ ' containedin=VimwikiHeader1,VimwikiHeader2,VimwikiHeader3,VimwikiHeader4,VimwikiHeader5,VimwikiHeader6 contained conceal
syntax match CheckBoxNo '-\ \[\ \]' containedin=VimwikiListTodo contained conceal cchar=
syntax match CheckBoxNo '-\ \[x\]' containedin=VimwikiListTodo contained conceal cchar=
