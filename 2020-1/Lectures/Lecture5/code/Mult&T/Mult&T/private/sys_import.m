function varargout = sys_import(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @sys_import_OpeningFcn, ...
                   'gui_OutputFcn',  @sys_import_OutputFcn, ...
                   'gui_LayoutFcn',  @sys_import_LayoutFcn, ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end

function h1 = sys_import_LayoutFcn(policy)
persistent hsingleton;
if strcmpi(policy, 'reuse') & ishandle(hsingleton)
    h1 = hsingleton;
    return;
end

appdata = [];
appdata.GUIDEOptions = struct(...
    'active_h', 201.04150390625, ...
    'taginfo', struct(...
    'figure', 2, ...
    'uipanel', 9, ...
    'text', 10, ...
    'edit', 7, ...
    'radiobutton', 10, ...
    'listbox', 7, ...
    'pushbutton', 10, ...
    'axes', 2), ...
    'override', 0, ...
    'release', 13, ...
    'resize', 'none', ...
    'accessibility', 'callback', ...
    'mfile', 1, ...
    'callbacks', 1, ...
    'singleton', 1, ...
    'syscolorfig', 1, ...
    'blocking', 0);
appdata.lastValidTag = 'import';
appdata.GUIDELayoutEditor = [];
ssize=get(0,'ScreenSize');
if isequal(ssize(3),1280)&&isequal(ssize(4),800)
    pos=[365 318 550 280];
elseif isequal(ssize(3),1280)&&isequal(ssize(4),768)
     pos=[365 297 550 280];
elseif isequal(ssize(3),1024)&&isequal(ssize(4),768)
    pos=[237 297 550 280];
elseif isequal(ssize(3),800)&&isequal(ssize(4),600)
    pos=[125   153   550   280];
elseif isequal(ssize(3),1280)&&isequal(ssize(4),1024)
    pos=[365 496 550 280];
else
    pos=[365 468 550 280];
end
h1 = figure(...
'Units','pixels',...
'Color',[0.941176470588235 0.941176470588235 0.941176470588235],...
'Colormap',[0 0 0.5625;0 0 0.625;0 0 0.6875;0 0 0.75;0 0 0.8125;0 0 0.875;0 0 0.9375;0 0 1;0 0.0625 1;0 0.125 1;0 0.1875 1;0 0.25 1;0 0.3125 1;0 0.375 1;0 0.4375 1;0 0.5 1;0 0.5625 1;0 0.625 1;0 0.6875 1;0 0.75 1;0 0.8125 1;0 0.875 1;0 0.9375 1;0 1 1;0.0625 1 1;0.125 1 0.9375;0.1875 1 0.875;0.25 1 0.8125;0.3125 1 0.75;0.375 1 0.6875;0.4375 1 0.625;0.5 1 0.5625;0.5625 1 0.5;0.625 1 0.4375;0.6875 1 0.375;0.75 1 0.3125;0.8125 1 0.25;0.875 1 0.1875;0.9375 1 0.125;1 1 0.0625;1 1 0;1 0.9375 0;1 0.875 0;1 0.8125 0;1 0.75 0;1 0.6875 0;1 0.625 0;1 0.5625 0;1 0.5 0;1 0.4375 0;1 0.375 0;1 0.3125 0;1 0.25 0;1 0.1875 0;1 0.125 0;1 0.0625 0;1 0 0;0.9375 0 0;0.875 0 0;0.8125 0 0;0.75 0 0;0.6875 0 0;0.625 0 0;0.5625 0 0],...
'IntegerHandle','off',...
'InvertHardcopy',get(0,'defaultfigureInvertHardcopy'),...
'MenuBar','none',...
'Name','Import System',...
'NumberTitle','off',...
'Position',pos,...
'Renderer',get(0,'defaultfigureRenderer'),...
'RendererMode','manual',...
'Resize','on',...
'HandleVisibility','on',...
'Tag','import',...
'UserData',[],...
'Visible','on',...
'WindowStyle','modal',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );

appdata = [];
appdata.lastValidTag = 'uipanel1';

h2 = uipanel(...
'Parent',h1,...
'Units','characters',...
'HighlightColor',[0 0 0],...
'Title','System Name',...
'Tag','uipanel1',...
'Clipping','on',...
'Position',[2.4 17.3846153846154 49.6 3.76923076923077],...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );

appdata = [];
appdata.lastValidTag = 'text1';

h3 = uicontrol(...
'Parent',h2,...
'Units','characters',...
'HorizontalAlignment','left',...
'Position',[2.2 0.769230769230769 10.2 1.38461538461538],...
'String','Name :',...
'Style','text',...
'Tag','text1',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );

appdata = [];
appdata.lastValidTag = 'edit1';

h4 = uicontrol(...
'Parent',h2,...
'Units','characters',...
'BackgroundColor',[1 1 1],...
'HorizontalAlignment','left',...
'Position',[9.8 0.692307692307693 30.4 1.61538461538462],...
'String','Untitled',...
'Style','edit',...
'Tag','edit1',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );

appdata = [];
appdata.lastValidTag = 'uipanel6';

h5 = uipanel(...
'Parent',h1,...
'Units','characters',...
'HighlightColor',[0 0 0],...
'Title','System Data',...
'Tag','uipanel6',...
'Clipping','on',...
'Position',[60.2 2.23076923076923 46.6 19],...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );

appdata = [];
appdata.lastValidTag = 'axes1';

h6 = axes(...
'Parent',h5,...
'Units','characters',...
'Position',[1.6 10.6153846153846 42.8 7.07692307692308],...
'Box','on',...
'CameraPosition',[0.5 0.5 9.16025403784439],...
'CameraPositionMode',get(0,'defaultaxesCameraPositionMode'),...
'Color',get(0,'defaultaxesColor'),...
'ColorOrder',get(0,'defaultaxesColorOrder'),...
'LooseInset',[13.754 2.43692307692308 10.051 1.66153846153846],...
'XColor',get(0,'defaultaxesXColor'),...
'YColor',get(0,'defaultaxesYColor'),...
'ZColor',get(0,'defaultaxesZColor'),...
'SelectionHighlight','off',...
'Xlim',[0.5 469.5],...
'Ylim',[0.5 180.5],...
'YDir','reverse', ...
'Visible','off', ...
'Tag','axes1',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );


appdata = [];
appdata.lastValidTag = 'other';

h11 = uicontrol(...
'Parent',h5,...
'Units','characters',...
'Callback','sys_import(''other_Callback'',gcbo,[],guidata(gcbo))',...
'Position',[31.8 10.6153846153846 12 1.53846153846154],...
'String','others...',...
'Tag','other',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );

appdata = [];
appdata.lastValidTag = 'text4';

h12 = uicontrol(...
'Parent',h5,...
'Units','characters',...
'Position',[2.6 8.30769230769231 6 1],...
'String','A =',...
'Style','text',...
'Tag','text4',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );

appdata = [];
appdata.lastValidTag = 'text5';

h13 = uicontrol(...
'Parent',h5,...
'Units','characters',...
'Position',[2.6 6.30769230769231 6 1],...
'String','B =',...
'Style','text',...
'Tag','text5',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );

appdata = [];
appdata.lastValidTag = 'text6';

h14 = uicontrol(...
'Parent',h5,...
'Units','characters',...
'Position',[2.6 4.30769230769231 6 1],...
'String','C =',...
'Style','text',...
'Tag','text6',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );

appdata = [];
appdata.lastValidTag = 'text7';

h15 = uicontrol(...
'Parent',h5,...
'Units','characters',...
'Position',[2.6 2.30769230769231 6 1],...
'String','D =',...
'Style','text',...
'Tag','text7',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );

appdata = [];
appdata.lastValidTag = 'edit3';

h16 = uicontrol(...
'Parent',h5,...
'Units','characters',...
'BackgroundColor',[1 1 1],...
'Position',[11.2 7.92307692307692 26.8 1.61538461538462],...
'Style','edit',...
'Tag','edit3',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );

appdata = [];
appdata.lastValidTag = 'edit4';

h17 = uicontrol(...
'Parent',h5,...
'Units','characters',...
'BackgroundColor',[1 1 1],...
'Position',[11.2 6 26.8 1.61538461538462],...
'Style','edit',...
'Tag','edit4',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );

appdata = [];
appdata.lastValidTag = 'edit5';

h18 = uicontrol(...
'Parent',h5,...
'Units','characters',...
'BackgroundColor',[1 1 1],...
'Position',[11.2 4.07692307692308 26.8 1.61538461538462],...
'Style','edit',...
'Tag','edit5',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );

appdata = [];
appdata.lastValidTag = 'edit6';

h19 = uicontrol(...
'Parent',h5,...
'Units','characters',...
'BackgroundColor',[1 1 1],...
'Position',[11.2 2.15384615384615 26.8 1.61538461538462],...
'Style','edit',...
'Tag','edit6',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );

appdata = [];
appdata.lastValidTag = 'text8';

h20 = uicontrol(...
'Parent',h5,...
'Units','characters',...
'Position',[5.2 0.769230769230769 38 1.1],...
'String','State - Space',...
'Style','text',...
'Tag','text8',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );

appdata = [];
appdata.lastValidTag = 'okay';

h21 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'Callback','sys_import(''okay_Callback'',gcbo,[],guidata(gcbo))',...
'Enable','off',...
'Position',[60.2 0.461538461538462 13 1.53846153846154],...
'String','OK',...
'Tag','okay',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );

