function out = calculate_contact_angle()

% Please change the folder_str as per the folder you are working in
    folder_str = 'G:\Matlab pwd\Hydro-Pro\Final codes';
    
    thresh_inc = 0.1;
    known_dist = 18.934;
    para_length = 140;
    
    files = dir(folder_str);
    
    angle_(2, 100) = struct('filename', [], 'ang_lef', [], 'ang_rig', [], 'height', [], 'bound', []);
    count = 1;
    
    for i = 1:numel(files)
        [pathstr, name, ext]= fileparts(files(i).name);
        if( strcmp(ext,'.jpg'))
            
            angle_(count).filename = files(i).name;
            img_str = strcat(folder_str,'\', files(i).name);
            
            I = imread(img_str);
            %%imshow(I);
            %%imshow(I);
            %threshold = graythresh(I) + thresh_inc;
            %BW = im2bw(I, threshold);
            %imshow(BW);

    
            %Crop Image to fit into a smaller frame, if necessary
            ymin = 1;
            xmin = 1;
            width = 389;
            height =109; 
            I = imcrop(I, [ymin xmin width height]); %crop xmin y min width height
            imshow(I);
            para_length = round(width + height/4);
            
           %% imshow(I); hold on;
            [angle_(count).ang_lef, angle_(count).ang_rig, angle_(count).height, angle_(count).bound] = find_angle(I, thresh_inc, para_length, known_dist);
            count = count + 1;
        end
    end    

    cd ../Data;
    
    disp('Results:');
    
    for c = 1:(count-1)
        
        file = fopen(strcat(angle_(c).filename(1:(numel(angle_(1).filename)-4)), '.txt'),'w');

        fprintf(file, '%d \n', angle_(c).bound );
         
        display(' ');
        display('Angle of contact is: ');
        display(angle_(c));
        display(' ');
        
        if((angle_(c)>90) && (angle_(c)<180))
            display('The surface of prosthetic eye is Hydrophobic');
        elseif((angle_(c)>0) && (angle_(c)<90))
            display('The surface of prosthetic eye is Hydrophilic');
        end
        
        out = 1;
    end