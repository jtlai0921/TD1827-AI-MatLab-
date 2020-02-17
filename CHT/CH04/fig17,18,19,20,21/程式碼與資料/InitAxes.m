function InitAxes(handles)
clc;
axes(handles.axesVideo); cla reset;
set(handles.axesVideo, 'XTick', [], 'YTick', [], ...
    'XTickLabel', '', 'YTickLabel', '', 'Color', [0.7020 0.7804 1.0000], 'Box', 'On');