appdata = [];
appdata.lastValidTag = 'cancel';

h22 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'Callback','sys_import(''cancel_Callback'',gcbo,[],guidata(gcbo))',...
'Position',[76.6 0.384615384615385 13 1.53846153846154],...
'String','Cancel',...
'Tag','cancel',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );

appdata = [];
appdata.lastValidTag = 'help';

h23 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'Callback','sys_import(''help_Callback'',gcbo,[],guidata(gcbo))',...
'Position',[93.4 0.384615384615385 13 1.53846153846154],...
'String','Help',...
'Tag','help',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );

appdata = [];
appdata.lastValidTag = 'ba';

h24 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'Callback','sys_import(''ba_Callback'',gcbo,[],guidata(gcbo))',...
'Position',[53.4 10.2307692307692 5 1.38461538461538],...
'String','-->',...
'Tag','ba',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );

appdata = [];
appdata.lastValidTag = 'bb';

h25 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'Callback','sys_import(''bb_Callback'',gcbo,[],guidata(gcbo))',...
'Position',[53.4 8.30769230769231 5 1.38461538461538],...
'String','-->',...
'Tag','bb',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );

appdata = [];
appdata.lastValidTag = 'bc';

h26 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'Callback','sys_import(''bc_Callback'',gcbo,[],guidata(gcbo))',...
'Position',[53.4 6.38461538461539 5 1.38461538461538],...
'String','-->',...
'Tag','bc',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );

