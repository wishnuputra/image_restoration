function noised_image = Noise(input_image,noise_type,noise_mean,noise_variance)
% This function will add noise into the input image

noised_image = imnoise(input_image,noise_type,noise_mean,noise_variance);

end

