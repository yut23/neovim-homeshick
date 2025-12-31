if exists(':GuiFont')
  if has('win32')
    GuiFont SourceCodeVF:h10
  else
    GuiFont Source Code Pro:h10:l
  endif
endif
if exists(':GuiTabline')
  GuiTabline 0
endif
if exists(':GuiPopupmenu')
  GuiPopupmenu 0
endif