appdata = [];
appdata.lastValidTag = 'bd';

h27 = uicontrol(...
'Parent',h1,...
'Units','characters',...
'Callback','sys_import(''bd_Callback'',gcbo,[],guidata(gcbo))',...
'Position',[53.2 4.46153846153846 5 1.38461538461538],...
'String','-->',...
'Tag','bd',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );

appdata = [];
appdata.lastValidTag = 'uipanel8';

h28 = uipanel(...
'Parent',h1,...
'Units','characters',...
'HighlightColor',[0.250980392156863 0 0.250980392156863],...
'Title','Import from',...
'Tag','uipanel8',...
'Clipping','on',...
'Position',[2.6 2.46153846153846 49.6 14],...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );

appdata = [];
appdata.lastValidTag = 'text2';

h29 = uicontrol(...
'Parent',h28,...
'Units','characters',...
'Position',[22.4 11.7692307692308 24.6 1.15384615384615],...
'String','MIMO Models',...
'Style','text',...
'Tag','text2',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );

h30 = uicontrol(...
'Parent',h28,...
'Units','characters',...
'BackgroundColor',[1 1 1],...
'Position',[23 0.923076923076923 24 10.7692307692308],...
'Style','listbox',...
'Value',1,...
'Tag','listbox6');

appdata = [];
appdata.lastValidTag = 'edit2';

h31 = uicontrol(...
'Parent',h28,...
'Units','characters',...
'BackgroundColor',[1 1 1],...
'Callback','sys_import(''edit2_Callback'',gcbo,[],guidata(gcbo))',...
'Enable','off',...
'HorizontalAlignment','left',...
'Position',[1.4 3.38461538461539 20.4 1.46153846153846],...
'String',blanks(0),...
'Style','edit',...
'Tag','edit2',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );

appdata = [];
appdata.lastValidTag = 'browse';

h32 = uicontrol(...
'Parent',h28,...
'Units','characters',...
'Callback','sys_import(''browse_Callback'',gcbo,[],guidata(gcbo))',...
'Enable','off',...
'Position',[1.6 1.23076923076923 20.4 1.76923076923077],...
'String','Browse',...
'Tag','browse',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );

appdata = [];
appdata.lastValidTag = 'text3';

h33 = uicontrol(...
'Parent',h28,...
'Units','characters',...
'Enable','off',...
'Position',[3.4 5 16.8 1.15384615384615],...
'String','MAT-file Name',...
'Style','text',...
'Tag','text3',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );

appdata = [];
appdata.lastValidTag = 'work';

h34 = uicontrol(...
'Parent',h28,...
'Units','characters',...
'Callback','sys_import(''work_Callback'',gcbo,[],guidata(gcbo))',...
'Position',[3.4 10.3846153846154 16.2 1.15384615384615],...
'String','WorkSpace',...
'Style','radiobutton',...
'Value',1,...
'Tag','work',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );

appdata = [];
appdata.lastValidTag = 'mat';

