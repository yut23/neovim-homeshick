if exists(':GuiFont')
  if hostname() ==? 'xrb'
    GuiFont Source Code Pro:h10:l
  else
    GuiFont Source Code Pro:h9:l
  endif
endif
if exists(':GuiTabline')
  GuiTabline 0
endif
if exists(':GuiPopupmenu')
  GuiPopupmenu 0
endif
