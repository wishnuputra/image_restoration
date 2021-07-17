function restored_image = Inverse(blurred_image,len,theta)
% This funtion performs inverse of the motion blur degradation function

%Converting to frequency domain
fblurred = fft2(blurred_image);

%Create PSF of degradation
PSF = fspecial('motion',len,theta);

%Convert psf to otf of desired size
%OTF is Optical Transfer Function
OTF = psf2otf(PSF, size(fblurred));

%To avoid division by zero error
for i = 1:size(OTF, 1)
    for j = 1:size(OTF, 2)
        if OTF(i, j) == 0
            OTF(i, j) = 0.000001;
        end
    end
end


%Restoring the image using Inverse Filter
fdeblurred = fblurred./OTF;

%Converting back to spatial domain using IFFT
restored_image = abs(ifft2(fdeblurred));

end

