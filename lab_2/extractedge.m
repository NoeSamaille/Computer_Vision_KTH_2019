function edgecurves = extractedge(inpic, scale, threshold, shape)

    pic = gaussfft(inpic, scale);
    L_v = Lv(pic, shape, 'centered');
    L_vvt = Lvvtilde(pic, shape);
    L_vvvt = Lvvvtilde(pic, shape);
    
    Lvvv_mask = (L_vvvt < 0) - 0.1;
    edgecurves = zerocrosscurves(L_vvt, Lvvv_mask);
    
    Lv_mask = (L_v > threshold) - 0.1;
    edgecurves = thresholdcurves(edgecurves, Lv_mask);
    
    overlaycurves(inpic, edgecurves)

end