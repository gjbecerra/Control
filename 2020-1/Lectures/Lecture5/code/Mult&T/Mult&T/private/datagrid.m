function datagrid(x,fig_h)
%DATAGRID Build a data grid.

%   Copyright 1984-2002 The MathWorks, Inc.
%   $Revision: 1.5 $   $Date: 2002/06/08 10:13:10 $

if nargin == 0
  error('Requires data value(s) to display')
end

% if nargin == 1
%   fig_h = gcf;
% end

%Figure window spacing
bwid = 1;
bhgt = 20;
fedg = 10;
sdim = 12; 
fs = 10;
% Set the units to pixels for the grid drawing.
set(fig_h,'Units','Pixels');
FigPos = get(fig_h,'Position');

% Delete any existing grid before creating a new one.
h=findobj(gcf,'Tag','gridcell');
if ~isempty(h)
   h=[h;findobj(gcf,'Tag','rowcell')];
   h=[h;findobj(gcf,'Tag','rowheader')];
   h=[h;findobj(gcf,'Tag','colcell')];
   h=[h;findobj(gcf,'Tag','slider1')];
   h=[h;findobj(gcf,'Tag','slider2')];
   %h=[h;findobj(gcf,'Tag','colcell')];
   delete(h)
end

%Set up defaults if input structure is incomplete
if ~isstruct(x)
  x.data = x;
end
[m,n] = size(x.data);   %Determine size of data array
fns = fieldnames(x);    %Get structure field names

