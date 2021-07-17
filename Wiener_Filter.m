function restored_image = Wiener_Filter(blurred_image,len,theta,SNR)
% This function will perform image restoration using Wiener Filter

% Convert to frequency domain
fblurred = fft2(blurred_image);

% Create PSF of the degradation
PSF = fspecial('motion',len,theta);

% Convert PSF to OTF
% OTF is Optical Transfer Function
% fblurred is the blurred image in frequency domain
OTF = psf2otf(PSF,size(fblurred));

% Conjugate for modulus acquisition
OTFC = conj(OTF);
modulus_OTF = OTF .* OTFC;

%To avoid division by zero error
for i = 1:size(OTF, 1)
    for j = 1:size(OTF, 2)
        if OTF(i, j) == 0
            OTF(i, j) = 0.000001;
        end
    end
end

% Deblurring image using Wiener Filter
deblurred_image = ((modulus_OTF ./ (modulus_OTF + SNR)) ./ (OTF)) .* fblurred;
restored_image = abs(ifft2(deblurred_image));

end

