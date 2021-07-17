function degraded_image = Degrade(input_image,len,theta)
% This function will perform motion blur degradation into the input image

% Converting to double
im_double = im2double(input_image);

% Converting the image to frequency domain
im_frequency = fft2(im_double);

% Create PSF of degradation
PSF = fspecial('motion',len,theta);

% Convert PSF to OTF
% OTF is Optical Transfer Function
% im_frequency_blurred
OTF = psf2otf(PSF,size(input_image));

% Degrading the image
im_frequency_degraded = OTF .* im_frequency;

% Converting back to spatial domain
degraded_image = abs(ifft2(im_frequency_degraded));

end

