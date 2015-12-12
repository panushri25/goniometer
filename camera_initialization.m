clear all;
close all;
clc;

% Please check Device ID of camera in your laptop and change it on line 21
% and line 22...it must be either 1 or 2 or 3

% Please change Current directory in line 19 as per the folder you are working in

display('MIT ReDx Camp 2015, Engineering the Eye');
display('----------------------------------------');
display('Hydro-Pro: A device to measure hydrophobicity / hydrophilicity of the prosthetic eye surface');
display('');
display('');
display('Loading Camera settings...');
display('');
display('');

cd('G:\Matlab pwd\Hydro-Pro\Final codes');
% imaqhwinfo; % stands for image acquisition hardware info
% cam=imaqhwinfo;
% cam.InstalledAdaptors;
% dev_info = imaqhwinfo('winvideo',3);
vid=videoinput('winvideo',3, 'YUY2_1920x1080');
src=getselectedsource(vid);
get(src);
preview(vid);

display('Do you want to take image?');
g=input('Press 1 to do so... ');
if(g==1)
image=getsnapshot(vid);
imshow(image);
imwrite(image,'1.jpg');
end
display('  ');

a = calculate_contact_angle();
if a==1
display('Thank you for using Hydro-Pro...');
end
