%% showByW
imgName = 'smile.png';
img = imread(imgName) > 128;
img = img(:,:,1);
h = figure(1);
imshow(img);