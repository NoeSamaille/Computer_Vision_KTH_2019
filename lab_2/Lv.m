function pixels = Lv(inpic, shape, der_op)

    if strcmp(der_op, 'centered')
        % Central differences
        dxmask = [0 0 0 0 0; 0 0 0 0 0; 0 -0.5 0 0.5 0; 0 0 0 0 0; 0 0 0 0 0];
        dymask = dxmask';
    elseif strcmp(der_op, 'roberts')
        % Robert's operator
        dxmask = [1 0; 0 -1];
        dymask = [0 1; -1 0];
    elseif strcmp(der_op, 'sobel')
        % Sobel operator
        dxmask = [-1 0 1; -2 0 2; -1 0 1];
        dymask = [-1 -2 -1; 0 0 0; 1 2 1];
    else
        % Default operator: simple
        dxmask = [-1 1; 0 0];
        dymask = dxmask';
    end
    
    if (nargin < 2)
        shape = 'same';
    end

    Lx = filter2(dxmask, inpic, shape);
    Ly = filter2(dymask, inpic, shape);
    pixels = Lx.^2 + Ly.^2;
    
end