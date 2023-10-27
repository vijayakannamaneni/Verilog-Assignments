clc ; 
clear all ; 
close all ; 
% input to ddc 
% data = load('/home/wisig/Downloads/DUC_out_linup1_exp.txt')  ;
% data_1 = load('/home/wisig/Downloads/DUC_out_linup2_exp.txt');
% col1 = int16(data(:, 1));                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 
% col2 = int16(data(:, 2)); 
% col3 = int16(data(:, 3)); 
% col4 = int16(data(:,4));
% col5 = int16(data(:,5));
% col6 = int16(data(:,6));
% col7 = int16(data(:,7));
% col8 = int16(data(:,8));
% col1_1 = int16(data_1(:, 1));                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 
% col2_1 = int16(data_1(:, 2)); 
% col3_1 = int16(data_1(:, 3)); 
% col4_1 = int16(data_1(:,4));
% col5_1 = int16(data_1(:,5));
% col6_1 = int16(data_1(:,6));
% col7_1 = int16(data_1(:,7));
% col8_1 = int16(data_1(:,8));
% 
% % col1_max = max(col1) ; 
% % col2_max = max(col2) ;
% % col3_max = max(col3);
% % col4_max = max(col4);
% % col5_max = max(col5);
% % col6_max = max(col6);
% % col7_max = max(col7) ;
% % col8_max = max(col8) ;
% % col1_1max = max(col1_1) ; 
% % col2_1max = max(col2_1) ;
% % col3_1max = max(col3_1);
% % col4_1max = max(col4_1);
% % col5_1max = max(col5_1);
% % col6_1max = max(col6_1);
% % col7_1max = max(col7_1) ;
% % col8_1max = max(col8_1) ;
% 
% f1 = fopen("/home/wisig/Downloads/ddc_test/input/ddc_16.txt","w") ;
% f2 = fopen("/home/wisig/Downloads/ddc_test/input/ddc_16_1.txt","w") ;
% col1_12 = col1*2 ;
% col2_12 = col2*2 ;
% col3_12 = col3*2 ;
% col4_12 = col4*2 ;
% col5_12 = col5*2 ;
% col6_12 = col6*2 ;
% col7_12 = col7*2;
% col8_12 = col8*2 ;
% col1_1_12 = col1_1*2 ;
% col2_1_12 = col2_1*2 ;
% col3_1_12 = col3_1*2 ;
% col4_1_12 = col4_1*2 ;
% col5_1_12 = col5_1*2 ;
% col6_1_12 = col6_1*2 ;
% col7_1_12 = col7_1*2;
% col8_1_12 = col8_1*2 ;
% 
% %13 bbit input
% col1_13 = col1_12*2 ;
% col2_13 = col2_12*2 ;
% col3_13 = col3_12*2 ;
% col4_13 = col4_12*2 ;
% col5_13 = col5_12*2 ;
% col6_13 = col6_12*2 ;
% col7_13 = col7_12*2;
% col8_13 = col8_12*2 ;
% col1_1_13 = col1_1_12*2 ;
% col2_1_13 = col2_1_12*2 ;
% col3_1_13 = col3_1_12*2 ;
% col4_1_13 = col4_1_12*2 ;
% col5_1_13 = col5_1_12*2 ;
% col6_1_13 = col6_1_12*2 ;
% col7_1_13 = col7_1_12*2;
% col8_1_13 = col8_1_12*2 ;
% %14 bit inpput 
% col1_14 = col1_13*2 ;
% col2_14 = col2_13*2 ;
% col3_14 = col3_13*2 ;
% col4_14 = col4_13*2 ;
% col5_14 = col5_13*2 ;
% col6_14 = col6_13*2 ;
% col7_14 = col7_13*2;
% col8_14 = col8_13*2 ;
% col1_1_14 = col1_1_13*2 ;
% col2_1_14 = col2_1_13*2 ;
% col3_1_14 = col3_1_13*2 ;
% col4_1_14 = col4_1_13*2 ;
% col5_1_14 = col5_1_13*2 ;
% col6_1_14 = col6_1_13*2 ;
% col7_1_14 = col7_1_13*2;
% col8_1_14 = col8_1_13*2 ;
% %15 bit input 
% col1_15 = col1_14*2 ;
% col2_15 = col2_14*2 ;
% col3_15 = col3_14*2 ;
% col4_15 = col4_14*2 ;
% col5_15 = col5_14*2 ;
% col6_15 = col6_14*2 ;
% col7_15 = col7_14*2;
% col8_15 = col8_14*2 ;
% col1_1_15 = col1_1_14*2 ;
% col2_1_15 = col2_1_14*2 ;
% col3_1_15 = col3_1_14*2 ;
% col4_1_15 = col4_1_14*2 ;
% col5_1_15 = col5_1_14*2 ;
% col6_1_15 = col6_1_14*2 ;
% col7_1_15 = col7_1_14*2;
% col8_1_15 = col8_1_14*2 ;
% %16 bit  input 
% col1_16 = col1_15*2 ;
% col2_16 = col2_15*2 ;
% col3_16 = col3_15*2 ;
% col4_16 = col4_15*2 ;
% col5_16 = col5_15*2 ;
% col6_16 = col6_15*2 ;
% col7_16 = col7_15*2;
% col8_16 = col8_15*2 ;
% col1_1_16 = col1_1_15*2 ;
% col2_1_16 = col2_1_15*2 ;
% col3_1_16 = col3_1_15*2 ;
% col4_1_16 = col4_1_15*2 ;
% col5_1_16 = col5_1_15*2 ;
% col6_1_16 = col6_1_15*2 ;
% col7_1_16 = col7_1_15*2;
% col8_1_16 = col8_1_15*2 ;
% 
% for i= 1:491520 
%     fprintf(f1,"%d,%d,%d,%d,%d,%d,%d,%d\n",col1_16(i),col2_16(i),col3_16(i),col4_16(i),col5_16(i),col6_16(i),col7_16(i),col8_16(i));
% end
% for i= 1:491520 
%     fprintf(f2,"%d,%d,%d,%d,%d,%d,%d,%d\n",col1_1_16(i),col2_1_16(i),col3_1_16(i),col4_1_16(i),col5_1_16(i),col6_1_16(i),col7_1_16(i),col8_1_16(i));
% end

ddc_data = load('/home/wisig/Downloads/ddc_test/output/ddc_16_out.txt') ; 
ddc_1 = int16(ddc_data( :,1));
n = 491520; % depth of the data 
min_j_values = zeros(1, n);  

% Iterate through the samples
for k = 1:n
    sample = ddc_1(k);
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

