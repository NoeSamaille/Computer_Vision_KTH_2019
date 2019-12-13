function init_centers(I, K, L, Iback, seed, naive_init)
  % used for comparing two types of center init
  [ segm, centers ] = kmeans_segm(I, K, L, seed, naive_init);
  Inew = mean_segments(Iback, segm);
  I = overlay_bounds(Iback, segm);
  imwrite(Inew,'bildat_lab3/result/kmeans1_naiveinit.png')
  imwrite(I,'bildat_lab3/result/kmeans2_naiveinit.png')
end