%Build default row and column labels
if ~any(strcmp(fns,'rowlabels'))
  rlab = x.rlab;
  x.rowlabels = cellstr([rlab(ones(m,1),:) num2str((1:m)')]);
end
if ~any(strcmp(fns,'collabels'))
  clab = x.clab;
  x.collabels = cellstr([clab(ones(n,1),:) num2str((1:n)')]);
end

%Create default rowheader if necessary
if ~any(strcmp(fns,'rowheader'))   
  x.rowheader = {''};
end

%Determine size of row label boxes
x.rowidth = 0;
rows = [x.rowheader;x.rowlabels];
for i = 1:size(rows,1);
  dummy = uicontrol('Style','text',...
		    'String',rows{i},...
             'Fontweight','bold',...
		    'Fontname','courier new',...
		    'Fontsize',fs,...
		    'Visible','off');
  ext = get(dummy,'Extent');
  x.rowidth = max(x.rowidth,ext(3)+10);
  delete(dummy)
end

%Determine width of grid cell
grcl = [x.collabels;{'xxxxx'}];
for i = 1:length(x.collabels)+1
  dummy = uicontrol('Style','text',...
		    'String',grcl{i},...
		    'Fontname','courier new',...
		    'Fontsize',fs,...
		    'Visible','on');
  ext = get(dummy,'Extent');
  bwid = max(bwid,ext(3)+10);%ancho de c/edit
  delete(dummy)
end

%Determine height of column labels boxes
x.colhgt = 0;
for i = 1:size(x.collabels,1)
  dummy = uicontrol('Style','text',...
		    'String',x.collabels{i},...
		    'Fontname','courier new',...
		    'Fontweight','bold',...
		    'Fontsize',fs,...
		    'Visible','off');
  ext = get(dummy,'Extent');
  x.colhgt = max(x.colhgt,bhgt*(ceil(ext(3)/bwid)));
  delete(dummy)
end

%Determine default margins and number of rows and columns to display
if ~any(strcmp(fns,'top'))
  x.top = FigPos(4)-fedg-x.colhgt;
end
if ~any(strcmp(fns,'left'))
  x.left = fedg;
end

if ~any(strcmp(fns,'numrows'))  %height/bhgt-collabelheight-sliderheight-fedg
  x.numrows = floor(FigPos(4)/bhgt)-ceil(x.colhgt/bhgt)-2;
end
if ~any(strcmp(fns,'numcols'))  %width/bwid-rowidth/bwid
  x.numcols = floor(FigPos(3)/bwid)-ceil(x.rowidth/bwid);
end
if x.numrows < 1 | x.numcols < 1
  error('Figure window is too small to display grid.')
end

%Convert x.data to cell array if necessary
if ~iscell(x.data)
  if isnumeric(x.data)
    x.data = fix(round(1000*x.data))/1000;
    x.data = num2cell(x.data);
  else
    x.data = cellstr(x.data);
  end  
end

%Trap bad inputs
[rd,cd] = size(x.data);
if x.numrows > rd
  x.numrows = rd;
end
if x.numcols > cd
  x.numcols = cd;
end

%Build position grid
r = (1:x.numrows)';
c = 1:x.numcols;
r = r(:,ones(1,x.numcols));
c = c(ones(x.numrows,1),:);

%Build grid position matrix
pos=[x.left+x.rowidth+bwid.*(c(:)-1) x.top-bhgt.*r(:) ...
     bwid(ones(size(c(:)))) bhgt(ones(size(r(:))))]; 

%Build grid
for i = 1:size(pos,1)
  ug(i) = uicontrol('Style','edit',...
		    'Tag','gridcell',...
		    'Horizontalalignment','right',...
		    'Backgroundcolor','white',...
            'max',1,...
		    'Foregroundcolor','blue',...
		    'Fontname','courier new',...
		    'Fontsize',fs,...
		    'Position',pos(i,:));
end

%Build row labels
for i = 1:x.numrows
  ur(i) = uicontrol('Style','edit',...
		    'Tag','rowcell',...
            'Backgroundcolor','white',...
		    'Foregroundcolor','blue',...
		    'Fontname','courier new',...
             'Fontweight','bold',...
		    'Fontsize',fs,...
            'visible','on',...
		    'Horizontalalignment','center',...
		    'Position',[pos(i,1)-x.rowidth pos(i,2) x.rowidth bhgt]);
end

%Build row header
if ~isempty(char(x.rowheader))
  rh = uicontrol('Style','edit',...
		 'String',x.rowheader,...
		 'Tag','rowheader',...
		 'Backgroundcolor','white',...
		 'Foregroundcolor','red',...
		 'Fontname','courier new',...
         'Fontweight','bold',...
		 'Fontsize',fs,...
		 'Horizontalalignment','center',...
		 'Userdata',1,...
         'visible','on',...
		 'Position',[pos(1,1)-x.rowidth pos(1,2)+bhgt x.rowidth x.colhgt]);
     
end

%Build column labels
for i = 1:x.numcols
  uc(i) = uicontrol('Style','edit',...
		    'Tag','colcell',...
		    'Backgroundcolor','white',...
		    'Foregroundcolor','blue',...
		    'Fontname','courier new',...
             'Fontweight','bold',...
		    'Fontsize',fs,...
		    'Horizontalalignment','center',...
		    'Userdata',i+1,...
            'visible','on',...
		    'Max',1,...
		    'Position',[pos(i+(i-1)*(x.numrows-1),1) x.top bwid x.colhgt]);
end

slidmin = m-x.numrows+1;
if ~(1/slidmin >= 1)
  s(1) = uicontrol('Style','slider',...
		   'Tag','slider1',...
		   'Callback','datagrid_cb slider1',...
		   'Min',-slidmin,...
		   'Max',-1,...
		   'Value',-1,...
		   'Sliderstep',[1/(slidmin-1)-eps 1/(slidmin-1)],...
		   'Userdata',{x.data x.rowlabels x.numrows x.numcols},...
		   'Position',... 
		   [x.left+x.rowidth+bwid*x.numcols pos(x.numrows,2) ...
		    sdim bhgt*x.numrows]);
end

slidmax = n-x.numcols+1;
if ~(1/slidmax >= 1)
  s(2) = uicontrol('Style','slider',...
		   'Tag','slider2',...
		   'Callback','datagrid_cb slider2',...
		   'Min',1,...
		   'Max',slidmax,...
		   'Value',1,...
		   'Sliderstep',[1/(slidmax-1)-eps 1/(slidmax-1)],...
		   'Userdata',{x.data x.collabels x.numrows x.numcols},...
		   'Position',... 
		   [x.left+x.rowidth pos(x.numrows,2)-sdim bwid*x.numcols sdim]);
end

%Fill grid with appropriate text
newdata = x.data(1:x.numrows,1:x.numcols);
newdata = newdata(:);
set(ug,{'String'},newdata)
set(ur,{'String'},x.rowlabels(1:x.numrows))
set(uc,{'String'},x.collabels(1:x.numcols))
%set(fig_h,'Userdata',x)
%set(findobj(fig_h,'Type','uicontrol'),'Units','normal')