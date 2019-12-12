# Image Analysis and Computer Vision labs

This repository contains my laboration code and reports for KTH course DD2423 Image Analysis and Computer Vision.

+ `lab1`: Code and report for lab 1
  + `lab1/lab1_script.m`: script answering all the 20 questions of the first lab. To run each part uncomment the corresponding code section.
  + `lab1/fftwave.m`: implementation of function `fftwave`.
  + `lab1/gaussfft.m`: implementation of the discretized gaussian convolution.
  + `lab1/lab1_report.pdf`: written answer sheet for lab 1.
+ `lab2`: Code and report for lab 2
  + `lab2/lab2_script.m`: script answering all the 10 questions of the second lab. To run each part please uncomment the corresponding code section (indicated by comments).
  + `lab2/Lv.m`: implementation of function `Lv` that estimates the first order derivative of an given image.
  + `lab2/Lvvtilde.m`: implementation of function `Lvvtilde` that estimates the second order derivative of a given image.
  + `lab2/Lvvtilde.m`: implementation of function `Lvvvtilde` that estimates the third order derivative of a given image.
  + `lab2/houghline.m`: implementation of function `houghline` that uses Hough transform to determine linear approximation of a given set of curves.
  + `lab2/houghedgeline.m`: implementation of function `houghedgeline` that detects edges in a given image then applies Hough transform to those edges.
  + `lab2/drawlines.m`: function that shows a set of lines on a given image (used to show results of `houghline`).
  + `lab2/lab2_report.pdf`: written answer sheet for lab 2.
+ `lab3`: Code and report for lab 3
  + `lab3/lab3_script.m`: script containing code for the 2 last parts.
  + `lab3/mixture_prob.m`: implementation of function `mixture_prob`, computing mixture of gaussians using Expectation/Maximisation algorithm.
  + `lab3/kmeans_segm.m`: implementation of K-means clustering algorithm for image segmentation.
  + `lab3/kmeans_example.m`: code for using the K-means segmentation.
  + `lab3/norm_cut.m`: function to use the normalized cut segmentation and saving results.
  + `lab3/graph_cut.m`: function to use the graph cut segmentation and saving results.
  + `lab3/lab3_report.pdf`: written answer sheet for lab 2.