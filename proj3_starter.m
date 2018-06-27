% starter script for project 3
close all;
DO_TOY = 0;
DO_BLEND = 0;
DO_MIXED  = 0;
DO_COLOR2GRAY = 1;

if DO_TOY 
    toyim = im2double(imread('./samples/toy_problem.png')); 
    % im_out should be approximately the same as toyim
    im_out = toy_reconstruct(toyim);
    figure,imshow(im_out),axis off,axis image
    figure,imshowpair(toyim,im_out,'diff'),axis off,axis image
    disp(['Error: ' num2str(sqrt(sum((toyim(:)-im_out(:)).^2)))])
end

if DO_BLEND
    % do a small one first, while debugging
    im_background = imresize(im2double(imread('./samples/im3.jpg')), 0.25, 'bilinear');
    im_object = imresize(im2double(imread('./samples/penguin-chick.jpeg')), 0.25, 'bilinear');

    % get source region mask from the user
    objmask = getMask(im_object);
    % align im_s and mask_s with im_background
    [im_s, mask_s] = alignSource(im_object, objmask, im_background);
    figure, hold off, imshow(im_s)
    figure, hold off, imshow(mask_s)
    % blend
    im_blend = poissonBlend(im_s, mask_s, im_background);
    figure, hold off, imshow(im_blend)
end

if DO_MIXED
    if ~DO_BLEND
        im_background = imresize(im2double(imread('./samples/im2.jpg')), 0.25, 'bilinear');
        im_object = imresize(im2double(imread('./samples/penguin-chick.jpeg')), 0.25, 'bilinear');

        % get source region mask from the user
        objmask = getMask(im_object);
        % align im_s and mask_s with im_background
        [im_s, mask_s] = alignSource(im_object, objmask, im_background);
        figure, hold off, imshow(im_s)
        figure, hold off, imshow(mask_s)
    end
    % blend
    im_blend = mixedBlend(im_s, mask_s, im_background);
    figure, hold off, imshow(im_blend);
end

if DO_COLOR2GRAY
    % also feel welcome to try this on some natural images and compare to rgb2gray
    im_rgb = im2double(imread('./samples/helicopter.jpg'));
    im_gr = color2gray(im_rgb);
    figure(4), hold off, imagesc(im_gr), axis image, colormap gray
end
