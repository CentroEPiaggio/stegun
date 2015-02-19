function varargout = STEGUN(varargin)
% FETTINE M-file for fettine.fig
%      FETTINE, by itself, creates a new FETTINE or raises the existing
%      singleton*.
%
%      H = FETTINE returns the handle to a new FETTINE or the handle to
%      the existing singleton*.
%
%      FETTINE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FETTINE.M with the given input arguments.
%
%      FETTINE('Property','Value',...) creates a new FETTINE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before fettine_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to fettine_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help fettine

% Last Modified by GUIDE v2.5 12-Mar-2014 17:50:09

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @fettine_OpeningFcn, ...
                   'gui_OutputFcn',  @fettine_OutputFcn, ...
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


% THE GUI CAN BE LAUNCHED FROM THE COMMAND WINDOW EDITING ITS TITLE
%THE MCODE S STORED IN THE CURRENT DIRECTORY

% --- Executes just before fettine is made visible.
function fettine_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to fettine (see VARARGIN)

% Choose default command line output for fettine
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);


%IT IS NECESSARY TO CREATE A VECTOR IN WHICH LENGTHS OBTAINED FROM THE
%THREE CROPPING'S ANALYSIS WILL BE STORED.
%THE GOAL IS TO CALCULATE A MEAN LENGTH VALUE USING THE INFORMATIONS IN THE
%"LENGHT" VECTOR
global olddir;

global LENGTH;

global pixel_size;

%pixel_size IS PREALLOCATED 
pixel_size = 1;

olddir = pwd;
LENGTH = [0;0;0]; 


% UIWAIT makes fettine wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varagout = fettine_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Get default command line output from handles structure




% --- Executes on button press in LOAD.
function LOAD_Callback(hObject, eventdata, handles)
% hObject    handle to LOAD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global im;

global p;                   %global ALLOWS DATA TO BE REUSED THROUGH ALL THE FUNCTIONS IN WHICH THEY 
                            %ARE NEEDED, WITHOUT INITIATE EVERY VARIABLE IN EVERY FUNCTION
global olddir;

global pathname;

global filename;

global bw;

cd(olddir);                %THIS CODE CREATES A STRING TYPE IN WHICH THE IMMAGE'S ADRESS IS SAVED



%LOAD AND SHOW THE IMMAGE :

[filename, pathname]= uigetfile ({'*.jpg;*.tif;*gif;*.bmp'}, 'PICK AN IMAGE');


cd(pathname);
im = imread(filename);
axes(handles.axes1), imshow(im)



cd(olddir)


%USES A COPY i OF THE ORIGINAL IMMAGE TO GENERATE A SEGMENTATION.
%SEGMANTATION = OPERATION THAT SPLITS THE IMMAGE IN ITS FUNDAMENTAL
%COMPONENTS IN ORDER TO ANALYZE THE EVENTUALLY PRESENT OBJECTS.

%GRAYTRESH + IM2BW:

%GRAYTHRESH Global image threshold using Otsu's method.
%LEVEL = GRAYTHRESH(I) computes a global threshold (LEVEL) that can be
%used to convert an intensity image to a binary image with IM2BW. LEVEL
%is a normalized intensity value that lies in the range [0, 1].
%GRAYTHRESH uses Otsu's method, which chooses the threshold to minimize
%the intraclass variance of the thresholded black and white pixels.

%IM2BW Convert image to binary image by thresholding.
%IM2BW produces binary images from indexed, intensity, or RGB images. To do
%this, it converts the input image to grayscale format (if it is not already
%an intensity image), and then converts this grayscale image to binary by
%thresholding. The output binary image BW has values of 1 (white) for all
%pixels in the input image with luminance greater than LEVEL and 0 (black)
%for all other pixels. (Note that you specify LEVEL in the range [0,1], 
%regardless of the class of the input image.)
%BW = IM2BW(I,LEVEL) converts the intensity image I to black and white.
 
   

i = im ;                                %A COPY OF THE ORIGINAL IS CREATED 
                                        %level=graytresh(i);

           
bw = im2bw(i);                          %USING IM2BW DETERMINES THE IMMAGE TO BE A BINARY ONE SO THAT 1 = INFORMATION ; 
                                        %0 = NO INFORMATION. IT IS ALSO NECESSARY TO TOGGLE THE BITS IN ORDER TO CONCENTRATE
                                        %THE INFORMATION IN THE SLICE AND NOT IN THE BACKGROUND.
                                        
bw = ~ bw;                                      
                                        


p = bwlabel(bw);                       %p IS A MATRIX OF THE SAME SIZE AS bw, ITS ELEMENTS ARE INTEGER VALUES GREATER THAN OR EQUAL TO 0.
                                       %THE PIXELS LABELLED 0 ARE THE BACKGROUND
                                       %THE PIXELS LABELLED 1 FORM ONE
                                       %OBJECT, THE PIXELS LABELLED 2 FORM
                                       %THE SECOND OBJECT, AND SO ON.
[t,z]= size(p);


axes(handles.axes2), imshow(p)        %THE SECOND AXES BEARS THE INFORMATION OF THE IMMAGE WHERE THE DATA ARE THE CENTRAL SLICE AND SOME SPURIOUS 
                                      %COMPONENTS THAT MUST BE ELIMINATED
                                      %SINCE THOSE COULD CORRUPT THE CROP 
                                     

