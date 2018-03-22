%% Demo function for Bag-of-Features (BoF)
% This function has been written to serve as a demo function to test the
% BoF implementation. Below the different parameters and their possible
% values will be discussed
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Parameters
% NUM_CLUS_IMAGES: The number of images (per category) to be used to perform
% feature clustering, the number can be between 1 and 200.

% NUM_CLUSTERS: The number of clusters to create the vocabulary. Options
% are 400, 800, 1600 and 4000.

% NUM_SVM: The number of images (per category) to be used to perform SVM
% classification, the number can be between 1 and 200.

% COLORSPACE: the colorspace to be used by the SIFT keypoint descriptor.
% Options:
% "RGB" - regular RGB color space
% "rgb" - normalized RGB color space
% "opponent" - opponent color space

% DENSE: to use dense SIFT of point SIFT. If the value is set to true,
% denseSIFT will be used, otherwise keypoint SIFT.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Default Settings
clear all
close all
clc

NUM_CLUS_IMAGES = 100;
NUM_CLUSTERS = 400;
NUM_SVM = 50;
COLORSPACE = "RGB";
DENSE = false;

[ap_air, ap_car, ap_fac, ap_mot, air_im, car_im, fac_im, mot_im, ...
    air_sc, car_sc, fac_sc, mot_sc] = main_bof(NUM_CLUS_IMAGES, NUM_CLUSTERS, NUM_SVM, COLORSPACE, DENSE);

write_to_html(air_im, car_im, fac_im, mot_im, NUM_CLUS_IMAGES, NUM_CLUSTERS, NUM_SVM, COLORSPACE, DENSE);
