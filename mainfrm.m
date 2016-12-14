function varargout = mainfrm(varargin)
% MAINFRM MATLAB code for mainfrm.fig
%      MAINFRM, by itself, creates a new MAINFRM or raises the existing
%      singleton*.
%
%      H = MAINFRM returns the handle to a new MAINFRM or the handle to
%      the existing singleton*.
%
%      MAINFRM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAINFRM.M with the given input arguments.
%
%      MAINFRM('Property','Value',...) creates a new MAINFRM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before mainfrm_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to mainfrm_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help mainfrm

% Last Modified by GUIDE v2.5 06-Dec-2016 19:23:23

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @mainfrm_OpeningFcn, ...
                   'gui_OutputFcn',  @mainfrm_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT

% --- Executes just before mainfrm is made visible.
function mainfrm_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to mainfrm (see VARARGIN)

% Choose default command line output for mainfrm
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% This sets up the initial plot - only do when we are invisible
% so window can get raised using mainfrm.
if strcmp(get(hObject,'Visible'),'off')
    plot(rand(1));
end

set(findall(handles.stPanel, '-property', 'enable'), 'enable', 'off')
set(findall(handles.inputPanel, '-property', 'enable'), 'enable', 'on')
set(handles.solveBtn,'Enable','on')
clearTable(handles.stTable)
updateGUI(1,handles)


% UIWAIT makes mainfrm wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = mainfrm_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in solveBtn.
function solveBtn_Callback(hObject, eventdata, handles)
% hObject    handle to solveBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(hObject,'Enable','off')
set(findall(handles.stPanel, '-property', 'enable'), 'enable', 'on')
set(findall(handles.inputPanel, '-property', 'enable'), 'enable', 'off')
axes(handles.axes1);
cla;

global cancelled;
global miter;
global err;
global citer;
global solver;

cancelled = 0;
citer = 0;
miter = str2num(get(handles.miterBox,'String'));
err = str2double(get(handles.errBox,'String'));

eqnstr = get(handles.eqnBox, 'String');
eqnstr = ['@(x)' eqnstr];

eqn = str2func(eqnstr)

if(~isint(miter))
    miter = 50;
end
if isnan(err)
    err = 0.00001;
end

set(handles.miterBox,'String', miter)
set(handles.errBox,'String', err)
clearTable(handles.stTable);

idx = get(handles.popupmenu1, 'Value');
switch idx
    case 1        %bisection    
        display('Solving using Bisection')        
        solver = bisectionSolver(eqn, getReq(handles.reqTable));
    case 2        %false position  
        display('Solving using False Position')        
        solver = falsePosSolver(eqn, getReq(handles.reqTable));
    case 3        %fixed point
        display('Solving using Fixed Point')        
        solver = fixedPointSolver(eqn, getReq(handles.reqTable));
    case 4        %newton
        display('Solving using Newton-Raphson')
        solver = newtonRaphSolver(eqn, getReq(handles.reqTable));
    case 5        %secant
        display('Solving using Secant')        
        solver = secantSolver(eqn, getReq(handles.reqTable));
end

% --------------------------------------------------------------------
function PrintMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to PrintMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
printdlg(handles.figure1)


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1
idx = get(handles.popupmenu1, 'Value');
updateGUI(idx, handles)

% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
     set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function eqnBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to eqnBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in finBtn.
function finBtn_Callback(hObject, eventdata, handles)
% hObject    handle to finBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global cancelled;
global citer;
global miter;

set(handles.stepBtn,'Enable','off')

while ~(cancelled || step(handles))
end
terminate(handles)


% --- Executes on button press in stepBtn.
function stepBtn_Callback(hObject, eventdata, handles)
% hObject    handle to stepBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
step(handles);

% --- Executes on button press in cancelBtn.
function cancelBtn_Callback(hObject, eventdata, handles)
% hObject    handle to cancelBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global cancelled;
cancelled = 1;
terminate(handles);

% --- Executes during object creation, after setting all properties.
function miterBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to miterBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function errBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to errBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function setTableCol(htable,vals)
names = [];
for i=1:length(vals)
   names = [names vals(i)]; 
end
set(htable,'ColumnName',names)

function setReq(htable, vals)
clearTable(htable)
for i=1:length(vals)
   addRow(htable, [vals(i) {''}])
end

function req = getReq(htable)
data = get(htable,'Data');
data = data(:,2);
req = [];
for i = 1:length(data)
    req = [req str2double(data{i})];
end

function addRow(htable, vals)
oldData = get(htable,'Data');
row = [];
for i=1:length(vals)
   row = [row vals(i)]; 
end
newData = [oldData; row];
set(htable,'Data',newData)

function clearTable(htable)
set(htable,'Data',[])

function terminate(handles)
set(findall(handles.stPanel, '-property', 'enable'), 'enable', 'off')
set(findall(handles.inputPanel, '-property', 'enable'), 'enable', 'on')
set(handles.solveBtn,'Enable','on')

function done = step(handles)
global miter;
global err;
global citer;
global solver;

solver.nextStep()
citer = citer+1;
solver.plotState()
addRow(handles.stTable, solver.stateData)
ep = solver.getAppError();
if(citer == miter || isnan(ep) || ep <= err)
    done = 1;
    terminate(handles)
else
    done = 0;
end
set(handles.citerLabel,'String', citer);
set(handles.timeLabel, 'String', solver.totalTime)

function updateGUI(method, handles)  
    switch method
    case 1        %bisection    
        setReq(handles.reqTable, bisectionSolver.reqLabels)
        setTableCol(handles.stTable, bisectionSolver.dataLabels)
    case 2        %false position  
        setReq(handles.reqTable, falsePosSolver.reqLabels)
        setTableCol(handles.stTable, falsePosSolver.dataLabels)
    case 3        %fixed point
        setReq(handles.reqTable, fixedPointSolver.reqLabels)
        setTableCol(handles.stTable, fixedPointSolver.dataLabels)
    case 4        %newton
        setReq(handles.reqTable, newtonRaphSolver.reqLabels)
        setTableCol(handles.stTable, newtonRaphSolver.dataLabels)
    case 5        %secant       
        setReq(handles.reqTable, secantSolver.reqLabels)
        setTableCol(handles.stTable, secantSolver.dataLabels)
    end

function check = isint(val)
check = ~isempty(val) ...
            && isnumeric(val) ...
            && isreal(val) ...
            && isfinite(val) ...
            && (val == fix(val));