h35 = uicontrol(...
'Parent',h28,...
'Units','characters',...
'Callback','sys_import(''mat_Callback'',gcbo,[],guidata(gcbo))',...
'Position',[3.4 9.15384615384616 14.2 1.15384615384615],...
'String','MAT - File',...
'Style','radiobutton',...
'Tag','mat',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );

appdata = [];
appdata.lastValidTag = 'simul';

h36 = uicontrol(...
'Parent',h28,...
'Units','characters',...
'Callback','sys_import(''simul_Callback'',gcbo,[],guidata(gcbo))',...
'Position',[3.4 7.84615384615385 14.2 1.15384615384615],...
'String','M - File',...
'Style','radiobutton',...
'Tag','simul',...
'ToolTipString','see >>Help>>Examples',...
'CreateFcn', {@local_CreateFcn, blanks(0), appdata} );

hsingleton = h1;

function sys_import_OpeningFcn(hObject, eventdata, handles, varargin)
global op
op=1;
handles.output = hObject;
guidata(hObject, handles);
axes(handles.axes1);
load logo
col=get(hObject,'color');
if isequal(col*255,[240 240 240])
    set(handles.other,'userdata',{fondo imss})
    imshow(imss)
elseif isequal(col*255,[236 233 216])
    set(handles.other,'userdata',{fondo1 imss1})
    imshow(imss1)
end
vars = evalin('base','who');
set(handles.listbox6,'String',vars)
save system.mat op

function varargout = sys_import_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

function work_Callback(hObject, eventdata, handles)
f=[handles.mat handles.simul];
set(f,'value',0)
set(hObject,'value',1)
set(handles.listbox6,'string','')
set(handles.edit2,'string','');
set(handles.edit2,'enable','off')
set(handles.text3,'enable','off')
set(handles.browse,'enable','off')
vars = evalin('base','who');
set(handles.listbox6,'String',vars)
function mat_Callback(hObject, eventdata, handles)
f=[handles.work handles.simul];
set(f,'value',0)
set(hObject,'value',1)
set(handles.text3,'string','MAT-file Name')
set(handles.listbox6,'string','')
set(handles.edit2,'enable','on')
set(handles.text3,'enable','on')
set(handles.browse,'enable','on')


function edit2_Callback(hObject, eventdata, handles)
val=get(handles.mat,'value');
if val==1
    name=get(hObject,'string');
    mydata = who('-file', sprintf('%s',name));
    set(handles.listbox6,'String',mydata)
end

function browse_Callback(hObject, eventdata, handles)
val1=get(handles.mat,'value');
if val1==1
    [filename, pathname] = uigetfile( ...
        {'*.mat','Mat - Files(*.mat)';},...
        'Select System');
    if ~isequal(filename,0)
        s=[pathname filename];
        set(handles.edit2,'string',s)
        mydata = who('-file', sprintf('%s',s));
        set(handles.listbox6,'String',mydata)
    end
end

function other_Callback(hObject, eventdata, handles)
global op
%load logo
axes(handles.axes1)
if op==1||op==2
    op=op+1;
elseif op==3
    op=1;
end
h=[handles.bb handles.bc handles.bd handles.edit4 handles.edit5 handles.edit6];
h1=[handles.edit3 handles.edit4 handles.edit5 handles.edit6];
ims=get(hObject,'userdata');
if op==1
    imshow(ims{2})
    set(handles.text4,'string','A =')
    set(handles.text5,'string','B =')
    set(handles.text8,'string','State - Space')
    set(h,'enable','on')    
elseif op==2
    imshow(ims{1})
    text(50,87,'G  (s)=','tag','text1','FontSize',16,'FontAngle','italic', 'FontName','Monotype Corsiva');
    text(75,110,'qxp','tag','text1','FontSize',6);
    text(190,34,'g_{11}  g_{12}  ...  g_{1p}','FontSize',10,'FontAngle','italic',...
        'FontName','Monotype Corsiva');
    text(190,77,'g_{21}  g_{22}  ...  g_{2p}','FontSize',10,'FontAngle','italic',...
        'FontName','Monotype Corsiva');
    text(190,94,' .     .           .','FontSize',10,'FontAngle','italic','color',[1 0 0],...
        'FontName','Monotype Corsiva');
    text(190,98,' .     .           .','FontSize',10,'FontAngle','italic','color',[1 0 0],...
        'FontName','Monotype Corsiva');
    text(190,104,' .     .           .','FontSize',10,'FontAngle','italic','color',[1 0 0],...
        'FontName','Monotype Corsiva');
    text(190,138,'g_{q1}  g_{q2}  ...  g_{qp}','FontSize',10,'FontAngle','italic',...
        'FontName','Monotype Corsiva');
    text(155,88,'[','tag','text1','FontSize',45,'color',[102/256 0 204/256],'FontName','Roman');
    text(335,88,']','tag','text1','FontSize',45,'color',[102/255 0 204/255],'FontName','Roman');
    set(handles.text4,'string','Gt =')
    set(h,'enable','off')
    set(handles.text8,'string','Matrix Transfer Function')
