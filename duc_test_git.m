clc ; 
clear all ; 
close all ; 
% input to duc 
data = load('/home/wisig/Downloads/interleaver_out_fft0_exp.txt.txt')  ; 
col1 = int16(data(:, 1));                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 
col2 = int16(data(:, 2)); 

x_12 = col1*2 ; 
y_12 = col2*2 ; 
x_13 = x_12*2 ;
 y_13 =y_12*2;
 x_14 = x_13*2;
 y_14 = y_13*2;
 x_15 = x_14*2;
 y_15 = y_14*2;
 x_10 = col1/2 ; 
 y_10 = col2/2 ;
 x_9 = x_10/2 ; 
 y_9 = x_10/2 ; 
f1 = fopen("test_bit_12.txt",'w') ; 
f2 = fopen("test_bit_13.txt",'w');
f3 = fopen("test_bit_14.txt",'w');
f4 = fopen("test_bit_15.txt",'w'); 
f5 = fopen("test_bit_10.txt",'w');
f6 = fopen("test_bit_9.txt",'w') ;


for i = 1:491520
fprintf(f1,'%d,%d\n',x_12(i),y_12(i));
end
fclose(f1);

for i = 1:491520
fprintf(f2,'%d,%d\n',x_13(i),y_13(i));
end

for i = 1:491520
fprintf(f3,'%d,%d\n',x_14(i),y_14(i));
end

for i = 1:491520
fprintf(f4,'%d,%d\n',x_15(i),y_15(i));
end

for i = 1:491520
fprintf(f5,'%d,%d\n',x_10(i),y_10(i));
end
 
for i = 1:491520
fprintf(f6,'%d,%d\n',x_9(i),y_9(i));
end
max_real = max(col1);
max_imag = max(col2);

bits_real = log2(max_real);
bits_imag = log2(max_imag);

% test to check  the no.of sign extended bits 

% data_1  is the output file  of the duc 
data_1 = load('/home/wisig/Downloads/duc_test_13.txt') ; 
data_2 = int16(data( :,16));
n = 491520; % depth of the data 
min_j_values = zeros(1, n);  

% Iterate through the samples
for k = 1:n
    sample = data_2(k);
     j_value = 0 ; 
    
    % Convert the decimal number to its binary representation with 16 bits
    binary_number = dec2bin(sample, 16);
    
    % condition
    for j = 1:1:15
        %matlab index starts from 1 to 16 
        %so now msb will be 1 .  
        % Compare binary_number(j) with binary_number(j+1)
        if binary_number(j) ~= binary_number(j+1) 
            j_value = j ; 
            % Print the index where the condition fails and the binary
            % representation 
           % fprintf('Failed at j=%d for binary number: %s\n', j, binary_number);
            break;
        end
    end
  
    min_j_values (k) = j_value ;
    
   
end
woutr = unique(min_j_values) ; 


