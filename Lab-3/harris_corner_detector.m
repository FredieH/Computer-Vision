function [H, row_list, column_list] = harris_corner_detector(rgb_image, treshold, neighborhood)
    % convert the image to double to be able to do computations
    gray_image = im2double(rgb2gray(rgb_image));
        
    % set n to neighborhood for notation
    n = neighborhood;
    
    % construct a Gaussian filter 
    G = gauss2D(0.5, 3);
    
    % get the x and y gradient of the Gaussian filter
    [Gx, Gy] = gradient(G);
    
    % filter the image with the first order derivatives of the Gaussian
    % filter
    Ix = imfilter(gray_image, Gx, 'conv');
    Iy = imfilter(gray_image, Gy, 'conv');

    % 
    Ix_squared = Ix.^2;
    Iy_squared = Iy.^2;
    Ixy = Ix.*Iy;
    
    G = gauss2D(0.5, (n*2)+3);
    %
    A = imfilter(Ix_squared, G);
    B = imfilter(Ixy, G);
    C = imfilter(Iy_squared, G);
    
    [h, w] = size(A);
    H = zeros(h+2*n, w+2*n);
    row_list = [];
    column_list = [];
    
    for col = 1:w
        for row = 1:h
            A_xy = A(row, col);
            B_xy = B(row, col);
            C_xy = C(row, col);
            H(row+n, col+n) = (A_xy*C_xy - B_xy^2) - 0.04*(A_xy+C_xy)^2;
        end
    end
        
    [h_n, w_n] = size(H);
    zero_matrix = zeros((n*2)+1,(n*2)+1);
    
    for col = (1+n):(w_n-n)
        for row = (1+n):(h_n-n)
            pixel_value = H(row, col);
            zero_matrix(n+1,n+1) = H(row, col);
            neighbor_matrix = H(row-n:row+n, col-n:col+n) - zero_matrix;
            neighborhood_max = max(max(neighbor_matrix));
            if pixel_value > neighborhood_max && pixel_value > treshold
                row_list = [row_list, row];
                column_list = [column_list, col];
            end
        end
    end 
    
    for i=1:length(row_list)
        rgb_image(row_list(i), column_list(i), :) = [1, 0, 0];
    end

    figure;
    subplot(1,3,1);
    imshow(Ix);
    title('x-gradient');
    subplot(1,3,2);
    imshow(Iy);
    title('y-gradient');
    figure;    
    imshow(rgb_image);
    hold on
    t=0:0.1:2*pi;
    radio = 2;
    for i=1:length(row_list)
        y = row_list(i) + radio*sin(t);
        x = column_list(i) + radio*cos(t);
        plot(x,y,'g');
    end
    title('corner decection');
end
    