elseif op==3
    imshow(ims{1})
    text(12,90,'[','tag','text1','FontSize',45,'color',[102/256 0 204/256],'FontName','Roman');
    text(160,90,']','tag','text1','FontSize',45,'color',[102/255 0 204/255],'FontName','Roman');
    text(197,85,'Y=','tag','text1','FontSize',14);
    text(240,90,'[','tag','text1','FontSize',45,'color',[102/256 0 204/256],'FontName','Roman');
    text(388,90,']','tag','text1','FontSize',45,'color',[102/255 0 204/255],'FontName','Roman');
     text(425,85,'U','tag','text1','FontSize',14);
    text(62,87,'P(D)','tag','text1','FontSize',18,'FontAngle','italic','FontName','Monotype Corsiva');
    text(287,85,'Q(D)','tag','text1','FontSize',17,'FontAngle','italic','FontName','Monotype Corsiva');
    text(42,45,'y_{11}   y_{21} . . . y_{m1}','FontSize',8,'FontName','Monotype Corsiva');
    text(270,45,'u_{11}  u_{21} . . .  u_{r1}','FontSize',8,'FontName','Monotype Corsiva');
    text(42,135,'y_{1m}  y_{2m} . . . y_{mm}','FontSize',8,'FontName','Monotype Corsiva');
    text(270,135,'u_{1m}  u_{2m} . . . u_{mr}','FontSize',8,'FontName','Monotype Corsiva');
    text(40,70,' .            .','color',[1 0 0],'FontSize',10);
    text(40,80,' .            .','color',[1 0  0],'FontSize',10);
    text(40,90,' .            .','FontSize',10,'color',[1 0 0]);
    text(270,70,' .           .','FontSize',10,'color',[1 0 0]);
    text(270,80,' .           .','FontSize',10,'color',[1 0 0]);
    text(270,90,' .           .','FontSize',10,'color',[1 0 0]);
    set(h,'enable','off')
    set(handles.text4,'string','P =')
    set(handles.text5,'string','Q =')
    set(handles.bb,'enable','on')
    set(handles.edit4,'enable','on')    
    set(handles.text8,'string','Differential - Operator')
end
set(h1,'string',' ')
   
function okay_Callback(hObject, eventdata, handles)
global op
S=load('system.mat');
name=fieldnames(S);
n=get(handles.edit1,'string');
if op==1
   if  ismember({'A','B','C','D'},name)
         close(gcbf)
   end
elseif op==2
    if  ismember({'sys'},name)
       close(gcbf)
   end
elseif op==3
    if  ismember({'P','Q'},name)
       close(gcbf)
   end
end
save system op n -append

function cancel_Callback(hObject, eventdata, handles)
close(gcbf)
function help_Callback(hObject, eventdata, handles)
%help
function ba_Callback(hObject, eventdata, handles)
global op
sel=get(handles.listbox6,'value');
name=get(handles.listbox6,'string');
val1=get(handles.mat,'value');
if val1==1
    name1=get(handles.edit2,'string');
    S=load(sprintf('%s',name1));
    names=fieldnames(S);
    tn=length(names);
    if ~isempty(tn)
        g=struct2cell(S);
        for i=1:tn,
            g1=cell2mat(names(i));
            g2=cell2mat(name(sel));
            if isequal(g1,g2)
                sys=g(i);
                sys=cell2mat(sys);
                break;
            end
        end
    end
else
    if ~isempty(name)
        sys=evalin('base',name{sel});
    end
end
if ~isempty(name)   
    [fs cs]=size(sys);
    cl=class(sys);
    if (fs>1 || cs>1)
        if op==1
            if isequal(cl,'double')
                set(handles.edit3,'string',name{sel})
                A=sys;
                try
                    save system A -append                   
                catch
                    save system A
                end
            else
                errordlg('You must select A type double',...
                    'Incorrect Selection','modal')
            end
        elseif op==2
            if (fs<4 || cs<4)
                if isequal(cl,'tf')
                    set(handles.edit3,'string',name{sel})
                    try
                        save system sys -append
                    catch
                        save system sys
                    end
                else
                    errordlg('You must select G type Matrix Transfer Function',...
                        'Incorrect Selection','modal')
                end
            else
                errordlg('The size G < 4 ',...
                    'Incorrect Matrix Transfer Function','modal')
            end
        elseif op==3
            if (fs<4 || cs<4)
                if isequal(cl,'cell')||isequal(cl,'sym')
                    set(handles.edit3,'string',name{sel})
                    P=sys;
                    try
                        save system P -append
                    catch
                        save system P
                    end
                else
                    errordlg('You must select P type cell or sym',...
                        'Incorrect Selection','modal')
                end
            else
                errordlg('The size P < 4 ',...
                    'Incorrect Operator Differential','modal')
            end
        end
    else
        errordlg('You must select MIMO System',...
            'Incorrect Selection','modal')
    end
     set(handles.okay,'enable','on')