[x , y] = ginput(1);                  %GIVES THE POSITION OF THE SELECTED OBJ 
                                      %[x,y]=ginput(n) gets n points from the current axes and returns 
                                      %the X- and Y-coordinates in length N vectors X and Y.  The cursor
                                      %can be positioned using a mouse.  Data points are entered by pressing 
                                      %a mouse button 

                                      
                                      
x = uint64(x);                        %x e y are decimal, but the pixels are expressed with integer numbers.
y = uint64(y);                        %UINT Create structure describing Unsigned INTeger data type
                                      %For example, UINT(16) returns a MATLAB structure
                                      %that describes the data type of a 
                                      %16 bit Unsigned INTeger number


eureka = p(y,x);                     %NOW THAT THE ESSENTIAL IMMAGE HAS BEEN DISTINGUISHED , THE COORDINATES ARE STORED IN THE VALUE
                                     %eureka.
                                     %IN ORDER TO SELECT ONLY THE IMPORTANT
                                     %COMPONENTS TWO for cycles ARE RUNNING
                                     
                                     

for w = 1:t
    
    for e = 1:z
       
      if  p(w,e)== eureka
          p(w,e) = 1;
         
      else p(w,e) = 0;
                
      end;
    
    end;
end;



axes(handles.axes3), imshow(p)        %THE READY TO BE CROPPED IMAGE IS DISPLAYED IN THE THIRD AXES

    
            
            
                                        

% --- Executes on button press in CROP.
function CROP_Callback(hObject, eventdata, handles)
% hObject    handle to CROP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global p;

global LENGTH;

global pixel_size;

global pathname;

global filename;


%I2 = imcrop(I, rect) crops the image I. rect is a four-element position
%vector[xmin ymin width height] that specifies the size and position of the crop rectangle.



for   j=1:3                                           
      [image2, r] = imcrop(p);                        %I2 = IMCROP(I,RECT)
       r1= [r(1,1) r(1,2) r(1,3)  7 ];                %RECT is a 4-element vector with the form [XMIN YMIN WIDTH HEIGHT];
                                                      %these values are
         image2=imcrop(p, r1);                        %specified in spatial coordinates, the commend "[image2, r] = imcrop(p)"
                                                      %stores in the vector
                                                      %r , [XMIN YMIN WIDTH
          k = sum(image2)/7;                          %HEIGHT] where the
         somma_j = sum(k);                            %parameter that must be fixed is the height of the rectangle so that every window has the same
       crop = somma_j.*pixel_size;                    %height, the width is not important since the background is all black.                                  
     LENGTH(j , 1) = crop;  
end                                              
                              
                             
                    
    
  



meanVal = mean(LENGTH);                           %THE MEAN VALUE OF THE THREE IS CALCULATED,            
stdVal=std(LENGTH);                                %APPEARS IN MESSAGE BOX
CoV= stdVal/meanVal;


msgbox(['Thickness: ', num2str(meanVal) , ' +/- ', num2str(stdVal)]);   


if CoV > 0.5        %50%
   msgbox(['Warning: irregular slice!!!']); 
end;




cd(pathname)

first_LENGTH = LENGTH(1);
second_LENGTH = LENGTH(2);
third_LENGTH = LENGTH(3); 


save(filename(1:end-4),'meanVal', 'first_LENGTH' ,'second_LENGTH', 'third_LENGTH');        %AND IS AT THE SAME TIME SAVED IN THE SAME FOLDER OF THE 
                                                                                        %ORIGINAL IMMAGE
                                                                                        %AS WELL AS THE THREE LENGTHS
                                                                                        %THE SYNTAX "filename(1:end-4)" IS DUE TO THE FACT THAT IT 
                                                                                        %IS NECESSARY TO ELIMINATE 
                                                                                        %".tif" from the filename








%THE POP UP MENU ENABLES THE GUI USER TO SELECT THE OBJECTIVE LENS USED TO
%OBTAIN THE IMMAGE THAT IS GOING TO BE PROCESSED
%DEPENDING ON WHICH OPTION IS SELECTED,THE GUI WILL DETERMINE THE
%PROPER pixel_size

% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1
global pixel_size;

%pixel_size=1;
%pixel_size  [um]

str_obj= get(hObject, 'String');
val_obj= get (hObject, 'Value');


switch str_obj{val_obj}
   case '1.25x'
      pixel_size=5.16;
      
   case '4x'
      pixel_size=1.61;
   
   case '10x'
        pixel_size=654;
        
   case '20x'
        pixel_size=322.5*(10^-3);
   
   case '40x'
      pixel_size=161.25*(10^-3);
end



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




%USER FRIENDLY GUIDE
% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global olddir;


cd(olddir) 


winopen( 'read me.pdf' );


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global p;                                          %THIS BUTTON AIMS AT ADJUSTING THE IMAGE. 
                                                   %IT OPERATES BY
                                                   %PROVIDING TWO SELECTION
[x1 , y1]= ginput(1);                               %TOOLS TO DEFINE A
[x2 , y2]= ginput(1);
                                                   %STRAIGHT LINE THAT
                                                   %DEFINES THE SLICE AND
                                                   %GIVES ITS ROTATION
                                                   %ANGLE SO THAT IT IS
                                                   %POSSIBLE TO REVOLVE IT.

m = (y1 - y2)/(x2 - x1);                            

angle1 = atan(m);                                  %rotation angle


angle = (angle1*180)/(pi);                         %angle in degrees



p = imrotate( p , angle );
axes(handles.axes3), imshow(p)