end

function bb_Callback(hObject, eventdata, handles)
global op
sel=get(handles.listbox6,'value');
name=get(handles.listbox6,'string');
val1=get(handles.mat,'value');
if val1==1
    name1=get(handles.edit2,'string');
    S=load(sprintf('%s',name1));
    names=fieldnames(S);
    tn=length(names);
    if ~isempty(tn)
        g=struct2cell(S);
        for i=1:tn,
            g1=cell2mat(names(i));
            g2=cell2mat(name(sel));
            if isequal(g1,g2)
                sys=g(i);
                sys=cell2mat(sys);
                break;
            end
        end
    end
else
      if ~isempty(name)
        sys=evalin('base',name{sel});
    end
end

if ~isempty(name)
    [fs cs]=size(sys);
    cl=class(sys);
    if fs>1 || cs>1
        if op==1
            if cs<4
                if isequal(cl,'double')
                    set(handles.edit4,'string',name{sel})
                    B=sys;
                    try
                        save system B -append
                    catch
                        save system B
                    end
                else
                    errordlg('You must select B type double',...
                        'Incorrect Selection','modal')
                end
            else
                errordlg('The column size B < 4 ',...
                    'Incorrect Selection','modal')
            end
        elseif op==3
            if (fs<4 || cs<4)
                if isequal(cl,'cell')||isequal(cl,'sym')
                    set(handles.edit4,'string',name{sel})
                    Q=sys;
                    try
                        save system Q -append
                    catch
                        save system
                    end
                else
                    errordlg('You must select Q type cell or sym',...
                        'Incorrect Selection','modal')
                end
            else
                errordlg('The size Q < 4 ',...
                    'Incorrect Operator Differential','modal')
            end
        end
    else
        errordlg('You must select MIMO System',...
            'Incorrect Selection','modal')
    end
end
function bc_Callback(hObject, eventdata, handles)
global op
sel=get(handles.listbox6,'value');
name=get(handles.listbox6,'string');
val1=get(handles.mat,'value');
if val1==1
    name1=get(handles.edit2,'string');
    S=load(sprintf('%s',name1));
    names=fieldnames(S);
    tn=length(names);
    if ~isempty(tn)
        g=struct2cell(S);
        for i=1:tn,
            g1=cell2mat(names(i));
            g2=cell2mat(name(sel));
            if isequal(g1,g2)
                sys=g(i);
                sys=cell2mat(sys);
                break;
            end
        end
    end
else
      if ~isempty(name)
        sys=evalin('base',name{sel});
    end
end

if ~isempty(name)
     [fs cs]=size(sys);
    cl=class(sys);
    if fs>1 || cs>1
        if op==1
            if isequal(cl,'double')
                set(handles.edit5,'string',name{sel})
                C=sys;
                try
                    save system C -append
                catch
                    save system C
                end
            else
                errordlg('You must select C type double',...
                    'Incorrect Selection','modal')
            end
        end
    else
        errordlg('You must select MIMO System',...
            'Incorrect Selection','modal')
    end
end

function bd_Callback(hObject, eventdata, handles)
global op
sel=get(handles.listbox6,'value');
name=get(handles.listbox6,'string');
val1=get(handles.mat,'value');
if val1==1
    name1=get(handles.edit2,'string');
    S=load(sprintf('%s',name1));
    names=fieldnames(S);
    tn=length(names);
    if ~isempty(tn)
        g=struct2cell(S);
        for i=1:tn,
            g1=cell2mat(names(i));
            g2=cell2mat(name(sel));
            if isequal(g1,g2)
                sys=g(i);
                sys=cell2mat(sys);
                break;
            end
        end
    end
else
      if ~isempty(name)
        sys=evalin('base',name{sel});
    end
end
if ~isempty(name)
    cl=class(sys);
    if op==1
        if isequal(cl,'double')
            set(handles.edit6,'string',name{sel})
            D=sys;
            try
                save system D -append
            catch
                save system
            end
        else
            errordlg('You must select D type double',...
                'Incorrect Selection','modal')
        end
    else
        D=0;
        save system D -append
        set(handles.edit6,'string','0')
    end
end
function simul_Callback(hObject, eventdata, handles)
f=[handles.mat handles.work];
set(f,'value',0)
global op
set(handles.text3,'enable','off')
if op==1
    set(handles.text3,'string','state.m')
elseif op==2
    set(handles.text3,'string','mtf.m')
elseif op==3
    set(handles.text3,'string','lmpf.m')
end
set(hObject,'value',1)
h=questimp;
if ~isempty(h)
    if op==1
        [A B C D]=state(h);
        set(handles.edit3,'string','A')
        set(handles.edit4,'string','B')
        set(handles.edit5,'string','C')
        set(handles.edit6,'string','D')
        save system A B C D op
    elseif op==2        
        sys=mtf(h);
        set(handles.edit3,'string','G')
        save system sys op
    elseif op==3        
         [P Q]=lmpf(h);       
        set(handles.edit3,'string','P')
        set(handles.edit4,'string','Q')
        save system P Q op
    end
    set(handles.okay,'enable','on')
end
set(handles.edit2,'enable','off')
set(handles.browse,'enable','off')



function local_CreateFcn(hObject, eventdata, createfcn, appdata)
if ~isempty(appdata)
   names = fieldnames(appdata);
   for i=1:length(names)
       name = char(names(i));
       setappdata(hObject, name, getfield(appdata,name));
   end
end

if ~isempty(createfcn)
   eval(createfcn);
end


function varargout = gui_mainfcn(gui_State, varargin)
gui_StateFields =  {'gui_Name'
    'gui_Singleton'
    'gui_OpeningFcn'
    'gui_OutputFcn'
    'gui_LayoutFcn'
    'gui_Callback'};
gui_Mfile = '';
for i=1:length(gui_StateFields)
    if ~isfield(gui_State, gui_StateFields{i})
        error('MATLAB:gui_mainfcn:FieldNotFound', 'Could not find field %s in the gui_State struct in GUI M-file %s', gui_StateFields{i}, gui_Mfile);
    elseif isequal(gui_StateFields{i}, 'gui_Name')
        gui_Mfile = [gui_State.(gui_StateFields{i}), '.m'];
    end
end

numargin = length(varargin);

if numargin == 0
     gui_Create = true;
elseif local_isInvokeActiveXCallback(gui_State, varargin{:})
    vin{1} = gui_State.gui_Name;
    vin{2} = [get(varargin{1}.Peer, 'Tag'), '_', varargin{end}];
    vin{3} = varargin{1};
    vin{4} = varargin{end-1};
    vin{5} = guidata(varargin{1}.Peer);
    feval(vin{:});
    return;
elseif local_isInvokeHGCallbak(gui_State, varargin{:})
    gui_Create = false;
else
    gui_Create = true;
end

if ~gui_Create
     designEval = false;
    if (numargin>1 && ishghandle(varargin{2}))
        fig = varargin{2};
        while ~isempty(fig) && ~isa(handle(fig),'figure')
            fig = get(fig,'parent');
        end
        
        designEval = isappdata(0,'CreatingGUIDEFigure') || isprop(fig,'__GUIDEFigure');
    end
        
    if designEval
        beforeChildren = findall(fig);
    end
    
   varargin{1} = gui_State.gui_Callback;
    if nargout
        [varargout{1:nargout}] = feval(varargin{:});
    else       
        feval(varargin{:});
    end
    
    if designEval && ishandle(fig)
        set(setdiff(findall(fig),beforeChildren), 'Serializable','off');
    end
else
    if gui_State.gui_Singleton
        gui_SingletonOpt = 'reuse';
    else
        gui_SingletonOpt = 'new';
    end

    gui_Visible = 'auto';
    gui_VisibleInput = '';
    for index=1:2:length(varargin)
        if length(varargin) == index || ~ischar(varargin{index})
            break;
        end

        len1 = min(length('visible'),length(varargin{index}));
        len2 = min(length('off'),length(varargin{index+1}));
        if ischar(varargin{index+1}) && strncmpi(varargin{index},'visible',len1) && len2 > 1
            if strncmpi(varargin{index+1},'off',len2)
                gui_Visible = 'invisible';
                gui_VisibleInput = 'off';
            elseif strncmpi(varargin{index+1},'on',len2)
                gui_Visible = 'visible';
                gui_VisibleInput = 'on';
            end
        end
    end
    
    
    gui_Exported = ~isempty(gui_State.gui_LayoutFcn);
    
    setappdata(0,genvarname(['OpenGuiWhenRunning_', gui_State.gui_Name]),1);
    if gui_Exported
        gui_hFigure = feval(gui_State.gui_LayoutFcn, gui_SingletonOpt);
        
        movegui(gui_hFigure,'onscreen');
    else
        gui_hFigure = local_openfig(gui_State.gui_Name, gui_SingletonOpt, gui_Visible);
      
        if isappdata(gui_hFigure, 'InGUIInitialization')
            delete(gui_hFigure);
            gui_hFigure = local_openfig(gui_State.gui_Name, gui_SingletonOpt, gui_Visible);
        end
    end
    rmappdata(0,genvarname(['OpenGuiWhenRunning_', gui_State.gui_Name]));

    
    setappdata(gui_hFigure,'InGUIInitialization',1);

    
    gui_Options = getappdata(gui_hFigure,'GUIDEOptions');
   
    gui_Options.singleton = gui_State.gui_Singleton;

    if ~isappdata(gui_hFigure,'GUIOnScreen')
        
        if gui_Options.syscolorfig
            set(gui_hFigure,'Color', get(0,'DefaultUicontrolBackgroundColor'));
        end

      
        data = guidata(gui_hFigure);
        handles = guihandles(gui_hFigure);
        if ~isempty(handles)
            if isempty(data)
                data = handles;
            else
                names = fieldnames(handles);
                for k=1:length(names)
                    data.(char(names(k)))=handles.(char(names(k)));
                end
            end
        end
        guidata(gui_hFigure, data);
    end

    
    for index=1:2:length(varargin)
        if length(varargin) == index || ~ischar(varargin{index})
            break;
        end

        len1 = min(length('visible'),length(varargin{index}));
        if ~strncmpi(varargin{index},'visible',len1)
            try set(gui_hFigure, varargin{index}, varargin{index+1}), catch break, end
        end
    end

 
    gui_HandleVisibility = get(gui_hFigure,'HandleVisibility');
    if strcmp(gui_HandleVisibility, 'callback')
        set(gui_hFigure,'HandleVisibility', 'on');
    end

    feval(gui_State.gui_OpeningFcn, gui_hFigure, [], guidata(gui_hFigure), varargin{:});

    if isscalar(gui_hFigure) && ishandle(gui_hFigure)
     
        set(gui_hFigure,'HandleVisibility', gui_HandleVisibility);

      
        if ~gui_Exported
            gui_hFigure = local_openfig(gui_State.gui_Name, 'reuse',gui_Visible);
        elseif ~isempty(gui_VisibleInput)
            set(gui_hFigure,'Visible',gui_VisibleInput);
        end
        if strcmpi(get(gui_hFigure, 'Visible'), 'on')
            figure(gui_hFigure);
            
            if gui_Options.singleton
                setappdata(gui_hFigure,'GUIOnScreen', 1);
            end
        end

        
        rmappdata(gui_hFigure,'InGUIInitialization');
    end

  
    if isscalar(gui_hFigure) && ishandle(gui_hFigure)
        gui_HandleVisibility = get(gui_hFigure,'HandleVisibility');
        if strcmp(gui_HandleVisibility, 'callback')
            set(gui_hFigure,'HandleVisibility', 'on');
        end
        gui_Handles = guidata(gui_hFigure);
    else
        gui_Handles = [];
    end

    if nargout
        [varargout{1:nargout}] = feval(gui_State.gui_OutputFcn, gui_hFigure, [], gui_Handles);
    else
        feval(gui_State.gui_OutputFcn, gui_hFigure, [], gui_Handles);
    end

    if isscalar(gui_hFigure) && ishandle(gui_hFigure)
        set(gui_hFigure,'HandleVisibility', gui_HandleVisibility);
    end
end

function gui_hFigure = local_openfig(name, singleton, visible)
if nargin('openfig') == 2
    gui_OldDefaultVisible = get(0,'defaultFigureVisible');
    set(0,'defaultFigureVisible','off');
    gui_hFigure = openfig(name, singleton);
    set(0,'defaultFigureVisible',gui_OldDefaultVisible);
else
    gui_hFigure = openfig(name, singleton, visible);
end

function result = local_isInvokeActiveXCallback(gui_State, varargin)

try
    result = ispc && iscom(varargin{1}) ...
             && isequal(varargin{1},gcbo);
catch
    result = false;
end

function result = local_isInvokeHGCallbak(gui_State, varargin)

try
    fhandle = functions(gui_State.gui_Callback);
    result = ~isempty(findstr(gui_State.gui_Name,fhandle.file)) || ...
             (ischar(varargin{1}) ...
             && isequal(ishandle(varargin{2}), 1) ...
             && ~isempty(strfind(varargin{1},[get(varargin{2}, 'Tag'), '_'])));
catch
    result = false;
end